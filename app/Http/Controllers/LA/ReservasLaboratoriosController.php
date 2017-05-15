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
use App\Models\Laboratorio;
use App\Models\Reserva;
use App\Models\ReservasLaboratorio;

class ReservasLaboratoriosController extends Controller
{
	public $show_action = true;
	public $view_col = 'laboratorio_id';
	public $listing_cols = ['id', 'laboratorio_id', 'fecha_inicio', 'fecha_fin', 'solicitante_id'];

	public function __construct() {
		// Field Access of Listing Columns
		if(\Dwij\Laraadmin\Helpers\LAHelper::laravel_ver() == 5.3) {
			$this->middleware(function ($request, $next) {
				$this->listing_cols = ModuleFields::listingColumnAccessScan('ReservasLaboratorios', $this->listing_cols);
				return $next($request);
			});
		} else {
			$this->listing_cols = ModuleFields::listingColumnAccessScan('ReservasLaboratorios', $this->listing_cols);
		}
	}

	/**
	 * Display a listing of the ReservasLaboratorios.
	 *
	 * @return \Illuminate\Http\Response
	 */
	public function index()
	{
		$module = Module::get('ReservasLaboratorios');

		if(Module::hasAccess($module->id)) {
			return View('la.reservaslaboratorios.index', [
				'show_actions' => $this->show_action,
				'listing_cols' => $this->listing_cols,
				'module' => $module
			]);
		} else {
            return redirect(config('laraadmin.adminRoute')."/");
        }
	}

	/**
	 * Show the form for creating a new reservaslaboratorio.
	 *
	 * @return \Illuminate\Http\Response
	 */
	public function create()
	{
		//
	}

	/**
	 * Store a newly created reservaslaboratorio in database.
	 *
	 * @param  \Illuminate\Http\Request  $request
	 * @return \Illuminate\Http\Response
	 */
	public function store(Request $request)
	{
		if(Module::hasAccess("ReservasLaboratorios", "create")) {

			$rules = Module::validateRules("ReservasLaboratorios", $request);

			$validator = Validator::make($request->all(), $rules);

			if ($validator->fails()) {
				return redirect()->back()->withErrors($validator)->withInput();
			}

			/*Variable para guardar el último error de validación*/
			$error = null;

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

			/* Revisar sólo si las fechas de inicio y fin están congruentemente una después de la otra */
			if($fechaInicio < $fechaFin)
			{
				/* Encontrar reservaciones existentes */
				$eventosExistentes = Reserva::encontrarConflictos(
					$request->input('laboratorio_id'),
					$fechaInicio->format('Y-m-d H:i:s'),
					$fechaFin->format('Y-m-d H:i:s')
				);

				/* Verificar la cuenta de registros */
				$cuentaEventosExistentes = $eventosExistentes->count();

				/* Si no hay eventos en el tiempo indicado, continuar */
				if($cuentaEventosExistentes == 0)
				{
					/* Verificar que el usuario puede pedir prestado el laboratorio por la cantidad de tiempo solicitado */

					/* Hacer restricciones de acuerdo a usuario autenticado */
					$rolFinder = DB::table('roles')
						->join('role_user', 'role_user.role_id', '=', 'roles.id')
						->join('users', 'role_user.user_id', '=', 'users.id')
						->select('roles.id')->where('users.id', Auth::user()->id)->first();

					$rol = Role::find($rolFinder->id);
				
					/* Calcular diferencia entre fecha de inicio y de fin */
					$diferenciaTiempo = $fechaFin->getTimestamp() - $fechaInicio->getTimestamp();

					/* Ajustar para usuarios con privilegios administrativos */
					$limiteSegundos = (($rol->dias_max_laboratorio < 0)? ($diferenciaTiempo + 1) : $rol->dias_max_laboratorio) * 86400;

					if($diferenciaTiempo > $limiteSegundos){
						$error = 'Su usuario no permite reservar por un tiempo mayor a '.$rol->dias_max_laboratorio.' días';
					} else {
						$request->request->add(
								[
									'reserva_type' => ReservasLaboratorio::class
								]
						);

						$insert_id = Module::insert("ReservasLaboratorios", $request);
					}
				} else {
					$error = $cuentaEventosExistentes.' registro(s) existente(s) en el horario solicitado.';
				}
			} else {
				$error = 'La Fecha de Fin tiene que ser después que la Fecha de Inicio.';
			}

			Ayudantes::flashMessages($error, 'creado');

			return redirect()->route(config('laraadmin.adminRoute') . '.reservaslaboratorios.index');

		} else {
			return redirect(config('laraadmin.adminRoute')."/");
		}
	}

	/**
	 * Display the specified reservaslaboratorio.
	 *
	 * @param  int  $id
	 * @return \Illuminate\Http\Response
	 */
	public function show($id)
	{
		if(Module::hasAccess("ReservasLaboratorios", "view")) {

			$reservaslaboratorio = ReservasLaboratorio::find($id);
			if(isset($reservaslaboratorio->id)) {
				$module = Module::get('ReservasLaboratorios');
				$module->row = $reservaslaboratorio;

				return view('la.reservaslaboratorios.show', [
					'module' => $module,
					'view_col' => $this->view_col,
					'no_header' => true,
					'no_padding' => "no-padding"
				])->with('reservaslaboratorio', $reservaslaboratorio);
			} else {
				return view('errors.404', [
					'record_id' => $id,
					'record_name' => ucfirst("reservaslaboratorio"),
				]);
			}
		} else {
			return redirect(config('laraadmin.adminRoute')."/");
		}
	}

	/**
	 * Show the form for editing the specified reservaslaboratorio.
	 *
	 * @param  int  $id
	 * @return \Illuminate\Http\Response
	 */
	public function edit($id)
	{
		if(Module::hasAccess("ReservasLaboratorios", "edit")) {
			$reservaslaboratorio = ReservasLaboratorio::find($id);
			if(isset($reservaslaboratorio->id)) {
				$module = Module::get('ReservasLaboratorios');

				$module->row = $reservaslaboratorio;

				return view('la.reservaslaboratorios.edit', [
					'module' => $module,
					'view_col' => $this->view_col,
				])->with('reservaslaboratorio', $reservaslaboratorio);
			} else {
				return view('errors.404', [
					'record_id' => $id,
					'record_name' => ucfirst("reservaslaboratorio"),
				]);
			}
		} else {
			return redirect(config('laraadmin.adminRoute')."/");
		}
	}

	/**
	 * Update the specified reservaslaboratorio in storage.
	 *
	 * @param  \Illuminate\Http\Request  $request
	 * @param  int  $id
	 * @return \Illuminate\Http\Response
	 */
	public function update(Request $request, $id)
	{
		if(Module::hasAccess("ReservasLaboratorios", "edit")) {

			$rules = Module::validateRules("ReservasLaboratorios", $request, true);

			$validator = Validator::make($request->all(), $rules);

			if ($validator->fails()) {
				return redirect()->back()->withErrors($validator)->withInput();;
			}

			/*Variable para guardar el último error de validación*/
			$error = null;

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
				/* Encontrar reservaciones existentes */
				$eventosExistentes = Reserva::encontrarConflictos(
					$request->input('laboratorio_id'),
					$fechaInicio->format('Y-m-d H:i:s'),
					$fechaFin->format('Y-m-d H:i:s')
				);

				/*Excluir la actual*/
				$eventosExistentes = $eventosExistentes->filter(function($v, $k) use ($id){
					return ($v->id != $id);
				});

				/* Verificar la cuenta de registros */
				$cuentaEventosExistentes = $eventosExistentes->count();

				/* Si no hay eventos en el tiempo indicado, continuar */
				if($cuentaEventosExistentes == 0)
				{
					/* Verificar que el usuario puede pedir prestado el laboratorio por la cantidad de tiempo solicitado */

					/* Hacer restricciones de acuerdo a usuario autenticado */
					$rolFinder = DB::table('roles')
						->join('role_user', 'role_user.role_id', '=', 'roles.id')
						->join('users', 'role_user.user_id', '=', 'users.id')
						->select('roles.id')->where('users.id', Auth::user()->id)->first();

					$rol = Role::find($rolFinder->id);

					/* Calcular diferencia entre fecha de inicio y de fin */
					$diferenciaTiempo = $fechaFin->getTimestamp() - $fechaInicio->getTimestamp();

					/* Ajustar para usuarios con privilegios administrativos */
					$limiteSegundos = (($rol->dias_max_laboratorio < 0)? ($diferenciaTiempo + 1) : $rol->dias_max_laboratorio) * 86400;

					if($diferenciaTiempo > $limiteSegundos){
						$error = 'Su usuario no permite reservar por un tiempo mayor a '.$rol->dias_max_laboratorio.' días';
					} else {
						$insert_id = Module::updateRow("ReservasLaboratorios", $request, $id);
					}
				} else {
					$error = $cuentaEventosExistentes.' registro(s) existente(s) en el horario solicitado.';
				}
			} else {
				$error = 'La Fecha de Fin tiene que ser después que la Fecha de Inicio.';
			}

			Ayudantes::flashMessages($error, 'actualizado');

			return redirect()->route(config('laraadmin.adminRoute') . '.reservaslaboratorios.index');

		} else {
			return redirect(config('laraadmin.adminRoute')."/");
		}
	}

	/**
	 * Remove the specified reservaslaboratorio from storage.
	 *
	 * @param  int  $id
	 * @return \Illuminate\Http\Response
	 */
	public function destroy($id)
	{
		if(Module::hasAccess("ReservasLaboratorios", "delete")) {
			ReservasLaboratorio::find($id)->delete();

			// Redirecting to index() method
			return redirect()->route(config('laraadmin.adminRoute') . '.reservaslaboratorios.index');
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
		$values = DB::table('reservas')->select($this->listing_cols)->whereNull('deleted_at')->where('reserva_type', ReservasLaboratorio::class);

		/* Si no es administrador, sólo mostrar las del usuario */
		if(!(Entrust::hasRole("SUPER_ADMIN") || Entrust::hasRole("LabAdmin"))){
			$values->where('solicitante_id', Auth::user()->id);
		}

		$out = Datatables::of($values)->make();
		$data = $out->getData();

		$fields_popup = ModuleFields::getModuleFields('ReservasLaboratorios');

		for($i=0; $i < count($data->data); $i++) {
			for ($j=0; $j < count($this->listing_cols); $j++) {
				$col = $this->listing_cols[$j];
				if($fields_popup[$col] != null && starts_with($fields_popup[$col]->popup_vals, "@")) {
					$data->data[$i][$j] = ModuleFields::getFieldValue($fields_popup[$col], $data->data[$i][$j]);
				}
				if($col == $this->view_col) {
					$data->data[$i][$j] = '<a href="'.url(config('laraadmin.adminRoute') . '/reservaslaboratorios/'.$data->data[$i][0]).'">'.$data->data[$i][$j].'</a>';
				}
				// else if($col == "author") {
				//    $data->data[$i][$j];
				// }
			}

			if($this->show_action) {
				$output = '';
				if(Module::hasAccess("ReservasLaboratorios", "edit")) {
					$output .= '<a href="'.url(config('laraadmin.adminRoute') . '/reservaslaboratorios/'.$data->data[$i][0].'/edit').'" class="btn btn-warning btn-xs" style="display:inline;padding:2px 5px 3px 5px;"><i class="fa fa-edit"></i></a>';
				}

				if(Module::hasAccess("ReservasLaboratorios", "delete")) {
					$output .= Form::open(['route' => [config('laraadmin.adminRoute') . '.reservaslaboratorios.destroy', $data->data[$i][0]], 'method' => 'delete', 'style'=>'display:inline']);
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
