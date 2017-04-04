<!DOCTYPE html>
<html>
    <head>
        <title>P&aacute;gina / Registro no encontrado.</title>

        <link href="https://fonts.googleapis.com/css?family=Roboto:200,400" rel="stylesheet" type="text/css">
		<link href="{{ asset('la-assets/css/font-awesome.min.css') }}" rel="stylesheet" type="text/css" />

        <style>
            html, body {
                height: 100%;
            }

            body {
                margin: 0;
                padding: 0;
                width: 100%;
                color: #B0BEC5;
                display: table;
                font-weight: 200;
                font-family: 'Lato';
            }

            .container {
                text-align: center;
                display: table-cell;
                vertical-align: middle;
            }

            .content {
                text-align: center;
                display: inline-block;
            }

            .title {
                font-size: 60px;
                margin-bottom: 40px;
				color: #444;
            }
			a {
				font-weight:normal;
				color:#3061B6;
				text-decoration: none;
			}
        </style>
    </head>
    <body>
        <div class="container">
            <div class="content">
				<i class="fa fa-search" style="font-size:120px;color:#FF5959;margin-bottom:30px;"></i>
                @if(isset($record_name) && isset($record_id))
					<div class="title">El {{ $record_name }} con el id {{ $record_id }} no fue encontrado</div>
				@else
					<div class="title">P&aacute;gina no encontrada</div>
				@endif



        @if(Auth::guest())
          <a href="{{ url('/') }}">Regresar al Inicio</a> |
          <a href="javascript:history.back()">Ir atr&aacute;s</a>
        @else
          <a href="{{ url(config('laraadmin.adminRoute')) }}">Inicio.</a> |
          <a href="javascript:history.back()">Ir atr&aacute;s</a>
				@endif
            </div>
        </div>
    </body>
</html>
