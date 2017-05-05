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

use App\Models\ReservasPractica;

class ReservasPracticasController extends Controller
{
	public $show_action = true;
	public $view_col = 'practica';
	public $listing_cols = ['id', 'practica', 'laboratorio', 'fecha_hora', 'solicitante', 'participantes', 'gcalendar_event_id'];

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

			$calendario = new GoogleCalendar();

			$practica = \App\Models\Practica::find($request->input('practica'));

			$laboratorio = \App\Models\Laboratorio::find($request->input('laboratorio'));

			$fecha_inicio = \DateTime::createFromFormat(
					'd/m/Y g:i A',
					$request->input('fecha_hora'),
					new \DateTimeZone(
							$calendario->getDefaultTimezone()
					)
			);

			$fecha_fin = clone $fecha_inicio;

			/*Añadir la duración de la práctica*/
			$fecha_fin->add(
					new \DateInterval("PT".$practica->duracion."S")
			);

			$fecha_inicio_c = $fecha_inicio->format('c');
			$fecha_fin_c = $fecha_fin->format('c');

			$evento = array(
					'summary' => $practica->nombre,
					'location' => $laboratorio->nombre,
					'start' => $fecha_inicio_c,
					'end'=> $fecha_fin_c
			);


			/* Averiguar si existen eventos en el calendario indicado y, si nos hay, evitar el nuevo evento*/
			$eventosExistentes = $calendario->listEvents(
					$laboratorio->gcalendar_cal_id,
					array(
							'timeMin' => $fecha_inicio_c,
							'timeMax' => $fecha_fin_c
					)
			);

			$cuentaEventosExistentes = count($eventosExistentes);


			/* Si no hay eventos en el tiempo indicado, añadir */
			if($cuentaEventosExistentes == 0)
			{
					/* Tratar de añadir el nuevo evento a GoogleCalendar antes de agregarlo a sistema, para verificar disponibilidad*/
					$nuevoEvento = $calendario->createEvent($laboratorio->gcalendar_cal_id, $evento);

					/* Insertar a la base de datos solamente si el evento fue creado en el calendario en línea*/
					if($nuevoEvento instanceOf \Google_Service_Calendar_Event)
					{
							/*Agregar con el nuevo id de evento remoto*/
							$request->request->add(
									[
											'gcalendar_event_id' => $nuevoEvento->id
									]
							);

							$insert_id = Module::insert("ReservasPracticas", $request);
					} else {
							$error = 'Falló la creación de evento remoto.';
					}
			} else {
				$error = $cuentaEventosExistentes.' registro(s) en el horario.';
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

			/* Tratar de añadir el nuevo evento a GoogleCalendar antes de agregarlo a sistema, para verificar disponibilidad*/
			$calendario = new GoogleCalendar();

			$practica = \App\Models\Practica::find($request->input('practica'));

			$laboratorio = \App\Models\Laboratorio::find($request->input('laboratorio'));

			$reservacion = \App\Models\ReservasPractica::find($id);

			$fecha_inicio = date_create_from_format(
					'd/m/Y g:i A',
					$request->input('fecha_hora'),
					new \DateTimeZone(
							$calendario->getDefaultTimezone()
					)
			);

			$fecha_fin = clone $fecha_inicio;

			/*Añadir la duración de la práctica*/
			$fecha_fin->add(
					new \DateInterval("PT".$practica->duracion."S")
			);

			$evento = array(
					'nombre' => $practica->nombre,
					'laboratorio' => $laboratorio->nombre,
					'fecha_inicio' => $fecha_inicio->format('c'),
					'fecha_fin'=> $fecha_fin->format('c')
			);

			$nuevoEvento = $calendario->updateEvent($laboratorio->gcalendar_cal_id, $reservacion->gcalendar_event_id, $evento);

			/* Insertar a la base de datos solamente si el evento fue creado en el calendario en línea*/
			if($nuevoEvento instanceOf \Google_Service_Calendar_Event)
			{
					$insert_id = Module::updateRow("ReservasPracticas", $request, $id);
			}else{
					$error = 'No pudo actualizarse evento remoto.';
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

			$reservacion = ReservasPractica::find($id);

			$laboratorio = \App\Models\Laboratorio::find($reservacion->laboratorio);

			/*Variable para guardar el último error de validación*/
			$error = null;

			$calendario = new GoogleCalendar();

			$respuestaEvento = $calendario->deleteEvent($laboratorio->gcalendar_cal_id, $reservacion->gcalendar_event_id);

			/* Insertar a la base de datos solamente si el evento fue creado en el calendario en línea*/
			if($respuestaEvento instanceOf \GuzzleHttp\Psr7\Response)
			{
					$reservacion->delete();
			}else{
				$error = 'No pudo eliminarse evento remoto.';
			}

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
