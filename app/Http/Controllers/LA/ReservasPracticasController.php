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

				/* Iniciar petición de búsqueda de materiales escasos */
				$materialesFaltantesFinder = Materiale::query();

				foreach($practica->materiales as $material)
				{
						/* Conseguir el multiplicador: Si es por grupo, multiplicar por uno; si no, multiplicar por la cantidad de participantes */
						$cantidadMultiplicar = ($material->por_grupo)? 1 : ((int) $request->input('participantes'));

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

				/* Obtener materiales escasos */
				$materialesFaltantes = $materialesFaltantesFinder->get();

				/* Iniciar petición de búsqueda de reactivos escasos */
				$reactivosFaltantesFinder = Reactivo::query();

				foreach($practica->reactivos as $reactivo)
				{
						/* Conseguir el multiplicador: Si es por grupo, multiplicar por uno; si no, multiplicar por la cantidad de participantes */
						$cantidadMultiplicar = ($reactivo->por_grupo)? 1 : ((int) $request->input('participantes'));

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

				/* Obtener reactivos escasos */
				$reactivosFaltantes = $reactivosFaltantesFinder->get();

				if($materialesFaltantes->count() < 1 || $reactivosFaltantes->count() < 1){
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
						$material->cantidad -= $cantidadesMateriales[$material->id];
						$material->save();
					}

					$reactivos = Reactivo::find(array_keys($cantidadesReactivos));

					foreach($reactivos as $reactivo)
					{
						$reactivo->cantidad -= $cantidadesReactivos[$reactivo->id];
						$reactivo->save();
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

			$practica = \App\Models\Practica::find($request->input('practica_id'));

			$laboratorio = \App\Models\Laboratorio::find($request->input('laboratorio_id'));

			$reservacion = \App\Models\ReservasPractica::find($id);

			$fechaInicio = date_create_from_format(
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
