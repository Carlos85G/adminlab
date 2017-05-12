<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It's a breeze. Simply tell Laravel the URIs it should respond to
| and give it the controller to call when that URI is requested.
|
*/

Route::get('/', function () {
    return view('welcome');
});

/* Obtiene todos los eventos de todos los laboratorios, en formato para FullCalendar */
Route::get('/api/calendario/eventos/', [
    'as' => 'api_calendario_eventos',
    'uses' => 'ApiController@index'
]);

/* Obtiene todos los eventos de todos los laboratorios, en formato para DataTable */
Route::get('/api/calendario/eventos/tabla/', [
    'as' => 'api_calendario_eventos_tabla',
    'uses' => 'ApiController@getDataTableRecentEvents'
]);

/* Obtiene todos los eventos del laboratorio especificado, en formato para FullCalendar */
Route::get('/api/calendario/laboratorios/{laboratorioId}/eventos/', [
    'as' => 'api_calendario_laboratorio_eventos',
    'uses' => 'ApiController@getFullCalendarLaboratoryReservations'
]);

/* ================== Homepage + Admin Routes ================== */

require __DIR__.'/admin_routes.php';
