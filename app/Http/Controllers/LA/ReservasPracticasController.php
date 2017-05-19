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
use Zizaco\Entrust\EntrustFacade as Entrust;

use App\Models\Practica;
use App\Models\Laboratorio;
use App\Models\Materiale;
use App\Models\Reactivo;
use App\Models\Reserva;
use App\Models\ReservasMateriale;
use App\Models\ReservasPractica;
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
			$eventosExistentes = Reserva::encontrarConflictos(
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
				$materialesFaltantes = 0;

				if(!($practica->materiales->count() == 0 || $reservaPasada))
				{
					foreach($practica->materiales as $material)
					{
						/* Conseguir el multiplicador: Si es por grupo, multiplicar por uno; si no, multiplicar por la cantidad de participantes */
						$cantidadMultiplicar = ($material->por_grupo == 1)? 1 : ((int) $request->input('participantes'));

						$cantidadTotal = ($material->cantidad * $cantidadMultiplicar);

						/* Guardar cantidad requerida de materiales */
						$cantidadesMateriales[$material->material_id] = $cantidadTotal;

						/* Obtener la cantidad disponible total */
						$disponiblesMaterial = $material->material->cantidad;

						/* Revisar la disponibilidad del material en el tiempo solicitado */
						$incidenciasMaterial = ReservasMateriale::encontrarIncidencias(
							$material->id,
							$fechaInicioYMD,
							$fechaFinYMD
						);

						/* Ciclar para quitar las reservaciones que ya están en sistema de las cantidades actuales */
						$incidenciasMaterial->each(function($v, $k) use (&$disponiblesMaterial){
				      $disponiblesMaterial -= $v->cantidad;
				    });

						/* No dejar que el valor sea menor a 0 */
				    $disponiblesMaterial = (($disponiblesMaterial < 0)? 0 : $disponiblesMaterial);

						if($disponiblesMaterial < $cantidadTotal){
							/* Material faltante: Aumentar cantidad de faltantes */
							$materialesFaltantes++;
						}
					}
					unset($material);
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
				if(($materialesFaltantes == 0) && ($reactivosFaltantes->count() == 0)){
					/*Agregar con la nueva fecha de fin*/
					$request->request->add(
							[
								'fecha_fin' => $fechaFin->format('d/m/Y g:i A'),
								'reserva_type' => ReservasPractica::class
							]
					);

					$insert_id = Module::insert("ReservasPracticas", $request);

					/*Ya que la reservación está guardada, será necesario remover las cantidades de materiales y reactivos solicitados*/
					$materiales = Materiale::find(array_keys($cantidadesMateriales));

					foreach($materiales as $material)
					{
						/* Crear una nueva reservación de material */
						$reservacionMaterial = new ReservasMateriale();
						$reservacionMaterial->reserva_id = $insert_id;
						$reservacionMaterial->material_id = $material->id;
						$reservacionMaterial->cantidad = $cantidadesMateriales[$material->id];
						$reservacionMaterial->fecha_inicio = $fechaInicioYMD;
						$reservacionMaterial->fecha_fin = $fechaFinYMD;
						$reservacionMaterial->save();
					}
					unset($material);

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
					unset($reactivo);
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

				/* Para poder mandar información de la práctica a la vista*/
				$practica = Practica::find($reservaspractica->practica_id);
				$modulePractica = Module::get('Practicas');
				$modulePractica->row = $practica;

				return view('la.reservaspracticas.show', [
					'module' => $module,
					'module_practica' => $modulePractica,
					'view_col' => $this->view_col,
					'no_header' => true,
					'no_padding' => "no-padding"
				])->with('reservaspractica', $reservaspractica)->with('practica', $practica);
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
			$eventosExistentes = Reserva::encontrarConflictos(
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
					/* Si el usuario hace cambios de la cantidad de participantes, entonces hay que cambiar la cantidad de reactivos, pero sólo si es una práctica futura */
					if($reservacion->participantes != $request->input('participantes'))
					{
						/* Verificar que haya suficientes reactivos y materiales para la práctica */

						/* Espacio para guardar las cantidades. El key es el ID del material o reacivo y el valor es el valor total a descontar o añadir */
						$cantidadesMateriales = array();
						$cantidadesReactivos = array();

						/* Sólo buscar materiales si están definidos en la práctica */
						$materialesFaltantes = 0;

						if(!($practica->materiales->count() == 0))
						{
							foreach($practica->materiales as $material)
							{
								/* Conseguir el multiplicador: Si es por grupo, multiplicar por uno; si no, multiplicar por la cantidad de participantes */
								$cantidadMultiplicar = ($material->por_grupo == 1)? 1 : ((int) $request->input('participantes'));

								$cantidadTotal = ($material->cantidad * $cantidadMultiplicar);

								/* Guardar cantidad requerida de materiales */
								$cantidadesMateriales[$material->material_id] = $cantidadTotal;

								/* Obtener la cantidad disponible total */
								$disponiblesMaterial = $material->material->cantidad;

								/* Revisar la disponibilidad del material en el tiempo solicitado */
								$incidenciasMaterial = ReservasMateriale::encontrarIncidencias(
									$material->id,
									$fechaInicioYMD,
									$fechaFinYMD
								);

								/*Excluir las incidencias que son de esta práctica*/
								$incidenciasMaterial = $incidenciasMaterial->filter(function($v, $k) use ($id){
									return ($v->reserva_id != $id);
								});

								/* Ciclar para quitar las reservaciones que ya están en sistema de las cantidades actuales */
								$incidenciasMaterial->each(function($v, $k) use (&$disponiblesMaterial){
						      $disponiblesMaterial -= $v->cantidad;
						    });

								/* No dejar que el valor sea menor a 0 */
						    $disponiblesMaterial = (($disponiblesMaterial < 0)? 0 : $disponiblesMaterial);

								if($disponiblesMaterial < $cantidadTotal){
									/* Material faltante: Aumentar cantidad de faltantes */
									$materialesFaltantes++;
								}
							}
							unset($material);
						}

						/* Sólo buscar reactivos si están definidos en la práctica */
						if($practica->reactivos->count() == 0){
							$reactivosFaltantes = collect();
						} else {
							/* Iniciar petición de búsqueda de reactivos insuficientes */
							$reactivosFaltantesFinder = Reactivo::query();

							/* Conseguir movimientos actuales de reactivos para la práctica */
							$movimientosReactivosOriginal = $reservacion->movimientosReactivos;

							foreach($practica->reactivos as $reactivo)
							{
									/* Obtener sólo los movimientos de este reactivo, en el orden del ID */
									$movimientosReactivoOriginal = $movimientosReactivosOriginal->where(
										'reactivo_id',
										$reactivo->id
									)->sortBy(
										'id'
									)->all();

									/* Calcular las diferencias de acuerdo todos los movimientos */
									$cantidadOriginal = 0;

									foreach($movimientosReactivosOriginal as $movimentoReactivoOriginal)
									{
										$cantidadOriginal += $movimentoReactivoOriginal->cantidad;
									}
									unset($movimentoReactivoOriginal);

									/* Para este momento, $cantidadOriginal ya tiene la cantidad sustraída por el sistema antes de esta actualización */

									/* Conseguir el multiplicador: Si es por grupo, multiplicar por uno; si no, multiplicar por la cantidad de participantes */
									$cantidadMultiplicar = ($reactivo->por_grupo == 1)? 1 : ((int) $request->input('participantes'));

									$cantidadTotal = ($reactivo->cantidad * $cantidadMultiplicar);

									/*Calcular diferencia (la cantidad original viene en negativo) entre cantidad pedida y cantidad ya guardada*/
									$cantidadTotal += $cantidadOriginal;

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

						/* Sólo actualizar si los materiales y los reactivos son suficientes */
						if(($materialesFaltantes == 0) && ($reactivosFaltantes->count() == 0)){
							/*Ya que la reservación está guardada, será necesario remover o añadir las cantidades de materiales y reactivos solicitados*/
							$materialesSolicitadosIds = array_keys($cantidadesMateriales);

							$reservacionesMateriales = ReservasMateriale::where(
								'reserva_id',
								$id
							)->get();

							foreach($reservacionesMateriales as $reservacionMaterial){
								/*Si este material ya no es requerido por la práctica, remover la reservación*/
								if(!in_array($reservacionMaterial->material_id, $materialesSolicitadosIds)){
									$reservacionMaterial->delete();
								}else{
									$reservacionMaterial->cantidad = $cantidadesMateriales[$reservacionMaterial->material_id];
									$reservacionMaterial->fecha_inicio = $fechaInicioYMD;
									$reservacionMaterial->fecha_fin = $fechaFinYMD;
									$reservacionMaterial->save();
								}
							}
							unset($reservacionMaterial);

							$reactivos = Reactivo::find(array_keys($cantidadesReactivos));

							foreach($reactivos as $reactivo)
							{
								/* Crear nuevo movimiento de reactivo */
								$movimientoReactivo = new MovimientoReactivo();
								$movimientoReactivo->asignable_id = $id;
								$movimientoReactivo->asignable_type = ReservasPractica::class;
								$movimientoReactivo->cantidad = ((float) ($cantidadesReactivos[$reactivo->id] * -1));
								$movimientoReactivo->reactivo_id = $reactivo->id;

								if($reservaOriginalPasada && $reservaNuevaPasada)
								{
									/* Si la reservació se mantiene en el pasado: sólo guardar el movimiento, pero no hacer cambios a los materiales actuales*/
									$movimientoReactivo->save();
								}else{
									/*La reservación es movida al pasado, al futuro o se mantiene en el futuro: aplicar cambios en el material y guardar movimiento*/
									$movimientoReactivo->efectuarCambio();
								}
							}
							unset($reactivo);
						} else {
							$error = 'El sistema no cuenta con los suficientes materiales y/o reactivos.';
						}
					}

					/* Actualizar sólo si no hay errores */
					if(is_null($error))
					{
						/*Actualizar con la nueva fecha de fin*/
						$request->request->add(
								[
									'fecha_fin' => $fechaFin->format('d/m/Y g:i A')
								]
						);

						$insert_id = Module::updateRow("ReservasPracticas", $request, $id);
					}
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

			/* Eliminar todas las reservaciones de materiales que esta práctica haya creado */
			ReservasMateriale::where('reserva_id', $id)->delete();

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
		$values = DB::table('reservas')->select($this->listing_cols)->whereNull('deleted_at')->where('reserva_type', ReservasPractica::class);

		/* Si no es administrador, sólo mostrar las del usuario */
		if(!(Entrust::hasRole("SUPER_ADMIN") || Entrust::hasRole("LabAdmin"))){
			$values->where('solicitante_id', Auth::user()->id);
		}

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
