<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Ayudantes;
use App\Models\Laboratorio;
use App\Models\ReservasPractica;
use App\Models\ReservasLaboratorio;

class ApiController extends Controller
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
                'max_results' => 100
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
        $nombreTimeMin = 'fecha_inicio';
        $nombreTimeMax = 'fecha_fin';
        $nombreStart = 'start';
        $nombreEnd = 'end';

        /* Verificar si hay fecha de inicio */
        if($request->has($nombreStart)){
            $fechaInicio = \DateTime::createFromFormat(
                'Y-m-d',
                $request->input($nombreStart),
                new \DateTimeZone(
                    Ayudantes::getDefaultTimezone()
                )
            );

            $fechaInicioYMD = $fechaInicio->format('Y-m-d H:i:s');

            $params[$nombreTimeMin] = $fechaInicioYMD;
        }

        /* Verificar si hay fecha de fin */
        if($request->has($nombreEnd)){
            $fechaFin = \DateTime::createFromFormat(
                'Y-m-d',
                $request->input($nombreEnd),
                new \DateTimeZone(
                    Ayudantes::getDefaultTimezone()
                )
            );

            $fechaFinC = $fechaFin->format('Y-m-d H:i:s');

            $params[$nombreTimeMax] = $fechaFinC;
        }

        $eventos = $this->getFullCalendarLaboratoryEvents($laboratorioId, $params);

        return $eventos;
    }

    /**
     * Función privada para recuperar los eventos de todos los laboratorios en orden de inicio
     * @param array|int|null $laboratoriosId: IDs de laboratorio en sistema.
     * @param array $params: Lista de parámetros
     * @return Illuminate\Database\Eloquent\Collection(\App\Models\ReservasPractica): La lista de eventos
     */
    private function getLaboratoryEvents($laboratoriosId = null, $params = array())
    {
        /*$eventosTodos = array();*/
        $peticion = ReservasPractica::query();

        if(!empty($params['fecha_inicio'])){
          $peticion->where(
              'fecha_inicio',
              '>=',
              $params['fecha_inicio']
          );
        }

        if(!empty($params['fecha_fin'])){
          $peticion->where(
            'fecha_fin',
            '<=',
            $params['fecha_fin']
          );
        }

        /*Aplicar filtro de laboratorios*/
        if(is_array($laboratoriosId)){
            $peticion->whereIn(
              'laboratorio_id',
              $laboratoriosId
            );
        }else if(is_numeric($laboratoriosId)){
          $peticion->where(
            'laboratorio_id',
            $laboratoriosId
          );
        }

        /*Aplicar filtro de límite de resultados*/
        if(!empty($params['max_results'])){
          $peticion->take($params['max_results']);
        }

        /* Ordenar de acuerdo a fecha de inicio */
        $peticion->orderBy(
          'fecha_inicio',
          'ASC'
        );

        return $peticion->get();
    }

    /**
     * Función privada para recuperar datos de eventos en JSON, de acuerdo a un calendario o a todos los calendarios. Formato para FullCalendar
     * @param array|int|null $laboratoriosId: IDs de laboratorio en sistema.
     * @param array $params: Lista de parámetros par enviar
     * @return array(): La lista de eventos en JSON
     */
    private function getFullCalendarLaboratoryEvents($laboratoriosId = null, $params = array())
    {
        $eventos = array();

        $eventosCrudos = $this->getLaboratoryEvents($laboratoriosId, $params);

        foreach($eventosCrudos as $evento){
            $eventos[] = array(
               'id' => $evento->id,
               'title' => ($evento instanceof ReservasPractica)? $evento->practica->nombre : $this->reservadoPor($evento->solicitante->name),
               'start' => \DateTime::createFromFormat(
                   'Y-m-d H:i:s',
                   $evento->fecha_inicio,
                   new \DateTimeZone(
                       Ayudantes::getDefaultTimezone()
                   )
               )->format('c'),
               'end' => \DateTime::createFromFormat(
                   'Y-m-d H:i:s',
                   $evento->fecha_fin,
                   new \DateTimeZone(
                       Ayudantes::getDefaultTimezone()
                   )
               )->format('c'),
               'location' => $evento->laboratorio->nombre,
               'url' => url('/reservas/'. (($evento instanceof ReservasPractica)? 'practicas' : 'laboratorios'). '/' .$evento->id)
            );
        }
        unset($evento);

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
                ($evento instanceof ReservasPractica)? $evento->practica->nombre : $this->reservadoPor($evento->solicitante->name),
                $evento->laboratorio->nombre
            );
        }
        unset($eventoId);
        unset($evento);

        return $eventos;
    }

    /**
     * Función de ayuda para informar que es reservación
     * @param string $nombre: Nombre de la persona
     * @return string: Cadena concatenada
     */
    private function reservadoPor($nombre)
    {
      return 'Reservado por '.$nombre;
    }
}
