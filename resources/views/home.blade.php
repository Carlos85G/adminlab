<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="csrf-token" content="{{ csrf_token() }}" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="{{ LAConfigs::getByKey('site_description') }}">
    <meta name="author" content="Maestr&iacute;a en Ingenier&iacute;a de Software">

    <?php
    /*
    <meta property="og:title" content="{{ LAConfigs::getByKey('sitename') }}" />
    <meta property="og:type" content="website" />
    <meta property="og:description" content="{{ LAConfigs::getByKey('site_description') }}" />

    <meta property="og:url" content="http://laraadmin.com/" />
    <meta property="og:sitename" content="laraAdmin" />
	  <meta property="og:image" content="http://demo.adminlte.acacha.org/img/LaraAdmin-600x600.jpg" />

    <meta name="twitter:card" content="summary_large_image" />
    <meta name="twitter:site" content="@laraadmin" />
    <meta name="twitter:creator" content="@laraadmin" />
    */
    ?>

    <title>{{ LAConfigs::getByKey('sitename') }}</title>

    <!-- Bootstrap core CSS -->
    <link href="{{ asset('/la-assets/css/bootstrap.css') }}" rel="stylesheet">

	   <link href="{{ asset('la-assets/css/font-awesome.min.css') }}" rel="stylesheet" type="text/css" />

    <!-- Custom styles for this template -->
    <link href="{{ asset('/la-assets/css/main.css') }}" rel="stylesheet">

    <link href='http://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Raleway:400,300,700' rel='stylesheet' type='text/css'>

    <script src="{{ asset('/la-assets/plugins/jQuery/jQuery-2.1.4.min.js') }}"></script>
    <script src="{{ asset('/la-assets/js/smoothscroll.js') }}"></script>

    <!-- Funciones de FullCalendar -->
    <link href="{{ asset('/js/fullcalendar-3.3.1/lib/cupertino/jquery-ui.min.css') }}" rel="stylesheet" />
    <link href="{{ asset('/js/fullcalendar-3.3.1/fullcalendar.min.css') }}" rel="stylesheet" />
    <link href="{{ asset('/js/fullcalendar-3.3.1/fullcalendar.print.min.css') }}" rel="stylesheet" media="print" />
    <script src="{{ asset('/js/moment-2.18.1/moment-with-locales.min.js') }}"></script>
    <script src="{{ asset('/js/fullcalendar-3.3.1/fullcalendar.min.js') }}"></script>
    <!-- Cargar archivo de localización -->
    <script src="{{ asset('/js/fullcalendar-3.3.1/locale/es-do.js') }}"></script>


</head>

<body data-spy="scroll" data-offset="0" data-target="#navigation">

<!-- Fixed navbar -->
<div id="navigation" class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#"><b>{{ LAConfigs::getByKey('sitename') }}</b></a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#home" class="smoothScroll">Accede</a></li>
                <?php
                  // <li><a href="#about" class="smoothScroll">Avisos</a></li>
                ?>
                <li><a href="#contact" class="smoothScroll">Cont&aacute;ctanos</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                @if (Auth::guest())
                    <li><a href="{{ url('/login') }}">Iniciar sesi&oacute;n</a></li>
                    <?php
                      // <li><a href="{{ url('/register') }}">Register</a></li>
                    ?>
                @else
                    <li><a href="{{ url(config('laraadmin.adminRoute')) }}">{{ Auth::user()->name }}</a></li>
                @endif
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</div>


<section id="home" name="home"></section>
<div id="headerwrap">
    <div class="container">
        <div class="row centered">
            <div class="col-lg-2">
                <h5>&iquest;Ya reservaste tu <i>lab</i>?</h5>
                <p>Acceso para Laboratorios</p>
                <img class="hidden-xs hidden-sm hidden-md" src="{{ asset('/la-assets/img/arrow1.png') }}">
            </div>
            <div class="col-lg-8" id="calendario">
                <div id="calendario"></div>
                <!--<iframe src="https://calendar.google.com/calendar/embed?src=admlab.cuvalles%40gmail.com&ctz=America/Mexico_City" style="border: 0" width="800" height="600" frameborder="0" scrolling="no"></iframe>-->
            </div>
            <div class="col-lg-12">
                <h1>{{ LAConfigs::getByKey('sitename_part1') }} <b><a>{{ LAConfigs::getByKey('sitename_part2') }}</a></b></h1>
                <h3>{{ LAConfigs::getByKey('site_description') }}</h3>
                <h3><a href="{{ url('/login') }}" class="btn btn-lg btn-success">Inicia sesi&oacute;n</a></h3>
                <br />
            </div>
            <div class="col-lg-2">
                <?php
                // <!-- <br>
                // <img class="hidden-xs hidden-sm hidden-md" src="{{ asset('/la-assets/img/arrow2.png') }}">
                // <h5>Completely Packaged...</h5>
                // <p>for Future expantion of Modules</p> -->
                ?>
            </div>
        </div>
    </div> <!--/ .container -->
</div><!--/ #headerwrap -->


<section id="about" name="about"></section>
<!-- INTRO WRAP -->
<div id="intro">
    <div class="container">
      <div class="panel panel-default">
<div class="panel-heading">Bolet&iacute;n de noticias</div>
<div class="panel-body">
  Informaci&oacute;n sobre llave:
  <br />
  Tel: 322-800-05-21
</div>
</div>
        <br>
        <hr>
    </div> <!--/ .container -->
</div><!--/ #introwrap -->

<?php
/*
<!-- FEATURES WRAP -->
<div id="features">
    <div class="container">
        <div class="row">
            <div class="col-lg-5 centered">
                <img class="centered" src="{{ asset('/la-assets/img/mobile.png') }}" alt="">
            </div>

            <div class="col-lg-7">
				<h3 class="feature-title">Que es </h3><br>
				<ol class="features">
					<li><strong>CMS</strong> (Content Management System) &#8211; Manages Modules &amp; their Data</li>
					<li>Backend <strong>Admin Panel</strong> &#8211; Data can be used in front end applications with ease.</li>
					<li>A probable <strong>CRM</strong> System &#8211; Can be evolved into a CRM system like <a target="_blank" href="https://www.sugarcrm.com">SugarCRM</a></li>
				</ol><br>

				<h3 class="feature-title">Why LaraAdmin ?</h3><br>
                <ol class="features">
					<li><strong>Philosophy:</strong> Inspired by SugarCRM &amp; based on Advanced <strong>Data Types</strong> like Image, HTML, File, Dropdown, TagInput which makes developers job easy. See more in <a target="_blank" href="http://laraadmin.com/features">features</a></li>
					<li>Superior <strong>CRUD generation</strong> for Modules which generates Migration, Controller, Model and Views with single artisan command and integrates with Routes as as well.</li>
					<li><strong>Form Maker</strong> helper is provided for generating entire form with single function call with module name as single parameter. It also gives you freedom to customise form for every field by providing method to generate single field with parameters for customisations.</li>
					<li><b>Upload Manager </b>manages project files &amp; images which are integrated with your Module fields.</li>
					<li><strong>Menu Manager</strong> creates menu with Modules &amp; Custom Links likes WordPress</li>
					<li><strong>Online Code Editor</strong> allows developers to customise the generated Module Views &amp; Files.</li>
				</ol>
            </div>
        </div>
    </div><!--/ .container -->
</div><!--/ #features -->
*/
?>

<section id="contact" name="contact"></section>
<div id="footerwrap">
    <div class="container">
        <div class="col-lg-5">
            <h3>Cont&aacute;ctanos</h3><br>
            <p>
      				Maestr&iacute;a en Ingenier&iacute;a de Software,
              <br />
      				Desarrollado por:
                <br />
                Ing. Jes&uacute;s Adri&aacute;n Arroyo Ceja
                <br />
                Ing. Carlos Eduardo Gonz&aacute;lez L&oacute;pez
                <br />
                Ing. Rogelio Jim&eacute;nez Meza
                <br />
                Lic. Lissette Ahumada Castellanos
                <br />
                Centro Universitario de los Valles
            </p>
			<div class="contact-link"><i class="fa fa-envelope-o"></i> <a href="mailto:rogelio.jimenez@alumno.udg.mx">rogelio.jimenez@alumno.udg.mx</a></div>
      <?php
			/*
      <div class="contact-link"><i class="fa fa-cube"></i> <a href="http://laraadmin.com">laraadmin.com</a></div>
			<div class="contact-link"><i class="fa fa-building"></i> <a href="http://dwijitsolutions.com">dwijitsolutions.com</a></div>
      */
      ?>
        </div>

        <div class="col-lg-7">
            <h3>&iquest;Te gust&oacute; o tienes problemas con este sistema? D&eacute;janos un mensaje</h3>
            <br>
            <form role="form" action="#" method="post" enctype="plain">
                <div class="form-group">
                    <label for="name1">Nombre</label>
                    <input type="name" name="Name" class="form-control" id="name1" placeholder="Tu nombre">
                </div>
                <div class="form-group">
                    <label for="email1">Correo Electr&oacute;nico</label>
                    <input type="email" name="Mail" class="form-control" id="email1" placeholder="Escribe tu correo electr&oacute;nico">
                </div>
                <div class="form-group">
                    <label>Mensaje</label>
                    <textarea class="form-control" name="Message" rows="3"></textarea>
                </div>
                <br>
                <button type="submit" class="btn btn-large btn-success">Enviar</button>
            </form>
        </div>
    </div>
</div>
<div id="c">
    <div class="container">
        <p>
            <strong>Copyright &copy; 2017. Powered by </strong><a href="http://servermis.cuvalles.udg.mx"><b>Maestr&iacute;a en Ingenier&iacute;a de Software</b></a>
        </p>
    </div>
</div>


<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="{{ asset('/la-assets/js/bootstrap.min.js') }}" type="text/javascript"></script>
<script>
    $(document).ready(function(){
        $('.carousel').carousel({
            interval: 3500
        });

        $('#calendario').fullCalendar({
            header: {
      				left: 'prev,next today',
      				center: 'title',
      				right: 'month'
      			},
            theme: true,
      			eventClick: function(event) {
        				window.open(event.url, 'gcalevent', 'width=700,height=600');
        				return false;
      			}
        });
    });
</script>
</body>
</html>
