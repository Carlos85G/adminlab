<?php
/**
 * Controller genrated using LaraAdmin
 * Help: http://laraadmin.com
 */

namespace App\Http\Controllers\LA;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Requests;
use Auth;
use DB;
use Validator;
use Datatables;
use Collective\Html\FormFacade as Form;
use Dwij\Laraadmin\Models\Module;
use Dwij\Laraadmin\Models\ModuleFields;
use App\Services\GoogleCalendar;
use Ayudantes;

use App\Models\Practica;
use App\Models\Laboratorio;
use App\Models\Materiale;
use App\Models\Reactivo;
use App\Models\ReservasPractica;
use App\MovimientoMaterial;
use App\MovimientoReactivo;

class ReservasPracticasController extends Controller
{
	public $show_action = true;
	public $view_col = 'practica_id';
	public $listing_cols = ['id', 'practica_id', 'laboratorio_id', 'fecha_inicio', 'fecha_fin', 'solicitante_id', 'participantes', 'gcalendar_event_id'];

	public function __construct() {
		// Field Access of Listing Columns
		if(\Dwij\Laraadmin\Helpers\LAHelper::laravel_ver() == 5.3) {
			$this->middleware(function ($request, $next) {
				$this->listing_cols = ModuleFields::listingColumnAccessScan('ReservasPracticas', $this->listing_cols);
				return $next($request);
			});
		} else {
			$this->listing_cols = ModuleFields::listingColumnAccessScan('ReservasPracticas', $this->listing_cols);
		}
	}

	/**
	 * Display a listing of the ReservasPracticas.
	 *
	 * @return \Illuminate\Http\Response
	 */
	public function index()
	{
		$module = Module::get('ReservasPracticas');

		if(Module::hasAccess($module->id)) {
			return View('la.reservaspracticas.index', [
				'show_actions' => $this->show_action,
				'listing_cols' => $this->listing_cols,
				'module' => $module
			]);
		} else {
            return redirect(config('laraadmin.adminRoute')."/");
        }
	}

	/**
	 * Show the form for creating a new reservaspractica.
	 *
	 * @return \Illuminate\Http\Response
	 */
	public function create()
	{
		//
	}

	/**
	 * Store a newly created reservaspractica in database.
	 *
	 * @param  \Illuminate\Http\Request  $request
	 * @return \Illuminate\Http\Response
	 */
	public function store(Request $request)
	{
		if(Module::hasAccess("ReservasPracticas", "create")) {

			$rules = Module::validateRules("ReservasPracticas", $request);

			$validator = Validator::make($request->all(), $rules);

			if ($validator->fails()) {
				return redirect()->back()->withErrors($validator)->withInput();
			}

			/*Variable para guardar el último error de validación*/
			$error = null;

			$practica = Practica::find($request->input('practica_id'));

			$laboratorio = Laboratorio::find($request->input('laboratorio_id'));

			$fechaHoy = new \DateTime(
				'now',
				new \DateTimeZone(
						Ayudantes::getDefaultTimezone()
				)
			);

			$fechaInicio = \DateTime::createFromFormat(
					'd/m/Y g:i A',
					$request->input('fecha_inicio'),
					new \DateTimeZone(
							Ayudantes::getDefaultTimezone()
					)
			);

			$fechaFin = clone $fechaInicio;

			/*Añadir la duración de la práctica*/
			$fechaFin->add(
					new \DateInterval("PT".$practica->duracion."S")
			);

			/* Verificar si es una práctica que ya pasó, para no verificar cantidades de reactivos actuales ni hacer cambios en la cantidad de reactivos actuales (por cuestiones de historial) */
			$reservaPasada = ($fechaFin <= $fechaHoy);

			/* Alistar diferentes formatos de fechas a usar */
			$fechaInicioYMD = $fechaInicio->format('Y-m-d H:i:s');
			$fechaFinYMD = $fechaFin->format('Y-m-d H:i:s');

			/* Encontrar reservaciones existentes */
			$eventosExistentes = ReservasPractica::encontrarConflictos(
				$laboratorio->id,
				$fechaInicioYMD,
				$fechaFinYMD
			);

			/* Verificar la cuenta de registros */
			$cuentaEventosExistentes = $eventosExistentes->count();

			/* Si no hay eventos en el tiempo indicado, continuar */
			if($cuentaEventosExistentes == 0)
			{
				/* Verificar que haya suficientes reactivos y materiales para la práctica */

				/* Espacio para guardar las cantidades. El key es el ID del material o reacivo y el valor es el valor total a descontar */
				$cantidadesMateriales = array();
				$cantidadesReactivos = array();

				/*Sólo buscar materiales si están definidos en la práctica o si no es una práctica pasada*/
				if($practica->materiales->count() == 0 || $reservaPasada){
					$materialesFaltantes = collect();
				} else {
					/* Iniciar petición de búsqueda de materiales insuficientes */
					$materialesFaltantesFinder = Materiale::query();

					foreach($practica->materiales as $material)
					{
							/* Conseguir el multiplicador: Si es por grupo, multiplicar por uno; si no, multiplicar por la cantidad de participantes */
							$cantidadMultiplicar = ($material->por_grupo == 1)? 1 : ((int) $request->input('participantes'));

							$cantidadTotal = ($material->cantidad * $cantidadMultiplicar);

							/* Guardar cantidad de materiales */
							$cantidadesMateriales[$material->material_id] = $cantidadTotal;

							/* Agregar a la búsqueda el filtro de material que sólo retornará la fila si el material no es suficiente */
							$materialesFaltantesFinder->orWhere(function($query) use ($material, $cantidadTotal){
								$query->where(
									'id',
									$material->material_id
								)->where(
									'cantidad',
									'<',
									$cantidadTotal
								);
							});
					}
					unset($material);

					/* Obtener materiales insuficientes */
					$materialesFaltantes = $materialesFaltantesFinder->get();
				}

				/*Sólo buscar reactivos si están definidos en la práctica o si no es una práctica pasada*/
				if($practica->reactivos->count() == 0 || $reservaPasada){
					$reactivosFaltantes = collect();
				} else {
					/* Iniciar petición de búsqueda de reactivos insuficientes */
					$reactivosFaltantesFinder = Reactivo::query();

					foreach($practica->reactivos as $reactivo)
					{
							/* Conseguir el multiplicador: Si es por grupo, multiplicar por uno; si no, multiplicar por la cantidad de participantes */
							$cantidadMultiplicar = ($reactivo->por_grupo == 1)? 1 : ((int) $request->input('participantes'));

							$cantidadTotal = ($reactivo->cantidad * $cantidadMultiplicar);

							/* Guardar cantidad de reactivos */
							$cantidadesReactivos[$reactivo->reactivo_id] = $cantidadTotal;

							/* Agregar a la búsqueda el filtro de material que sólo retornará la fila si el material no es suficiente */
							$reactivosFaltantesFinder->orWhere(function($query) use ($reactivo, $cantidadTotal){
								$query->where(
									'id',
									$reactivo->reactivo_id
								)->where(
									'cantidad',
									'<',
									$cantidadTotal
								);
							});
					}
					unset($reactivo);

					/* Obtener reactivos insuficientes */
					$reactivosFaltantes = $reactivosFaltantesFinder->get();
				}

				/* Sólo agregar si los materiales y los reactivos son suficientes */
				if(($materialesFaltantes->count() == 0) && ($reactivosFaltantes->count() == 0)){
					/*Agregar con la nueva fecha de fin*/
					$request->request->add(
							[
								'fecha_fin' => $fechaFin->format('d/m/Y g:i A')
							]
					);

					$insert_id = Module::insert("ReservasPracticas", $request);

					/*Ya que la reservación está guardada, será necesario remover las cantidades de materiales y reactivos solicitados*/
					$materiales = Materiale::find(array_keys($cantidadesMateriales));

					foreach($materiales as $material)
					{
						/* Crear nuevo movimiento de material */
						$movimientoMaterial = new MovimientoMaterial();
						$movimientoMaterial->asignable_id = $insert_id;
						$movimientoMaterial->asignable_type = ReservasPractica::class;
						$movimientoMaterial->cantidad = ((float) ($cantidadesMateriales[$material->id] * -1));
						$movimientoMaterial->material_id = $material->id;

						if($reservaPasada){
							/*Sólo guardar el movimiento, pero no hacer cambios a los materiales actuales*/
							$movimientoMaterial->save();
						}else{
							/*Aplicar cambios en el material y guardar movimiento*/
							$movimientoMaterial->efectuarCambio();
						}

					}

					$reactivos = Reactivo::find(array_keys($cantidadesReactivos));

					foreach($reactivos as $reactivo)
					{
						/* Crear nuevo movimiento de reactivo */
						$movimientoReactivo = new MovimientoReactivo();
						$movimientoReactivo->asignable_id = $insert_id;
						$movimientoReactivo->asignable_type = ReservasPractica::class;
						$movimientoReactivo->cantidad = ((float) ($cantidadesReactivos[$reactivo->id] * -1));
						$movimientoReactivo->reactivo_id = $reactivo->id;

						if($reservaPasada){
							/*Sólo guardar el movimiento, pero no hacer cambios a los reactivos actuales*/
							$movimientoReactivo->save();
						}else{
							/*Aplicar cambios en el reactivo y guardar movimiento*/
							$movimientoReactivo->efectuarCambio();
						}
					}
				} else {
					$error = 'El sistema no cuenta con los suficientes materiales y/o reactivos.';
				}
			} else {
				$error = $cuentaEventosExistentes.' registro(s) existente(s) en el horario solicitado.';
			}

			Ayudantes::flashMessages($error, 'creado');

			return redirect()->route(config('laraadmin.adminRoute') . '.reservaspracticas.index');

		} else {
			return redirect(config('laraadmin.adminRoute')."/");
		}
	}

	/**
	 * Display the specified reservaspractica.
	 *
	 * @param  int  $id
	 * @return \Illuminate\Http\Response
	 */
	public function show($id)
	{
		if(Module::hasAccess("ReservasPracticas", "view")) {

			$reservaspractica = ReservasPractica::find($id);
			if(isset($reservaspractica->id)) {
				$module = Module::get('ReservasPracticas');
				$module->row = $reservaspractica;

				return view('la.reservaspracticas.show', [
					'module' => $module,
					'view_col' => $this->view_col,
					'no_header' => true,
					'no_padding' => "no-padding"
				])->with('reservaspractica', $reservaspractica);
			} else {
				return view('errors.404', [
					'record_id' => $id,
					'record_name' => ucfirst("reservaspractica"),
				]);
			}
		} else {
			return redirect(config('laraadmin.adminRoute')."/");
		}
	}

	/**
	 * Show the form for editing the specified reservaspractica.
	 *
	 * @param  int  $id
	 * @return \Illuminate\Http\Response
	 */
	public function edit($id)
	{
		if(Module::hasAccess("ReservasPracticas", "edit")) {
			$reservaspractica = ReservasPractica::find($id);
			if(isset($reservaspractica->id)) {
				$module = Module::get('ReservasPracticas');

				$module->row = $reservaspractica;

				return view('la.reservaspracticas.edit', [
					'module' => $module,
					'view_col' => $this->view_col,
				])->with('reservaspractica', $reservaspractica);
			} else {
				return view('errors.404', [
					'record_id' => $id,
					'record_name' => ucfirst("reservaspractica"),
				]);
			}
		} else {
			return redirect(config('laraadmin.adminRoute')."/");
		}
	}

	/**
	 * Update the specified reservaspractica in storage.
	 *
	 * @param  \Illuminate\Http\Request  $request
	 * @param  int  $id
	 * @return \Illuminate\Http\Response
	 */
	public function update(Request $request, $id)
	{
		if(Module::hasAccess("ReservasPracticas", "edit")) {

			$rules = Module::validateRules("ReservasPracticas", $request, true);

			$validator = Validator::make($request->all(), $rules);

			if ($validator->fails()) {
				return redirect()->back()->withErrors($validator)->withInput();;
			}

			/*Variable para guardar el último error de validación*/
			$error = null;

			$practica = Practica::find($request->input('practica_id'));

			$laboratorio = Laboratorio::find($request->input('laboratorio_id'));

			$reservacion = ReservasPractica::find($id);

			$fechaHoy = new \DateTime(
				'now',
				new \DateTimeZone(
						Ayudantes::getDefaultTimezone()
				)
			);

			$fechaInicio = \DateTime::createFromFormat(
					'd/m/Y g:i A',
					$request->input('fecha_inicio'),
					new \DateTimeZone(
							Ayudantes::getDefaultTimezone()
					)
			);

			$fechaFin = clone $fechaInicio;

			/*Añadir la duración de la práctica*/
			$fechaFin->add(
					new \DateInterval("PT".$practica->duracion."S")
			);

			/* Recuperar la fecha de fin original para comparación */
			$fechaFinOriginal = \DateTime::createFromFormat(
				'Y-m-d H:i:s',
				$reservacion->fecha_fin,
				new \DateTimeZone(
						Ayudantes::getDefaultTimezone()
				)
			);

			/* Verificar si la fecha de fin original era en el pasado */
			$reservaOriginalPasada = ($fechaFinOriginal <= $fechaHoy);

			/* Verificar si la fecha de fin solicitada es en el pasado */
			$reservaNuevaPasada = ($fechaFin <= $fechaHoy);

			/* Generar diferentes formatos de fechas para uso */
			$fechaInicioYMD = $fechaInicio->format('Y-m-d H:i:s');
			$fechaFinYMD = $fechaFin->format('Y-m-d H:i:s');

			/* Encontrar reservaciones existentes */
			$eventosExistentes = ReservasPractica::encontrarConflictos(
				$laboratorio->id,
				$fechaInicioYMD,
				$fechaFinYMD
			);

			/*Excluir la actual*/
			$eventosExistentes = $eventosExistentes->filter(function($v, $k) use ($id){
				return ($v->id != $id);
			});

			/* Verificar la cuenta de registros */
			$cuentaEventosExistentes = $eventosExistentes->count();

			/* Si no hay eventos en el tiempo indicado, actualizar */
			if($cuentaEventosExistentes == 0)
			{
					/* Si el usuario hace cambios de la cantidad de participantes, entonces hay que cambiar la cantidad de reactivos, pero sólo si es una práctica nueva */


					/*
					Como es supuesto que la reservación ya hizo cambios al sistema, no es necesario modificar los registros actuales de materiales o reactivos.

					En caso que el usuario quiera volver a hacer una práctica pasada, tendrá que registrar una nueva práctica.

					El siguiente código es vestigial, en caso de necesitar efectuar cambios.

 					if($reservaOriginalPasada == $reservaNuevaPasada){
						La reservación se mantiene como pasada o futura...
					}else if($reservaNuevaPasada){
						La reservación es movida al pasado...
					}else{
						La reservación es movida al futuro...
					}
					*/

					/*Actualizar con la nueva fecha de fin*/
					$request->request->add(
							[
								'fecha_fin' => $fechaFin->format('d/m/Y g:i A')
							]
					);

					$insert_id = Module::updateRow("ReservasPracticas", $request, $id);
			}else{
					$error = $cuentaEventosExistentes.' registro(s) existente(s) en el horario solicitado.';
			}

			Ayudantes::flashMessages($error, 'actualizado');

			return redirect()->route(config('laraadmin.adminRoute') . '.reservaspracticas.index');

		} else {
			return redirect(config('laraadmin.adminRoute')."/");
		}
	}

	/**
	 * Remove the specified reservaspractica from storage.
	 *
	 * @param  int  $id
	 * @return \Illuminate\Http\Response
	 */
	public function destroy($id)
	{
		if(Module::hasAccess("ReservasPracticas", "delete")) {

			/*Variable para guardar el último error de validación*/
			$error = null;

			$reservacion = ReservasPractica::find($id);

			$fechaHoy = new \DateTime(
				'now',
				new \DateTimeZone(
						Ayudantes::getDefaultTimezone()
				)
			);

			$fechaFin = \DateTime::createFromFormat(
					'Y-m-d H:i:s',
					$reservacion->fecha_fin,
					new \DateTimeZone(
							Ayudantes::getDefaultTimezone()
					)
			);

			/* Verificar si la práctica a eliminar es una práctica pasada (que ya finalizó) y evitar que al eliminar se haga cambios a las cantidades actuales de reactivos y materiales */
			$reservaPasada = ($fechaHoy >= $fechaFin);

			/* Deshacer los movimientos de materiales*/
			foreach($reservacion->movimientosMateriales as $movimientoMaterial)
			{
				if($reservaPasada)
				{
					/* La práctica ya fue realizada. No deshacer cambios en cantidades, pero eliminar los movimientos de los materiales */
					$movimientoMaterial->delete();

				} else {
					/* La práctica no ha sido finalizada: Todavía pueden revertirse los cambios solicitados */
					$movimientoMaterial->deshacerCambio();
				}
			}
			unset($movimientoMaterial);

			/* Deshacer los movimientos de reactivos*/
			foreach($reservacion->movimientosReactivos as $movimientoReactivo)
			{
				if($reservaPasada)
				{
					/* La práctica ya fue realizada. No deshacer cambios en cantidades, pero eliminar los movimientos de los reactivos */
					$movimientoReactivo->delete();

				} else {
					/* La práctica no ha sido finalizada: Todavía pueden revertirse los cambios solicitados */
					$movimientoReactivo->deshacerCambio();
				}
			}
			unset($movimientoReactivo);

			/* Eliminar reservación */
			$reservacion->delete();

			Ayudantes::flashMessages($error, 'eliminado');

			// Redirecting to index() method
			return redirect()->route(config('laraadmin.adminRoute') . '.reservaspracticas.index');
		} else {
			return redirect(config('laraadmin.adminRoute')."/");
		}
	}

	/**
	 * Datatable Ajax fetch
	 *
	 * @return
	 */
	public function dtajax()
	{
		$values = DB::table('reservaspracticas')->select($this->listing_cols)->whereNull('deleted_at');
		$out = Datatables::of($values)->make();
		$data = $out->getData();

		$fields_popup = ModuleFields::getModuleFields('ReservasPracticas');

		for($i=0; $i < count($data->data); $i++) {
			for ($j=0; $j < count($this->listing_cols); $j++) {
				$col = $this->listing_cols[$j];
				if($fields_popup[$col] != null && starts_with($fields_popup[$col]->popup_vals, "@")) {
					$data->data[$i][$j] = ModuleFields::getFieldValue($fields_popup[$col], $data->data[$i][$j]);
				}
				if($col == $this->view_col) {
					$data->data[$i][$j] = '<a href="'.url(config('laraadmin.adminRoute') . '/reservaspracticas/'.$data->data[$i][0]).'">'.$data->data[$i][$j].'</a>';
				}
				// else if($col == "author") {
				//    $data->data[$i][$j];
				// }
			}

			if($this->show_action) {
				$output = '';
				if(Module::hasAccess("ReservasPracticas", "edit")) {
					$output .= '<a href="'.url(config('laraadmin.adminRoute') . '/reservaspracticas/'.$data->data[$i][0].'/edit').'" class="btn btn-warning btn-xs" style="display:inline;padding:2px 5px 3px 5px;"><i class="fa fa-edit"></i></a>';
				}

				if(Module::hasAccess("ReservasPracticas", "delete")) {
					$output .= Form::open(['route' => [config('laraadmin.adminRoute') . '.reservaspracticas.destroy', $data->data[$i][0]], 'method' => 'delete', 'style'=>'display:inline']);
					$output .= ' <button class="btn btn-danger btn-xs" type="submit"><i class="fa fa-times"></i></button>';
					$output .= Form::close();
				}
				$data->data[$i][] = (string)$output;
			}
		}
		$out->setData($data);
		return $out;
	}
}
