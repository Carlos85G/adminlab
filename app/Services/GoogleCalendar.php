<?php namespace App\Services;

use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Config;

class GoogleCalendar {
    protected $client;
    protected $service;

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
     * Función para obtener el objeto GoogleCalendar
     * @param string $calendarId: El id del calendario a obtener. El no añadirlo asumirá el calendario principal
     * @return Google_Service_Calendar_Calendar
     */
    public function get($calendarId = null)
    {
        if(!isset($calendarId)){
            $calendarId = $this->calendarioPrincipal;
        }
        $results = $this->service->calendars->get($calendarId);
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
}
