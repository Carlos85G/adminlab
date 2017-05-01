<?php namespace App\Services;

use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Config;

class GoogleCalendar {
    protected $client;
    protected $service;
    protected static $timezone = 'America/Mexico_City';

    /*Nombre de la aplicación*/
    protected $nombreAplicacion = 'AdminLab CUValles';

    /* Ubicación de datos de servicio */
    protected $authConfig = '/resources/assets/adminlab-cuvalles.json';

    /* Usuario con privilegios */
    protected $cuentaImpersonar = 'adminlab-cuvalles@adminlab-cuvalles.iam.gserviceaccount.com';

    /* Calendario Principal */
    protected $calendarioPrincipal = 'admlab.cuvalles@gmail.com';

    function __construct() {
        $this->client = new \Google_Client();
        $this->client->setApplicationName($this->nombreAplicacion);

        /*Agregar los ámbitos de Google Calendar*/
        $this->client->setScopes(
            [
                \Google_Service_Calendar::CALENDAR,
                \Google_Service_Calendar::CALENDAR_READONLY
            ]
        );

        $this->client->setHttpClient(
          new \GuzzleHttp\Client([
            'verify' => false
          ])
        );

        /*Simular cuenta usada*/
        $this->client->setSubject($this->cuentaImpersonar);

        $this->service = new \Google_Service_Calendar($this->client);

        /* If we have an access token */
        if (Cache::has('service_token')) {
          $this->client->setAccessToken(Cache::get('service_token'));
        }

        $this->client->setAuthConfig(base_path() . $this->authConfig);

        if ($this->client->isAccessTokenExpired()) {
          $this->client->refreshTokenWithAssertion();
        }

        Cache::forever('service_token', $this->client->getAccessToken());
    }

    /**
     * Función estática para recuperar el valor predeterminado para los calendarios.
     * @return string: Zona horaria ($this->timezone).
     */
    public static function getDefaultTimezone()
    {
        return self::$timezone;
    }

    /**
     * Función para obtener el objeto GoogleCalendar
     * @param string $calendarId: El id del calendario a obtener. El no añadirlo asumirá el calendario principal
     * @return Google_Service_Calendar_Calendar
     */
    public function getCalendar($calendarId = null)
    {
        if(!isset($calendarId)){
            $calendarId = $this->calendarioPrincipal;
        }
        $results = $this->service->calendars->get($calendarId);
        return $results;
    }

    /**
     * Función para crear un nuevo objeto GoogleCalendar
     * @param string $nombre: El nombre que el nuevo calendario secundario tendrá
     * @return Google_Service_Calendar_Calendar
     */
    public function createCalendar($nombre)
    {
        $calendario = new \Google_Service_Calendar_Calendar();
        $calendario->setSummary($nombre);
        $calendario->setTimeZone(
            $this->getDefaultTimezone()
        );
        $results = $this->service->calendars->insert($calendario);
        return $results;
    }

    /**
     * Función para listar todos los calendarios en línea. Útil para saber el color
     * @return array(Google_Service_Calendar_CalendarListEntry)
     */
    public function listCalendarsFromCalendarList()
    {
        $results = $this->service->calendarList->listCalendarList();
        return $results->getItems();
    }

    /**
     * Función para obtener un calendario desde la lista de calendarios en línea. Útil para saber el color
     * @param string $calendarId: El id del calendario a obtener. El no añadirlo asumirá el calendario principal
     * @return Google_Service_Calendar_CalendarListEntry
     */
    public function getCalendarFromCalendarList($calendarId = null)
    {
        if(!isset($calendarId)){
            $calendarId = $this->calendarioPrincipal;
        }
        $results = $this->service->calendarList->get($calendarId);
        return $results;
    }

    /**
     * Función para actualizar un objeto GoogleCalendar
     * @param string $calendarId: El id del calendario a obtener. El no añadirlo asumirá el calendario
     * @param string $data: Los datos nuevos para cambiar en el calendario
     * @return Google_Service_Calendar_Calendar
     */
    public function updateCalendar($calendarId = null, $data =  array())
    {
        $calendario = $this->getCalendar($calendarId);
        $calendario->setSummary($data["summary"]);

        if(isset($data["timezone"])){
            $calendario->setTimeZone(
                $data["timezone"]
            );
        }

        $results = $this->service->calendars->update($calendario->id, $calendario);
        return $results;
    }

    /**
     * Función para eliminar un objeto GoogleCalendar
     * @param string $calendarId: El id del calendario a obtener. El no añadirlo asumirá el calendario
     * @return \GuzzleHttp\Psr7\Response
     */
    public function deleteCalendar($calendarId = null)
    {
        if(!isset($calendarId)){
            $calendarId = $this->calendarioPrincipal;
        }

        $results = $this->service->calendars->delete($calendarId);
        return $results;
    }

    /**
     * Función para obtener los eventos del calendario seleccionado GoogleCalendar
     * @param string $calendarId: El id del calendario a obtener. El no añadirlo asumirá el calendario principal
     * @param array $extras: Arreglo con configuraciones a pasar para la función
     * @return array(Google_Service_Calendar_Event)
     */
    public function listEvents($calendarId = null, $extras = null)
    {
        $parametros = array(
            'orderBy' => 'startTime',
            'singleEvents' => TRUE,
        );

        if(!isset($calendarId)){
            $calendarId = $this->calendarioPrincipal;
        }

        /*Agregar opciones extras, en caso que las haya*/
        if(is_array($extras)){
            $parametros = array_merge($parametros, $extras);
        }

        $results = $this->service->events->listEvents($calendarId, $parametros);

        return $results->getItems();
    }


    /**
     * Función para añadir nuevos eventos al calendario remoto.
     * @param string $calendarId: El id del calendario a obtener. El no añadirlo asumirá el calendario principal
     * @param array $data: Información del evento: nombre, laboratorio, fecha de inicio y fecha de fin.
     * @return Google_Service_Calendar_Event
     */
    public function createEvent($calendarId = null, $data = array())
    {
      /* Bandera de conflicto */
      $conflicto = false;

      if(!isset($calendarId)){
          $calendarId = $this->calendarioPrincipal;
      }

      $evento = new \Google_Service_Calendar_Event();
      $evento->setSummary($data['summary']);
      $evento->setLocation($data['location']);

      $fechaInicio = new \Google_Service_Calendar_EventDateTime();
      $fechaInicio->setDateTime($data['start']); /*'2011-06-03T10:00:00.000-07:00'*/
      $evento->setStart($fechaInicio);

      $fechaFin = new \Google_Service_Calendar_EventDateTime();
      $fechaFin->setDateTime($data['end']); /*'2011-06-03T10:00:00.000-07:00'*/
      $evento->setEnd($fechaFin);

      $eventoNuevo = $this->service->events->insert($calendarId, $evento);

      return $eventoNuevo;
    }

    /**
     * Función para actualizar nuevos eventos al calendario remoto.
     * @param string $calendarId: El id del calendario a obtener. El no añadirlo asumirá el calendario principal
     * @param string $eventId: ID del evento remoto
     * @param array $data: Información del evento: nombre, laboratorio, fecha de inicio y fecha de fin.
     * @return Google_Service_Calendar_Event
     */
    public function updateEvent($calendarId = null, $eventId, $data = array())
    {
      if(!isset($calendarId)){
          $calendarId = $this->calendarioPrincipal;
      }

      $evento = $this->service->events->get($calendarId, $eventId);
      $evento->setSummary($data['nombre']);
      $evento->setLocation($data['laboratorio']);

      $fechaInicio = new \Google_Service_Calendar_EventDateTime();
      $fechaInicio->setDateTime($data['fecha_inicio']); /*'2011-06-03T10:00:00.000-07:00'*/
      $evento->setStart($fechaInicio);

      $fechaFin = new \Google_Service_Calendar_EventDateTime();
      $fechaFin->setDateTime($data['fecha_fin']); /*'2011-06-03T10:00:00.000-07:00'*/
      $evento->setEnd($fechaFin);

      $eventoNuevo = $this->service->events->update($calendarId, $eventId, $evento);

      return $eventoNuevo;
    }

    /**
     * Función para eliminar nuevos eventos al calendario remoto.
     * @param string $calendarId: El id del calendario a obtener. El no añadirlo asumirá el calendario principal
     * @param string $eventId: ID del evento remoto
     * @return \GuzzleHttp\Psr7\Response
     */
    public function deleteEvent($calendarId = null, $eventId)
    {
      if(!isset($calendarId)){
          $calendarId = $this->calendarioPrincipal;
      }

      $respuesta = $this->service->events->delete($calendarId, $eventId);

      return $respuesta;
    }
}
