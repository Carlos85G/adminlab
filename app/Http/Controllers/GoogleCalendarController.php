<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Services\GoogleCalendar;

class GoogleCalendarController extends Controller
{
    protected $calendario;

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->calendario = new GoogleCalendar();
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $eventos = array();
        $eventosCrudos = $this->calendario->listEvents();

        foreach($eventosCrudos as $evento){
            $eventos[] = array(
               'id' => $evento->id,
               'title' => $evento->getSummary(),
               'start' => $evento->getStart()->getDateTime(),
               'end' => $evento->getEnd()->getDateTime()
            );
        }
        unset($evento);

        /*
        No hace falta usarlo porque Google sólo envía los primeros 250 eventos

        while(true) {
            foreach ($eventosCrudos->getItems() as $evento) {
                $eventos[] = $evento;
            }
            $pageToken = $eventosCrudos->getNextPageToken();
            if ($pageToken) {
                $optParams = array('pageToken' => $pageToken);
                $eventosCrudos = $calendario->listEvents(null, $optParams);
            } else {
                break;
            }
        }*/

        return $eventos;
    }

    /**
     * Función para recuperar los eventos en orden de inicio, con formato para tabla json
     * @return array: La lista de eventos
     */
    public function getMostRecent()
    {
        $eventos = array(
            'data' => array(),
        );

        $eventosCrudos = $this->calendario->listEvents();

        foreach($eventosCrudos as $eventoId => $evento){
            $eventos['data'][] = array(
              $eventoId + 1,
              $evento->getSummary()
            );
        }
        unset($eventoId);
        unset($evento);

        return $eventos;
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
