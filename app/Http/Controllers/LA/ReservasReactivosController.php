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
use App\Models\Reactivo;
use App\Models\ReservasReactivo;
use App\MovimientoReactivo;

class ReservasReactivosController extends Controller
{
	public $show_action = true;
	public $view_col = 'reactivo_id';
	public $listing_cols = ['id', 'reactivo_id', 'cantidad', 'fecha_hora', 'solicitante_id'];

	public function __construct() {
		// Field Access of Listing Columns
		if(\Dwij\Laraadmin\Helpers\LAHelper::laravel_ver() == 5.3) {
			$this->middleware(function ($request, $next) {
				$this->listing_cols = ModuleFields::listingColumnAccessScan('ReservasReactivos', $this->listing_cols);
				return $next($request);
			});
		} else {
			$this->listing_cols = ModuleFields::listingColumnAccessScan('ReservasReactivos', $this->listing_cols);
		}
	}

	/**
	 * Display a listing of the ReservasReactivos.
	 *
	 * @return \Illuminate\Http\Response
	 */
	public function index()
	{
		$module = Module::get('ReservasReactivos');

		if(Module::hasAccess($module->id)) {
			return View('la.reservasreactivos.index', [
				'show_actions' => $this->show_action,
				'listing_cols' => $this->listing_cols,
				'module' => $module
			]);
		} else {
            return redirect(config('laraadmin.adminRoute')."/");
        }
	}

	/**
	 * Show the form for creating a new reservasreactivo.
	 *
	 * @return \Illuminate\Http\Response
	 */
	public function create()
	{
		//
	}

	/**
	 * Store a newly created reservasreactivo in database.
	 *
	 * @param  \Illuminate\Http\Request  $request
	 * @return \Illuminate\Http\Response
	 */
	public function store(Request $request)
	{
		if(Module::hasAccess("ReservasReactivos", "create")) {

			$rules = Module::validateRules("ReservasReactivos", $request);

			$validator = Validator::make($request->all(), $rules);

			if ($validator->fails()) {
				return redirect()->back()->withErrors($validator)->withInput();
			}

			/*Variable para guardar el último error de validación*/
			$error = null;

			/* Encontrar el reactivo */
			$reactivo = Reactivo::find($request->input('reactivo_id'));

			/* Verificar si la fecha solicitada está en el pasado o en el futuro */
			$fechaHoy = new \DateTime(
				'now',
				new \DateTimeZone(
						Ayudantes::getDefaultTimezone()
				)
			);

			$fechaHora = \DateTime::createFromFormat(
					'd/m/Y g:i A',
					$request->input('fecha_hora'),
					new \DateTimeZone(
							Ayudantes::getDefaultTimezone()
					)
			);

			$cantidad = $request->input('cantidad');

			/* Verificar si es una reservación de material que ya pasó, para no verificar cantidades de reactivos actuales ni hacer cambios en la cantidad de reactivos actuales (por cuestiones de historial) */
			$reservaPasada = ($fechaHoy > $fechaHora);

			if(!$reservaPasada){
				if($reactivo->cantidad < $cantidad){
					$error = 'No hay suficiente reactivo disponible.';
				}
			}

			/* Si no hay errores, crear reservación */
			if(is_null($error))
			{
				$insert_id = Module::insert("ReservasReactivos", $request);

				/* Crear nuevo movimiento de reactivo */
				$movimientoReactivo = new MovimientoReactivo();
				$movimientoReactivo->asignable_id = $insert_id;
				$movimientoReactivo->asignable_type = ReservasReactivo::class;
				$movimientoReactivo->cantidad = ((float) ($cantidad * -1));
				$movimientoReactivo->reactivo_id = $reactivo->id;

				if($reservaPasada)
				{
					/* Si la reservación se mantiene en el pasado: sólo guardar el movimiento, pero no hacer cambios a los materiales actuales*/
					$movimientoReactivo->save();
				}else{
					/*La reservación es movida al pasado, al futuro o se mantiene en el futuro: aplicar cambios en el material y guardar movimiento*/
					$movimientoReactivo->efectuarCambio();
				}
			}

			Ayudantes::flashMessages($error, 'creado');

			return redirect()->route(config('laraadmin.adminRoute') . '.reservasreactivos.index');

		} else {
			return redirect(config('laraadmin.adminRoute')."/");
		}
	}

	/**
	 * Display the specified reservasreactivo.
	 *
	 * @param  int  $id
	 * @return \Illuminate\Http\Response
	 */
	public function show($id)
	{
		if(Module::hasAccess("ReservasReactivos", "view")) {

			$reservasreactivo = ReservasReactivo::find($id);
			if(isset($reservasreactivo->id)) {
				$module = Module::get('ReservasReactivos');
				$module->row = $reservasreactivo;

				return view('la.reservasreactivos.show', [
					'module' => $module,
					'view_col' => $this->view_col,
					'no_header' => true,
					'no_padding' => "no-padding"
				])->with('reservasreactivo', $reservasreactivo);
			} else {
				return view('errors.404', [
					'record_id' => $id,
					'record_name' => ucfirst("reservasreactivo"),
				]);
			}
		} else {
			return redirect(config('laraadmin.adminRoute')."/");
		}
	}

	/**
	 * Show the form for editing the specified reservasreactivo.
	 *
	 * @param  int  $id
	 * @return \Illuminate\Http\Response
	 */
	public function edit($id)
	{
		if(Module::hasAccess("ReservasReactivos", "edit")) {
			$reservasreactivo = ReservasReactivo::find($id);
			if(isset($reservasreactivo->id)) {
				$module = Module::get('ReservasReactivos');

				$module->row = $reservasreactivo;

				return view('la.reservasreactivos.edit', [
					'module' => $module,
					'view_col' => $this->view_col,
				])->with('reservasreactivo', $reservasreactivo);
			} else {
				return view('errors.404', [
					'record_id' => $id,
					'record_name' => ucfirst("reservasreactivo"),
				]);
			}
		} else {
			return redirect(config('laraadmin.adminRoute')."/");
		}
	}

	/**
	 * Update the specified reservasreactivo in storage.
	 *
	 * @param  \Illuminate\Http\Request  $request
	 * @param  int  $id
	 * @return \Illuminate\Http\Response
	 */
	public function update(Request $request, $id)
	{
		if(Module::hasAccess("ReservasReactivos", "edit")) {

			$rules = Module::validateRules("ReservasReactivos", $request, true);

			$validator = Validator::make($request->all(), $rules);

			if ($validator->fails()) {
				return redirect()->back()->withErrors($validator)->withInput();;
			}


			/*Variable para guardar el último error de validación*/
			$error = null;

			$reservacion = ReservasReactivo::find($id);

			$fechaHoy = new \DateTime(
				'now',
				new \DateTimeZone(
						Ayudantes::getDefaultTimezone()
				)
			);

			$fechaHora = \DateTime::createFromFormat(
					'd/m/Y g:i A',
					$request->input('fecha_hora'),
					new \DateTimeZone(
							Ayudantes::getDefaultTimezone()
					)
			);

			/* Recuperar la fecha y hora original para comparación */
			$fechaHoraOriginal = \DateTime::createFromFormat(
				'Y-m-d H:i:s',
				$reservacion->fecha_hora,
				new \DateTimeZone(
						Ayudantes::getDefaultTimezone()
				)
			);

			/* Verificar si la fecha de fin original era en el pasado */
			$reservaOriginalPasada = ($fechaHoy > $fechaHoraOriginal);

			/* Verificar si la fecha de fin solicitada es en el pasado */
			$reservaNuevaPasada = ($fechaHoy > $fechaHora);

			$cantidad = $request->input('cantidad');

			/* Si el usuario hace cambios de la cantidad solicitada, entonces hay que cambiar la cantidad de reactivos, pero sólo si es una práctica futura */
			if($reservacion->cantidad != $cantidad)
			{
				$diferencia = $cantidad - $reservacion->cantidad;

				/* Crear nuevo movimiento de reactivo */
				$movimientoReactivo = new MovimientoReactivo();
				$movimientoReactivo->asignable_id = $id;
				$movimientoReactivo->asignable_type = ReservasReactivo::class;
				$movimientoReactivo->cantidad = ((float) ($diferencia * -1));
				$movimientoReactivo->reactivo_id = $reservacion->reactivo_id;

				if($reservaOriginalPasada && $reservaNuevaPasada)
				{
					/* Si la reservación se mantiene en el pasado: sólo guardar el movimiento, pero no hacer cambios a los materiales actuales*/
					$movimientoReactivo->save();
				}else{
					/*La reservación es movida al pasado, al futuro o se mantiene en el futuro: aplicar cambios en el material y guardar movimiento*/
					$movimientoReactivo->efectuarCambio();
				}
			}

			$insert_id = Module::updateRow("ReservasReactivos", $request, $id);

			return redirect()->route(config('laraadmin.adminRoute') . '.reservasreactivos.index');

		} else {
			return redirect(config('laraadmin.adminRoute')."/");
		}
	}

	/**
	 * Remove the specified reservasreactivo from storage.
	 *
	 * @param  int  $id
	 * @return \Illuminate\Http\Response
	 */
	public function destroy($id)
	{
		if(Module::hasAccess("ReservasReactivos", "delete")) {
			/*Variable para guardar el último error de validación*/
			$error = null;

			$reservacion = ReservasReactivo::find($id);

			$fechaHoy = new \DateTime(
				'now',
				new \DateTimeZone(
						Ayudantes::getDefaultTimezone()
				)
			);

			$fechaHora = \DateTime::createFromFormat(
					'Y-m-d H:i:s',
					$reservacion->fecha_hora,
					new \DateTimeZone(
							Ayudantes::getDefaultTimezone()
					)
			);

			/* Verificar si la práctica a eliminar es una reservación pasada (que ya finalizó) y evitar que al eliminar se haga cambios a las cantidades actuales de reactivos */
			$reservaPasada = ($fechaHoy > $fechaHora);

			/* Deshacer los movimientos de reactivos*/
			foreach($reservacion->movimientos as $movimientoReactivo)
			{
				if($reservaPasada)
				{
					/* La reservación ya fue realizada. No deshacer cambios en cantidades, pero eliminar los movimientos de los reactivos */
					$movimientoReactivo->delete();

				} else {
					/* La reservación no ha sido finalizada: Todavía pueden revertirse los cambios solicitados */
					$movimientoReactivo->deshacerCambio();
				}
			}
			unset($movimientoReactivo);

			/* Eliminar la reservación */
			$reservacion->delete();

			Ayudantes::flashMessages(null, 'eliminado');
			// Redirecting to index() method
			return redirect()->route(config('laraadmin.adminRoute') . '.reservasreactivos.index');
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
		$values = DB::table('reservasreactivos')->select($this->listing_cols)->whereNull('deleted_at');

		/* Si no es administrador, sólo mostrar las del usuario */
		if(!(Entrust::hasRole("SUPER_ADMIN") || Entrust::hasRole("LabAdmin"))){
			$values->where('solicitante_id', Auth::user()->id);
		}

		$out = Datatables::of($values)->make();
		$data = $out->getData();

		$fields_popup = ModuleFields::getModuleFields('ReservasReactivos');

		for($i=0; $i < count($data->data); $i++) {
			for ($j=0; $j < count($this->listing_cols); $j++) {
				$col = $this->listing_cols[$j];
				if($fields_popup[$col] != null && starts_with($fields_popup[$col]->popup_vals, "@")) {
					$data->data[$i][$j] = ModuleFields::getFieldValue($fields_popup[$col], $data->data[$i][$j]);
				}
				if($col == $this->view_col) {
					$data->data[$i][$j] = '<a href="'.url(config('laraadmin.adminRoute') . '/reservasreactivos/'.$data->data[$i][0]).'">'.$data->data[$i][$j].'</a>';
				}
				// else if($col == "author") {
				//    $data->data[$i][$j];
				// }
			}

			if($this->show_action) {
				$output = '';
				if(Module::hasAccess("ReservasReactivos", "edit")) {
					$output .= '<a href="'.url(config('laraadmin.adminRoute') . '/reservasreactivos/'.$data->data[$i][0].'/edit').'" class="btn btn-warning btn-xs" style="display:inline;padding:2px 5px 3px 5px;"><i class="fa fa-edit"></i></a>';
				}

				if(Module::hasAccess("ReservasReactivos", "delete")) {
					$output .= Form::open(['route' => [config('laraadmin.adminRoute') . '.reservasreactivos.destroy', $data->data[$i][0]], 'method' => 'delete', 'style'=>'display:inline']);
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
