@extends('la.layouts.app')

@section('htmlheader_title') Inicio @endsection
@section('contentheader_title') Inicio @endsection
@section('contentheader_description') Pantalla principal @endsection

@php
    $laboratorios = \App\Models\Laboratorio::all();
@endphp

@section('main-content')
<!-- Main content -->
        <section class="content">
          <!-- Main row -->
          <div class="row">
            <!-- Left col -->
            <section class="col-lg-7">
              <!-- Calendario -->
              <div class="box box-success">
                <div class="box-header">
                  <i class="fa fa-calendar"></i>
                  <h3 class="box-title">Calendarios de reservaciones</h3>
                </div>
                <div class="box-body">

                  <div class="nav-tabs-custom">
                    <!-- Tabs within a box -->
                    <ul class="nav nav-tabs" id="laboratorios">
                      <!-- -->
                      @foreach($laboratorios as $laboratorio)
                      <li>
                          <a href="#laboratorio{{$laboratorio->id}}-tab" data-toggle="tab">{{$laboratorio->nombre}}</a>
                      </li>
                      @endforeach
                    </ul>
                    <div class="tab-content no-padding">
                      @foreach($laboratorios as $laboratorio)
                      <div class="tab-pane" id="laboratorio{{$laboratorio->id}}-tab" style="position: relative;">
                          <div class="cargador" id="laboratorio{{$laboratorio->id}}-cargador">
                              <div class="cargador-overlay"></div>
                              <div class="cargador-spinner"></div>
                          </div>
                          <div id="laboratorio{{$laboratorio->id}}-calendario"></div>
                      </div>
                      @endforeach
                    </div>
                  </div><!-- /.nav-tabs-custom -->

                  <!--item -->
                  <!--<div class="item" ></div>--><!-- /.item -->
                </div><!-- /.calendario -->
                <div class="box-footer"></div>
              </div><!-- /.box (chat box) -->
            </section><!-- /.Left col -->
            <!-- right col-->
            <section class="col-lg-5">
              <!-- Listado de eventos -->
              <div class="box box-success">
                <div class="box-body">
              		<table id="eventos" class="table table-bordered">
              		<thead>
              		<tr class="success">
              			<th>ID</th>
              			<th>Evento</th>
                    <th>Ubicaci&oacute;n</th>
              		</tr>
              		</thead>
              		<tbody></tbody>
              		</table>
                </div><!-- /.box-body -->
              </div><!-- /.box -->
            </section><!-- right col -->
          </div><!-- /.row (main row) -->
        </section><!-- /.content -->
@endsection

@push('styles')
<!-- Morris chart -->
<link rel="stylesheet" href="{{ asset('la-assets/plugins/morris/morris.css') }}">
<!-- jvectormap -->
<link rel="stylesheet" href="{{ asset('la-assets/plugins/jvectormap/jquery-jvectormap-1.2.2.css') }}">
<!-- Date Picker -->
<link rel="stylesheet" href="{{ asset('la-assets/plugins/datepicker/datepicker3.css') }}">
<!-- Daterange picker -->
<link rel="stylesheet" href="{{ asset('la-assets/plugins/daterangepicker/daterangepicker-bs3.css') }}">
<!-- bootstrap wysihtml5 - text editor -->
<link rel="stylesheet" href="{{ asset('la-assets/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css') }}">

<!-- Funciones de FullCalendar -->
<link href="{{ asset('/js/fullcalendar-3.3.1/lib/cupertino/jquery-ui.min.css') }}" rel="stylesheet" />
<link href="{{ asset('/js/fullcalendar-3.3.1/fullcalendar.min.css') }}" rel="stylesheet" />
<link href="{{ asset('/js/fullcalendar-3.3.1/fullcalendar.print.min.css') }}" rel="stylesheet" media="print" />

<!--Estilo del precargador -->
<link href="{{ asset('/css/cargador.css') }}" rel="stylesheet" />
@endpush


@push('scripts')
<!-- jQuery UI 1.11.4 -->
<!--<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>-->
<script src="{{ asset('/js/jquery-ui-1.11.4/jquery-ui.min.js') }}"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Morris.js charts -->
<!--<script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>-->
<script src="{{ asset('/js/raphael-2.1.0/raphael-min.js') }}"></script>
<script src="{{ asset('la-assets/plugins/morris/morris.min.js') }}"></script>
<!-- Sparkline -->
<script src="{{ asset('la-assets/plugins/sparkline/jquery.sparkline.min.js') }}"></script>
<!-- jvectormap -->
<script src="{{ asset('la-assets/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js') }}"></script>
<script src="{{ asset('la-assets/plugins/jvectormap/jquery-jvectormap-world-mill-en.js') }}"></script>
<!-- jQuery Knob Chart -->
<script src="{{ asset('la-assets/plugins/knob/jquery.knob.js') }}"></script>
<!-- daterangepicker -->
<!--<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js"></script>-->
<script src="{{ asset('/js/moment-2.18.1/moment-with-locales.min.js') }}"></script>
<script src="{{ asset('la-assets/plugins/daterangepicker/daterangepicker.js') }}"></script>
<!-- datepicker -->
<script src="{{ asset('la-assets/plugins/datepicker/bootstrap-datepicker.js') }}"></script>
<!-- Bootstrap WYSIHTML5 -->
<script src="{{ asset('la-assets/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js') }}"></script>
<!-- FastClick -->
<script src="{{ asset('la-assets/plugins/fastclick/fastclick.js') }}"></script>
<!-- dashboard -->
<script src="{{ asset('la-assets/js/pages/dashboard.js') }}"></script>
<!-- FullCalendar -->
<script src="{{ asset('/js/fullcalendar-3.3.1/fullcalendar.min.js') }}"></script>
<!-- Cargar archivo de localización -->
<script src="{{ asset('/js/fullcalendar-3.3.1/locale/es-do.js') }}"></script>
<!--DataTable-->
<script src="{{ asset('la-assets/plugins/datatables/datatables.min.js') }}"></script>
<!--NotifyJS-->
<script src="{{ asset('/js/notifyjs-0.4/notify.js') }}"></script>
@endpush

@push('scripts')
<script type="text/javascript">
  $(document).ready(function(){
      $('.carousel').carousel({
          interval: 3500
      });

      $("#eventos").DataTable({
      		processing: true,
          ajax: '{{ route("api_calendario_eventos_tabla") }}',
          searching: false,
      		{!! Ayudantes::imprimirLenguageDataTable() !!}
          columnDefs: [ { orderable: false, targets: [-1] }],
    	});

      @if(Session::has('flash-message'))
      $.notify(
          '{!! Session::get('flash-message') !!}',
          {
              position: 'top center',
              autoHide: false,
              className: '{{ Session::has('flash-message-error')? 'error' : 'success' }}'
          }
      );
      @endif

      @foreach($laboratorios as $laboratorio)
      $('#laboratorio{{$laboratorio->id}}-calendario').fullCalendar({
          header: {
            left: 'prev,next today',
            center: 'title',
            right: 'listDay,listWeek,month'
          },
          @if(!empty($laboratorio->color_frente))
          eventTextColor: '{{$laboratorio->color_frente}}',
          @endif
          @if(!empty($laboratorio->color_fondo))
          eventColor: '{{$laboratorio->color_fondo}}',
          @endif
          theme: true,
          events: '{{ route("api_calendario_laboratorio_eventos", ["laboratorioId" => $laboratorio->id]) }}',
          loading: function(bool) {
            $('#laboratorio{{$laboratorio->id}}-cargador').toggle(bool);
          },
          eventClick: function(event) {
              window.open(event.url, 'gcalevent', 'width=700,height=600');
              return false;
          },
          dayClick: function(date, jsEvent, view) {
              alert('Clicked on: ' + date.format());

              alert('Coordinates: ' + jsEvent.pageX + ',' + jsEvent.pageY);

              alert('Current view: ' + view.name);

              // change the day's background color just for fun
              $(this).css('background-color', 'red');
          }
      });
      @endforeach

      $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
          @foreach($laboratorios as $laboratorio)
          $('#laboratorio{{$laboratorio->id}}-calendario').fullCalendar('render');
          @endforeach
          console.log("FUNCIONA");
      });

      $('#laboratorios a:first').tab('show');
  });
</script>
@endpush
