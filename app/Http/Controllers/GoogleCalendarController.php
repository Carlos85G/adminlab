<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Services\GoogleCalendar;
use App\Models\Laboratorio;

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
    public function index(Request $request)
    {
        return $this->getFullCalendarLaboratoryReservations($request);
    }

    /**
     * Función para recuperar los primeros 100 eventos de cada laboratorio, en formato DataTable
     * @return array: La lista de eventos
     */
    public function getDataTableRecentEvents()
    {
        return $this->getDataTableLaboratoryEvents(
            null,
            array(
                'maxResults' => 100
            )
        );
    }

    /**
     * Función para recuperar los eventos de cada laboratorio, en formato FullCalendar, aceptando el objeto Request verificación
     * @param \Illuminate\Http\Request $request: La petición HTTP
     * @param array|int|null $laboratoriosId: IDs de laboratorio en sistema.
     * @return array: La lista de eventos
     */
    public function getFullCalendarLaboratoryReservations(Request $request, $laboratorioId = null)
    {
        $params = array();
        $nombre_timeMin = 'timeMin';
        $nombre_timeMax = 'timeMax';

        /* Verificar si hay fecha de inicio */
        if($request->has('start')){
            $fecha_inicio = \DateTime::createFromFormat(
                'Y-m-d',
                $request->input('start'),
                new \DateTimeZone(
                    \App\Services\GoogleCalendar::getDefaultTimezone()
                )
            );

            $fecha_inicio_c = $fecha_inicio->format('c');

            $params[$nombre_timeMin] = $fecha_inicio_c;
        }

        /* Verificar si hay fecha de fin */
        if($request->has('end')){
            $fecha_fin = \DateTime::createFromFormat(
                'Y-m-d',
                $request->input('end'),
                new \DateTimeZone(
                    \App\Services\GoogleCalendar::getDefaultTimezone()
                )
            );

            $fecha_fin_c = $fecha_fin->format('c');

            $params[$nombre_timeMax] = $fecha_fin_c;
        }

        $eventos = $this->getFullCalendarLaboratoryEvents($laboratorioId, $params);

        return $eventos;
    }

    /**
     * Función privada para recuperar los eventos de todos los laboratorios en orden de inicio
     * @param array|int|null $laboratoriosId: IDs de laboratorio en sistema.
     * @param array $params: Lista de parámetros par enviar a la API de Google
     * @return array(Google_Service_Calendar_Event): La lista de eventos
     */
    private function getLaboratoryEvents($laboratoriosId = null, $params = array())
    {
        $eventosTodos = array();

        /*Definir correctamente colección de laboratorios de acuerdo a la definición de IDs de laboratorio*/
        if(is_array($laboratoriosId)){
            $laboratorios = Laboratorio::find($laboratoriosId);
        }else if(is_null($laboratoriosId)){
            $laboratorios = Laboratorio::all();
        }else{
            $laboratorios = array(
                Laboratorio::find($laboratoriosId)
            );
        }

        foreach($laboratorios as $laboratorio){
            /* Verificar que sólo sean procesados laboratorios encontrados */
            if(!empty($laboratorio)){
                $eventosCrudos = $this->calendario->listEvents($laboratorio->gcalendar_cal_id, $params);

                /* Dar nombre del laboratorio actual, para permanecer consistente */
                array_walk(
                    $eventosCrudos,
                    function($eventoCrudo) use ($laboratorio){
                        $eventoCrudo->setLocation($laboratorio->nombre);
                    }
                );

                $eventosTodos = array_merge(
                    $eventosTodos,
                    $eventosCrudos
                );
            }
        }
        unset($laboratorio);


        /* Ordernar de acuerdo a fecha de inicio */
        usort(
            $eventosTodos,
            function($evento1, $evento2) {
                $returnValue = 0;

                $fecha_inicio_1 = strtotime($evento1->getStart()->getDateTime()); /* getDateTime() retorna string en formato ISO8601 */
                $fecha_inicio_2 = strtotime($evento2->getStart()->getDateTime());

                /* Comparar de acuerdo a fecha de inicio */
                if($fecha_inicio_1 != $fecha_inicio_2){
                    $returnValue = ($fecha_inicio_1 < $fecha_inicio_2)? -1 : 1;
                }

                return $returnValue;
            }
        );

        return $eventosTodos;
    }

    /**
     * Función privada para recuperar datos de eventos en JSON, de acuerdo a un calendario o a todos los calendarios. Formato para FullCalendar
     * @param array|int|null $laboratoriosId: IDs de laboratorio en sistema.
     * @param array $params: Lista de parámetros par enviar a la API de Google
     * @return array(): La lista de eventos en JSON
     */
    private function getFullCalendarLaboratoryEvents($laboratoriosId = null, $params = array())
    {
        $eventos = array();

        $eventosCrudos = $this->getLaboratoryEvents($laboratoriosId, $params);

        foreach($eventosCrudos as $evento){
            $eventos[] = array(
               'id' => $evento->id,
               'title' => $evento->getSummary(),
               'start' => $evento->getStart()->getDateTime(),
               'end' => $evento->getEnd()->getDateTime(),
               'location' => $evento->getLocation()
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
     * Función privada para recuperar los eventos de todos los laboratorios en orden de inicio, con formato para DataTable
     * @return array: La lista de eventos
     * @param array $laboratoriosId: Lista de ids de laboratorio en sistema.
     * @param array $params: Lista de parámetros par enviar a la API de Google
     */
    private function getDataTableLaboratoryEvents($laboratoriosId = null, $params = array())
    {
        $eventos = array(
            'data' => array()
        );

        $eventosTodos = $this->getLaboratoryEvents($laboratoriosId, $params);

        foreach($eventosTodos as $eventoId => $evento){
            $eventos['data'][] = array(
                $eventoId + 1,
                $evento->getSummary(),
                $evento->getLocation()
            );
        }
        unset($eventoId);
        unset($evento);

        return $eventos;
    }
}
