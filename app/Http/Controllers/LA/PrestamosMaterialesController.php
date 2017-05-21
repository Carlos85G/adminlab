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
use Ayudantes;
use Zizaco\Entrust\EntrustFacade as Entrust;

use App\Models\Role;
use App\Models\Materiale;
use App\Models\ReservasMateriale;

class PrestamosMaterialesController extends Controller
{
	public $show_action = true;
	public $view_col = 'material_id';
	public $listing_cols = ['id', 'material_id', 'cantidad', 'fecha_inicio', 'fecha_fin', 'solicitante_id', 'lugar'];

	public function __construct() {
		// Field Access of Listing Columns
		if(\Dwij\Laraadmin\Helpers\LAHelper::laravel_ver() == 5.3) {
			$this->middleware(function ($request, $next) {
				$this->listing_cols = ModuleFields::listingColumnAccessScan('ReservasMateriales', $this->listing_cols);
				return $next($request);
			});
		} else {
			$this->listing_cols = ModuleFields::listingColumnAccessScan('ReservasMateriales', $this->listing_cols);
		}
	}

	/**
	 * Display a listing of the ReservasMateriales.
	 *
	 * @return \Illuminate\Http\Response
	 */
	public function index()
	{
		$module = Module::get('ReservasMateriales');

		if(Module::hasAccess($module->id)) {
			return View('la.prestamosmateriales.index', [
				'show_actions' => $this->show_action,
				'listing_cols' => $this->listing_cols,
				'module' => $module
			]);
		} else {
            return redirect(config('laraadmin.adminRoute')."/");
        }
	}

	/**
	 * Show the form for creating a new reservasmateriale.
	 *
	 * @return \Illuminate\Http\Response
	 */
	public function create()
	{
		//
	}

	/**
	 * Store a newly created reservasmateriale in database.
	 *
	 * @param  \Illuminate\Http\Request  $request
	 * @return \Illuminate\Http\Response
	 */
	public function store(Request $request)
	{
		if(Module::hasAccess("ReservasMateriales", "create")) {

			$rules = Module::validateRules("ReservasMateriales", $request);

			$validator = Validator::make($request->all(), $rules);

			if ($validator->fails()) {
				return redirect()->back()->withErrors($validator)->withInput();
			}

			/*Variable para guardar el último error de validación*/
			$error = null;

			/* Encontrar el material */
			$material = Materiale::find($request->input('material_id'));

			/* Verificar que la fecha de fin sea mayor que la fecha de inicio */
			$fechaInicio = \DateTime::createFromFormat(
					'd/m/Y g:i A',
					$request->input('fecha_inicio'),
					new \DateTimeZone(
							Ayudantes::getDefaultTimezone()
					)
			);

			$fechaFin = \DateTime::createFromFormat(
					'd/m/Y g:i A',
					$request->input('fecha_fin'),
					new \DateTimeZone(
							Ayudantes::getDefaultTimezone()
					)
			);

			if($fechaInicio < $fechaFin)
			{
				/* Calcular disponibilidad del material en fechas indicadas */
				$disponibles = $material->cantidad;

				/* Buscar qué reservaciones de material hay en el tiempo y calcular la disponibilidad de acuerdo a la cantidad total y sus peticiones */
				$incidencias = ReservasMateriale::encontrarIncidencias(
					$material->id,
					$fechaInicio->format('Y-m-d H:i:s'),
					$fechaFin->format('Y-m-d H:i:s')
				);

				/* Ciclar para quitar las reservaciones que ya están en sistema de las cantidades actuales */
				$incidencias->each(function($v, $k) use (&$disponibles){
		      $disponibles -= $v->cantidad;
		    });

				/* No dejar que el valor sea menor a 0 */
		    $disponibles = (($disponibles < 0)? 0 : $disponibles);

				if($disponibles >= $request->input('cantidad')){
					/* Verificar que el usuario puede pedir prestado el material por la cantidad de tiempo solicitado */

					/* Hacer restricciones de acuerdo a usuario autenticado */
					$rolFinder = DB::table('roles')
						->join('role_user', 'role_user.role_id', '=', 'roles.id')
						->join('users', 'role_user.user_id', '=', 'users.id')
						->select('roles.id')->where('users.id', Auth::user()->id)->first();

					$rol = Role::find($rolFinder->id);

					/* Calcular diferencia entre fecha de inicio y de fin */
					$diferenciaTiempo = $fechaFin->getTimestamp() - $fechaInicio->getTimestamp();

					/* Ajustar para usuarios con privilegios administrativos */
					$limiteSegundos = (($rol->dias_max_material < 0)? ($diferenciaTiempo + 1) : $rol->dias_max_material) * 86400;

					if($diferenciaTiempo > $limiteSegundos){
						$error = 'Su usuario no permite reservar por un tiempo mayor a '.$rol->dias_max_material.' días';
					} else {
						$insert_id = Module::insert("ReservasMateriales", $request);
					}
				} else {
					$error = 'No hay suficiente material disponible en las fechas solicitadas.';
				}

			} else {
				$error = 'La Fecha de Fin tiene que ser después que la Fecha de Inicio.';
			}

			Ayudantes::flashMessages($error, 'creado');

			return redirect()->route(config('laraadmin.adminRoute') . '.prestamosmateriales.index');

		} else {
			return redirect(config('laraadmin.adminRoute')."/");
		}
	}

	/**
	 * Display the specified reservasmateriale.
	 *
	 * @param  int  $id
	 * @return \Illuminate\Http\Response
	 */
	public function show($id)
	{
		if(Module::hasAccess("ReservasMateriales", "view")) {

			$reservasmateriale = ReservasMateriale::find($id);
			if(isset($reservasmateriale->id)) {
				$module = Module::get('ReservasMateriales');
				$module->row = $reservasmateriale;

				return view('la.prestamosmateriales.show', [
					'module' => $module,
					'view_col' => $this->view_col,
					'no_header' => true,
					'no_padding' => "no-padding"
				])->with('reservasmateriale', $reservasmateriale);
			} else {
				return view('errors.404', [
					'record_id' => $id,
					'record_name' => ucfirst("prestamosmateriale"),
				]);
			}
		} else {
			return redirect(config('laraadmin.adminRoute')."/");
		}
	}

	/**
	 * Show the form for editing the specified reservasmateriale.
	 *
	 * @param  int  $id
	 * @return \Illuminate\Http\Response
	 */
	public function edit($id)
	{
		if(Module::hasAccess("ReservasMateriales", "edit")) {
			$reservasmateriale = ReservasMateriale::find($id);
			if(isset($reservasmateriale->id)) {
				$module = Module::get('ReservasMateriales');

				$module->row = $reservasmateriale;

				return view('la.prestamosmateriales.edit', [
					'module' => $module,
					'view_col' => $this->view_col,
				])->with('reservasmateriale', $reservasmateriale);
			} else {
				return view('errors.404', [
					'record_id' => $id,
					'record_name' => ucfirst("prestamosmateriale"),
				]);
			}
		} else {
			return redirect(config('laraadmin.adminRoute')."/");
		}
	}

	/**
	 * Update the specified reservasmateriale in storage.
	 *
	 * @param  \Illuminate\Http\Request  $request
	 * @param  int  $id
	 * @return \Illuminate\Http\Response
	 */
	public function update(Request $request, $id)
	{
		if(Module::hasAccess("ReservasMateriales", "edit")) {

			$rules = Module::validateRules("ReservasMateriales", $request, true);

			$validator = Validator::make($request->all(), $rules);

			if ($validator->fails()) {
				return redirect()->back()->withErrors($validator)->withInput();;
			}

			/*Variable para guardar el último error de validación*/
			$error = null;

			/* Encontrar el material */
			$material = Materiale::find($request->input('material_id'));

			/* Verificar que la fecha de fin sea mayor que la fecha de inicio */
			$fechaInicio = \DateTime::createFromFormat(
					'd/m/Y g:i A',
					$request->input('fecha_inicio'),
					new \DateTimeZone(
							Ayudantes::getDefaultTimezone()
					)
			);

			$fechaFin = \DateTime::createFromFormat(
					'd/m/Y g:i A',
					$request->input('fecha_fin'),
					new \DateTimeZone(
							Ayudantes::getDefaultTimezone()
					)
			);

			if($fechaInicio < $fechaFin)
			{
				/* Calcular disponibilidad del material en fechas indicadas */
				$disponibles = $material->cantidad;

				/* Buscar qué reservaciones de material hay en el tiempo y calcular la disponibilidad de acuerdo a la cantidad total y sus peticiones */
				$incidencias = ReservasMateriale::encontrarIncidencias(
					$material->id,
					$fechaInicio->format('Y-m-d H:i:s'),
					$fechaFin->format('Y-m-d H:i:s')
				);

				/*Excluir la actual*/
				$incidencias = $incidencias->filter(function($v, $k) use ($id){
					return ($v->id != $id);
				});

				/* Ciclar para quitar las reservaciones que ya están en sistema de las cantidades actuales */
				$incidencias->each(function($v, $k) use (&$disponibles){
		      $disponibles -= $v->cantidad;
		    });

				/* No dejar que el valor sea menor a 0 */
		    $disponibles = (($disponibles < 0)? 0 : $disponibles);

				if($disponibles >= $request->input('cantidad')){
					/* Verificar que el usuario puede pedir prestado el material por la cantidad de tiempo solicitado */

					/* Hacer restricciones de acuerdo a usuario autenticado */
					$rolFinder = DB::table('roles')
						->join('role_user', 'role_user.role_id', '=', 'roles.id')
						->join('users', 'role_user.user_id', '=', 'users.id')
						->select('roles.id')->where('users.id', Auth::user()->id)->first();

					$rol = Role::find($rolFinder->id);

					/* Calcular diferencia entre fecha de inicio y de fin */
					$diferenciaTiempo = $fechaFin->getTimestamp() - $fechaInicio->getTimestamp();

					/* Ajustar para usuarios con privilegios administrativos */
					$limiteSegundos = (($rol->dias_max_material < 0)? ($diferenciaTiempo + 1) : $rol->dias_max_material) * 86400;

					if($diferenciaTiempo > $limiteSegundos){
						$error = 'Su usuario no permite reservar por un tiempo mayor a '.$rol->dias_max_material.' días';
					} else {
						$insert_id = Module::updateRow("ReservasMateriales", $request, $id);
					}
				} else {
					$error = 'No hay suficiente material disponible en las fechas solicitadas.';
				}

			} else {
				$error = 'La Fecha de Fin tiene que ser después que la Fecha de Inicio.';
			}

			Ayudantes::flashMessages($error, 'actualizado');

			return redirect()->route(config('laraadmin.adminRoute') . '.prestamosmateriales.index');

		} else {
			return redirect(config('laraadmin.adminRoute')."/");
		}
	}

	/**
	 * Remove the specified reservasmateriale from storage.
	 *
	 * @param  int  $id
	 * @return \Illuminate\Http\Response
	 */
	public function destroy($id)
	{
		if(Module::hasAccess("ReservasMateriales", "delete")) {
			ReservasMateriale::find($id)->delete();

			Ayudantes::flashMessages(null, 'eliminado');
			// Redirecting to index() method
			return redirect()->route(config('laraadmin.adminRoute') . '.prestamosmateriales.index');
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
		/*Como los préstamos tienen lugar, sólo mostrar las que tienen lugar diferente a vacío*/
		$values = DB::table('reservasmateriales')->select($this->listing_cols)->whereNull('deleted_at')->where('lugar', '!=', '');

		/* Si no es administrador, sólo mostrar las del usuario */
		if(!(Entrust::hasRole("SUPER_ADMIN") || Entrust::hasRole("LabAdmin"))){
			$values->where('solicitante_id', Auth::user()->id);
		}

		$out = Datatables::of($values)->make();
		$data = $out->getData();

		$fields_popup = ModuleFields::getModuleFields('ReservasMateriales');

		for($i=0; $i < count($data->data); $i++) {
			for ($j=0; $j < count($this->listing_cols); $j++) {
				$col = $this->listing_cols[$j];
				if($fields_popup[$col] != null && starts_with($fields_popup[$col]->popup_vals, "@")) {
					$data->data[$i][$j] = ModuleFields::getFieldValue($fields_popup[$col], $data->data[$i][$j]);
				}
				if($col == $this->view_col) {
					$data->data[$i][$j] = '<a href="'.url(config('laraadmin.adminRoute') . '/prestamosmateriales/'.$data->data[$i][0]).'">'.$data->data[$i][$j].'</a>';
				}
				// else if($col == "author") {
				//    $data->data[$i][$j];
				// }
			}

			if($this->show_action) {
				$output = '';
				if(Module::hasAccess("ReservasMateriales", "edit")) {
					$output .= '<a href="'.url(config('laraadmin.adminRoute') . '/prestamosmateriales/'.$data->data[$i][0].'/edit').'" class="btn btn-warning btn-xs" style="display:inline;padding:2px 5px 3px 5px;"><i class="fa fa-edit"></i></a>';
				}

				if(Module::hasAccess("ReservasMateriales", "delete")) {
					$output .= Form::open(['route' => [config('laraadmin.adminRoute') . '.prestamosmateriales.destroy', $data->data[$i][0]], 'method' => 'delete', 'style'=>'display:inline']);
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
