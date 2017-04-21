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

Route::get('/api/calendario/eventos/', [
    'as' => 'api_calendario_eventos',
    'uses' => 'GoogleCalendarController@index'
]);

Route::get('/api/calendario/eventos/tabla/', [
    'as' => 'api_calendario_eventos_tabla',
    'uses' => 'GoogleCalendarController@getMostRecent'
]);

/* ================== Homepage + Admin Routes ================== */

require __DIR__.'/admin_routes.php';
