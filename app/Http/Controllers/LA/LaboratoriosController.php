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

use App\Models\Laboratorio;

class LaboratoriosController extends Controller
{
	public $show_action = true;
	public $view_col = 'nombre';
	public $listing_cols = ['id', 'nombre', 'gcalendar_cal_id'];

	public function __construct() {
		// Field Access of Listing Columns
		if(\Dwij\Laraadmin\Helpers\LAHelper::laravel_ver() == 5.3) {
			$this->middleware(function ($request, $next) {
				$this->listing_cols = ModuleFields::listingColumnAccessScan('Laboratorios', $this->listing_cols);
				return $next($request);
			});
		} else {
			$this->listing_cols = ModuleFields::listingColumnAccessScan('Laboratorios', $this->listing_cols);
		}
	}

	/**
	 * Display a listing of the Laboratorios.
	 *
	 * @return \Illuminate\Http\Response
	 */
	public function index()
	{
		$module = Module::get('Laboratorios');

		if(Module::hasAccess($module->id)) {
			return View('la.laboratorios.index', [
				'show_actions' => $this->show_action,
				'listing_cols' => $this->listing_cols,
				'module' => $module
			]);
		} else {
            return redirect(config('laraadmin.adminRoute')."/");
    }
	}

	/**
	 * Show the form for creating a new laboratorio.
	 *
	 * @return \Illuminate\Http\Response
	 */
	public function create()
	{
		//
	}

	/**
	 * Store a newly created laboratorio in database.
	 *
	 * @param  \Illuminate\Http\Request  $request
	 * @return \Illuminate\Http\Response
	 */
	public function store(Request $request)
	{
		if(Module::hasAccess("Laboratorios", "create")) {

			$rules = Module::validateRules("Laboratorios", $request);

			$validator = Validator::make($request->all(), $rules);

			if ($validator->fails()) {
				return redirect()->back()->withErrors($validator)->withInput();
			}

			/*Variable para guardar el último error de validación*/
			$error = null;

			/* Crear nuevo calendario para eventos separados por el API de Google */
			$calendario = new GoogleCalendar();

			$nuevoLaboratorio = $calendario->createCalendar(
					$request->input('nombre')
			);

			/* Insertar a la base de datos solamente si el calendario fue creado en la cuenta en línea*/
			if($nuevoLaboratorio instanceOf \Google_Service_Calendar_Calendar)
			{

					/* Espacio para valores adicionales */
					$valoresExtras = array(
							'gcalendar_cal_id' => $nuevoLaboratorio->getId()
					);

					/* Recuperar color remotamente (Google es una diva y no pone el color bajo la respuesta inicial) */
					$nuevoLaboratorioDetalles = $calendario->getCalendarFromCalendarList($valoresExtras['gcalendar_cal_id']);

					/* Verificar que fue posible obtener los detalles y, si se pudo, asignar colores */
					if($nuevoLaboratorioDetalles instanceOf \Google_Service_Calendar_CalendarListEntry){
							$valoresExtras['color_frente'] = $nuevoLaboratorioDetalles->getForegroundColor();
							$valoresExtras['color_fondo'] = $nuevoLaboratorioDetalles->getBackgroundColor();
					}

					/*Agregar con el nuevo id de calendario remoto y colores*/
					$request->request->add(
							$valoresExtras
					);
					$insert_id = Module::insert("Laboratorios", $request);
			}
			else
			{
					$error = 'No pudo crearse calendario remoto.';
			}

			Ayudantes::flashMessages($error, 'creado');

			return redirect()->route(config('laraadmin.adminRoute') . '.laboratorios.index');

		} else {
			return redirect(config('laraadmin.adminRoute')."/");
		}
	}

	/**
	 * Display the specified laboratorio.
	 *
	 * @param  int  $id
	 * @return \Illuminate\Http\Response
	 */
	public function show($id)
	{
		if(Module::hasAccess("Laboratorios", "view")) {

			$laboratorio = Laboratorio::find($id);
			if(isset($laboratorio->id)) {
				$module = Module::get('Laboratorios');
				$module->row = $laboratorio;

				return view('la.laboratorios.show', [
					'module' => $module,
					'view_col' => $this->view_col,
					'no_header' => true,
					'no_padding' => "no-padding"
				])->with('laboratorio', $laboratorio);
			} else {
				return view('errors.404', [
					'record_id' => $id,
					'record_name' => ucfirst("laboratorio"),
				]);
			}
		} else {
			return redirect(config('laraadmin.adminRoute')."/");
		}
	}

	/**
	 * Show the form for editing the specified laboratorio.
	 *
	 * @param  int  $id
	 * @return \Illuminate\Http\Response
	 */
	public function edit($id)
	{
		if(Module::hasAccess("Laboratorios", "edit")) {
			$laboratorio = Laboratorio::find($id);
			if(isset($laboratorio->id)) {
				$module = Module::get('Laboratorios');

				$module->row = $laboratorio;

				return view('la.laboratorios.edit', [
					'module' => $module,
					'view_col' => $this->view_col,
				])->with('laboratorio', $laboratorio);
			} else {
				return view('errors.404', [
					'record_id' => $id,
					'record_name' => ucfirst("laboratorio"),
				]);
			}
		} else {
			return redirect(config('laraadmin.adminRoute')."/");
		}
	}

	/**
	 * Update the specified laboratorio in storage.
	 *
	 * @param  \Illuminate\Http\Request  $request
	 * @param  int  $id
	 * @return \Illuminate\Http\Response
	 */
	public function update(Request $request, $id)
	{
		if(Module::hasAccess("Laboratorios", "edit")) {

			$rules = Module::validateRules("Laboratorios", $request, true);

			$validator = Validator::make($request->all(), $rules);

			if ($validator->fails()) {
				return redirect()->back()->withErrors($validator)->withInput();;
			}

			/*Variable para guardar el último error de validación*/
			$error = null;

			$laboratorio = \App\Models\Laboratorio::find($id);

			/* Actualizar el calendario para eventos separados por el API de Google */
			$calendario = new GoogleCalendar();

			$actualizadoLaboratorio = $calendario->updateCalendar(
					$laboratorio->gcalendar_cal_id,
					array(
							'summary' => $request->input('nombre')
					)
			);

			/* Insertar a la base de datos solamente si el calendario fue actualizado en la cuenta en línea*/
			if($actualizadoLaboratorio instanceOf \Google_Service_Calendar_Calendar)
			{
					$insert_id = Module::updateRow("Laboratorios", $request, $id);
			}
			else
			{
					$error = 'No pudo actualizarse calendario remoto.';
			}

			Ayudantes::flashMessages($error, 'actualizado');

			return redirect()->route(config('laraadmin.adminRoute') . '.laboratorios.index');

		} else {
			return redirect(config('laraadmin.adminRoute')."/");
		}
	}

	/**
	 * Remove the specified laboratorio from storage.
	 *
	 * @param  int  $id
	 * @return \Illuminate\Http\Response
	 */
	public function destroy($id)
	{
		if(Module::hasAccess("Laboratorios", "delete")) {

			$laboratorio = Laboratorio::find($id);

			/*Variable para guardar el último error de validación*/
			$error = null;

			$calendario = new GoogleCalendar();

			$respuestaLaboratorio = $calendario->deleteCalendar($laboratorio->gcalendar_cal_id);

			if($respuestaLaboratorio instanceOf \GuzzleHttp\Psr7\Response)
			{
					$laboratorio->delete();
			}else{
				$error = 'No pudo eliminarse calendario remoto.';
			}

			Ayudantes::flashMessages($error, 'eliminado');

			// Redirecting to index() method
			return redirect()->route(config('laraadmin.adminRoute') . '.laboratorios.index');
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
		$values = DB::table('laboratorios')->select($this->listing_cols)->whereNull('deleted_at');
		$out = Datatables::of($values)->make();
		$data = $out->getData();

		$fields_popup = ModuleFields::getModuleFields('Laboratorios');

		for($i=0; $i < count($data->data); $i++) {
			for ($j=0; $j < count($this->listing_cols); $j++) {
				$col = $this->listing_cols[$j];
				if($fields_popup[$col] != null && starts_with($fields_popup[$col]->popup_vals, "@")) {
					$data->data[$i][$j] = ModuleFields::getFieldValue($fields_popup[$col], $data->data[$i][$j]);
				}
				if($col == $this->view_col) {
					$data->data[$i][$j] = '<a href="'.url(config('laraadmin.adminRoute') . '/laboratorios/'.$data->data[$i][0]).'">'.$data->data[$i][$j].'</a>';
				}
				// else if($col == "author") {
				//    $data->data[$i][$j];
				// }
			}

			if($this->show_action) {
				$output = '';
				if(Module::hasAccess("Laboratorios", "edit")) {
					$output .= '<a href="'.url(config('laraadmin.adminRoute') . '/laboratorios/'.$data->data[$i][0].'/edit').'" class="btn btn-warning btn-xs" style="display:inline;padding:2px 5px 3px 5px;"><i class="fa fa-edit"></i></a>';
				}

				if(Module::hasAccess("Laboratorios", "delete")) {
					$output .= Form::open(['route' => [config('laraadmin.adminRoute') . '.laboratorios.destroy', $data->data[$i][0]], 'method' => 'delete', 'style'=>'display:inline']);
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
