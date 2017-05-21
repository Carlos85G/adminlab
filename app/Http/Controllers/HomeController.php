<?php
/**
 * Controller genrated using LaraAdmin
 * Help: http://laraadmin.com
 */

namespace App\Http\Controllers;

use App\Http\Requests;
use Illuminate\Http\Request;
use App\Services\GoogleCalendar;

/**
 * Class HomeController
 * @package App\Http\Controllers
 */
class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {

    }

    /**
     * Show the application dashboard.
     *
     * @return Response
     */
    public function index()
    {
        $roleCount = \App\Role::count();
    		if($roleCount != 0) {
      			if($roleCount != 0) {
              /* Obtener los labotarorios en el sistema */

              $laboratorios = \App\Models\Laboratorio::all();
      				return view('home')->with('laboratorios', $laboratorios);
      			}
    		} else {
      			return view('errors.error', [
      				'title' => 'Migraci&oacute;n no completada',
      				'message' => 'Por favor, ejecute el comando <code>php artisan db:seed</code> para generar los datos de tabla necesarios.',
      			]);
    		}
    }
}
