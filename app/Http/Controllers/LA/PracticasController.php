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

use App\Models\Practica;
use App\PracticaMaterial;
use App\PracticaReactivo;

class PracticasController extends Controller
{
	public $show_action = true;
	public $view_col = 'nombre';
	public $listing_cols = ['id', 'nombre', 'objetivo', 'duracion', 'practica_pdf'];

	public function __construct() {
		// Field Access of Listing Columns
		if(\Dwij\Laraadmin\Helpers\LAHelper::laravel_ver() == 5.3) {
			$this->middleware(function ($request, $next) {
				$this->listing_cols = ModuleFields::listingColumnAccessScan('Practicas', $this->listing_cols);
				return $next($request);
			});
		} else {
			$this->listing_cols = ModuleFields::listingColumnAccessScan('Practicas', $this->listing_cols);
		}
	}

	/**
	 * Display a listing of the Practicas.
	 *
	 * @return \Illuminate\Http\Response
	 */
	public function index()
	{
		$module = Module::get('Practicas');

		if(Module::hasAccess($module->id)) {
			return View('la.practicas.index', [
				'show_actions' => $this->show_action,
				'listing_cols' => $this->listing_cols,
				'module' => $module
			]);
		} else {
            return redirect(config('laraadmin.adminRoute')."/");
        }
	}

	/**
	 * Show the form for creating a new practica.
	 *
	 * @return \Illuminate\Http\Response
	 */
	public function create()
	{
		//
	}

	/**
	 * Store a newly created practica in database.
	 *
	 * @param  \Illuminate\Http\Request  $request
	 * @return \Illuminate\Http\Response
	 */
	public function store(Request $request)
	{
		if(Module::hasAccess("Practicas", "create")) {

			$rules = Module::validateRules("Practicas", $request);

			/* Reglas adicionales para los selectores de tiempo */
			$rules = array_merge(
				$rules,
				array(
					'horas' => 'integer|required|min:0',
					'minutos' => 'integer|required|between:0,59'
				)
			);

			/* Creando reglas de validación para los materiales */
			$practicamaterial_size = ($request->has('practicamaterial'))? count($request->get('practicamaterial')) : 0;

			$rules = array_merge(
				$rules,
				array(
					'practicamaterial' => 'array',
					'practicamaterial.*' => 'numeric|distinct|exists:materiales,id',
					'practicamaterial_cantidad' => 'array|size:' . $practicamaterial_size,
					'practicamaterial_cantidad.*' => 'numeric|integer|min:1',
					'practicamaterial_por_grupo' => 'array',
					'practicamaterial_por_grupo.*' => 'filled'
				)
			);

			/* Creando reglas de validación para los reactivos */
			$practicareactivo_size = ($request->has('practicareactivo'))? count($request->get('practicareactivo')) : 0;

			$rules = array_merge(
				$rules,
				array(
					'practicareactivo' => 'array',
					'practicareactivo.*' => 'numeric|distinct|exists:reactivos,id',
					'practicareactivo_cantidad' => 'array|size:' . $practicareactivo_size,
					'practicareactivo_cantidad.*' => 'numeric|min:0.01',
					'practicareactivo_por_grupo' => 'array',
					'practicareactivo_por_grupo.*' => 'filled'
				)
			);

			$validator = Validator::make($request->all(), $rules);

			if ($validator->fails()) {
				return redirect()->back()->withErrors($validator)->withInput();
			}

			$insert_id = Module::insert("Practicas", $request);

			/* La validación ha sido exitosa: actualizar los registros, de acuerdo a lo necesario por cada uno de los materiales y reactivos */

			if($request->has('practicamaterial')){
				foreach($request->get('practicamaterial') as $pMIx => $pM){
					/* No existe. Crear un nuevo material con las características descritas */
					$practicaMaterial = new PracticaMaterial();

					/* Asignar este nuevo PracticaMaterial al ID de la práctica */
					$practicaMaterial->practica_id = $insert_id;

					/* Actualizar los datos de cada uno de los elementos */
					$practicaMaterial->material_id = $pM;
					$practicaMaterial->cantidad = $request->get('practicamaterial_cantidad')[$pMIx];
					$practicaMaterial->por_grupo = ($request->has('practicamaterial_por_grupo.'.$pMIx))? 1 : 0;

					/* Guardar en base de datos */
					$practicaMaterial->save();
				}
				unset($pMIx);
				unset($pM);
			}

			if($request->has('practicareactivo')){
				foreach($request->get('practicareactivo') as $pRIx => $pR){
					/* No existe. Crear un nuevo reactivo con las características descritas */
					$practicaReactivo = new PracticaReactivo();

					/* Asignar este nuevo PracticaReactivo al ID de la práctica */
					$practicaReactivo->practica_id = $insert_id;

					/* Actualizar los datos de cada uno de los elementos */
					$practicaReactivo->reactivo_id = $pR;
					$practicaReactivo->cantidad = $request->get('practicareactivo_cantidad')[$pRIx];
					$practicaReactivo->por_grupo = ($request->has('practicareactivo_por_grupo.'.$pRIx))? 1 : 0;

					/* Guardar en base de datos */
					$practicaReactivo->save();
				}
				unset($pRIx);
				unset($pR);
			}

			Ayudantes::flashMessages(null, 'creado');

			return redirect()->route(config('laraadmin.adminRoute') . '.practicas.index');

		} else {
			return redirect(config('laraadmin.adminRoute')."/");
		}
	}

	/**
	 * Display the specified practica.
	 *
	 * @param  int  $id
	 * @return \Illuminate\Http\Response
	 */
	public function show($id)
	{
		if(Module::hasAccess("Practicas", "view")) {

			$practica = Practica::find($id);
			if(isset($practica->id)) {
				$module = Module::get('Practicas');
				$module->row = $practica;

				return view('la.practicas.show', [
					'module' => $module,
					'view_col' => $this->view_col,
					'no_header' => true,
					'no_padding' => "no-padding"
				])->with('practica', $practica);
			} else {
				return view('errors.404', [
					'record_id' => $id,
					'record_name' => ucfirst("practica"),
				]);
			}
		} else {
			return redirect(config('laraadmin.adminRoute')."/");
		}
	}

	/**
	 * Show the form for editing the specified practica.
	 *
	 * @param  int  $id
	 * @return \Illuminate\Http\Response
	 */
	public function edit($id)
	{
		if(Module::hasAccess("Practicas", "edit")) {
			$practica = Practica::find($id);
			if(isset($practica->id)) {
				$module = Module::get('Practicas');

				$module->row = $practica;

				return view('la.practicas.edit', [
					'module' => $module,
					'view_col' => $this->view_col,
				])->with('practica', $practica);
			} else {
				return view('errors.404', [
					'record_id' => $id,
					'record_name' => ucfirst("practica"),
				]);
			}
		} else {
			return redirect(config('laraadmin.adminRoute')."/");
		}
	}

	/**
	 * Update the specified practica in storage.
	 *
	 * @param  \Illuminate\Http\Request  $request
	 * @param  int  $id
	 * @return \Illuminate\Http\Response
	 */
	public function update(Request $request, $id)
	{
		if(Module::hasAccess("Practicas", "edit")) {

			$rules = Module::validateRules("Practicas", $request, true);

			/* Reglas adicionales para los selectores de tiempo */
			$rules = array_merge(
				$rules,
				array(
					'horas' => 'integer|required|min:0',
					'minutos' => 'integer|required|between:0,59'
				)
			);

			/* Creando reglas de validación para los materiales */
			$practicamaterial_size = ($request->has('practicamaterial'))? count($request->get('practicamaterial')) : 0;

			$rules = array_merge(
				$rules,
				array(
					'practicamaterial' => 'array',
					'practicamaterial.*' => 'numeric|distinct|exists:materiales,id',
					'practicamaterial_cantidad' => 'array|size:' . $practicamaterial_size,
					'practicamaterial_cantidad.*' => 'numeric|integer|min:1',
					'practicamaterial_por_grupo' => 'array',
					'practicamaterial_por_grupo.*' => 'filled'
				)
			);

			/* Creando reglas de validación para los reactivos */
			$practicareactivo_size = ($request->has('practicareactivo'))? count($request->get('practicareactivo')) : 0;

			$rules = array_merge(
				$rules,
				array(
					'practicareactivo' => 'array',
					'practicareactivo.*' => 'numeric|distinct|exists:reactivos,id',
					'practicareactivo_cantidad' => 'array|size:' . $practicareactivo_size,
					'practicareactivo_cantidad.*' => 'numeric|min:0.01',
					'practicareactivo_por_grupo' => 'array',
					'practicareactivo_por_grupo.*' => 'filled'
				)
			);

			$validator = Validator::make($request->all(), $rules);

			if ($validator->fails()) {
				return redirect()->back()->withErrors($validator)->withInput();
			}

			/* La validación ha sido exitosa: actualizar los registros, de acuerdo a lo necesario por cada uno de los materiales y reactivos */

			/* Espacio para IDs de PracticaMateriales a mantener en el sistema. Las que no estén en este arreglo serán eliminadas */
			$idMaterialesActuales = array();

			if($request->has('practicamaterial')){
				foreach($request->get('practicamaterial') as $pMIx => $pM){
					/* Verificar que el índice es numérico. Si lo es, entonces el objeto PracticaMaterial ya existe en la base de datos */
					if(is_numeric($pMIx)){
						/*El PracticaMaterial con este ID será mantenido en el sistema al final de la actualización*/
						$idMaterialesActuales[] = $pM;

						/* Recuperar y actualizar el PracticaMaterial existente*/
						$practicaMaterial = PracticaMaterial::find($pMIx);
					}else{
						/* No existe. Crear un nuevo material con las características descritas */
						$practicaMaterial = new PracticaMaterial();

						/* Asignar este nuevo PracticaMaterial al ID de la práctica */
						$practicaMaterial->practica_id = $id;

						/* Añadir a las IDs a mantener en la actualización */
						$idMaterialesActuales[] = $practicaMaterial->id;
					}

					/* Actualizar los datos de cada uno de los elementos */
					$practicaMaterial->material_id = $pM;
					$practicaMaterial->cantidad = $request->get('practicamaterial_cantidad')[$pMIx];
					$practicaMaterial->por_grupo = ($request->has('practicamaterial_por_grupo.'.$pMIx))? 1 : 0;

					/* Guardar en base de datos */
					$practicaMaterial->save();
				}
				unset($pMIx);
				unset($pM);
			}

			/* Eliminar los PracticaMateriales que no hayan sido especificados */
			PracticaMaterial::where('practica_id', $id)->whereNotIn('id', $idMaterialesActuales)->delete();

			/* Espacio para IDs de PracticaReactivos a mantener en el sistema. Las que no estén en este arreglo serán eliminadas */
			$idReactivosActuales = array();

			if($request->has('practicareactivo')){
				foreach($request->get('practicareactivo') as $pRIx => $pR){
					/* Verificar que el índice es numérico. Si lo es, entonces el objeto PracticaReactivo ya existe en la base de datos */
					if(is_numeric($pRIx)){
						/*El PracticaReactivo con este ID será mantenido en el sistema al final de la actualización*/
						$idReactivosActuales[] = $pR;

						/* Recuperar y actualizar el PracticaReactivo existente*/
						$practicaReactivo = PracticaReactivo::find($pRIx);
					}else{
						/* No existe. Crear un nuevo reactivo con las características descritas */
						$practicaReactivo = new PracticaReactivo();

						/* Asignar este nuevo PracticaReactivo al ID de la práctica */
						$practicaReactivo->practica_id = $id;

						/* Añadir a las IDs a mantener en la actualización */
						$idReactivosActuales[] = $practicaReactivo->id;
					}

					/* Actualizar los datos de cada uno de los elementos */
					$practicaReactivo->reactivo_id = $pR;
					$practicaReactivo->cantidad = $request->get('practicareactivo_cantidad')[$pRIx];
					$practicaReactivo->por_grupo = ($request->has('practicareactivo_por_grupo.'.$pRIx))? 1 : 0;

					/* Guardar en base de datos */
					$practicaReactivo->save();
				}
				unset($pRIx);
				unset($pR);
			}

			/* Eliminar los PracticaReactivos que no hayan sido especificados */
			PracticaReactivo::where('practica_id', $id)->whereNotIn('id', $idReactivosActuales)->delete();


			/* Actualizar datos de práctica */
			$insert_id = Module::updateRow("Practicas", $request, $id);

			Ayudantes::flashMessages(null, 'actualizado');

			return redirect()->route(config('laraadmin.adminRoute') . '.practicas.index');

		} else {
			return redirect(config('laraadmin.adminRoute')."/");
		}
	}

	/**
	 * Remove the specified practica from storage.
	 *
	 * @param  int  $id
	 * @return \Illuminate\Http\Response
	 */
	public function destroy($id)
	{
		if(Module::hasAccess("Practicas", "delete")) {
			Practica::find($id)->delete();
			/* Eliminar definiciones de materiales y reactivos */
			PracticaMaterial::where('practica_id', $id)->delete();
			PracticaReactivo::where('practica_id', $id)->delete();

			Ayudantes::flashMessages(null, 'eliminado');

			// Redirecting to index() method
			return redirect()->route(config('laraadmin.adminRoute') . '.practicas.index');
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
		$values = DB::table('practicas')->select($this->listing_cols)->whereNull('deleted_at');
		$out = Datatables::of($values)->make();
		$data = $out->getData();

		$fields_popup = ModuleFields::getModuleFields('Practicas');

		for($i=0; $i < count($data->data); $i++) {
			for ($j=0; $j < count($this->listing_cols); $j++) {
				$col = $this->listing_cols[$j];
				if($fields_popup[$col] != null && starts_with($fields_popup[$col]->popup_vals, "@")) {
					$data->data[$i][$j] = ModuleFields::getFieldValue($fields_popup[$col], $data->data[$i][$j]);
				}
				if($col == $this->view_col) {
					$data->data[$i][$j] = '<a href="'.url(config('laraadmin.adminRoute') . '/practicas/'.$data->data[$i][0]).'">'.$data->data[$i][$j].'</a>';
				}
				// else if($col == "author") {
				//    $data->data[$i][$j];
				// }
			}

			if($this->show_action) {
				$output = '';
				if(Module::hasAccess("Practicas", "edit")) {
					$output .= '<a href="'.url(config('laraadmin.adminRoute') . '/practicas/'.$data->data[$i][0].'/edit').'" class="btn btn-warning btn-xs" style="display:inline;padding:2px 5px 3px 5px;"><i class="fa fa-edit"></i></a>';
				}

				if(Module::hasAccess("Practicas", "delete")) {
					$output .= Form::open(['route' => [config('laraadmin.adminRoute') . '.practicas.destroy', $data->data[$i][0]], 'method' => 'delete', 'style'=>'display:inline']);
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
