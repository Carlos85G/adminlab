@extends('la.layouts.app')

@section('htmlheader_title')
	Vista de Reservaci&oacute;n de Pr&aacute;ctica
@endsection


@section('main-content')
<div id="page-content" class="profile2">
	<div class="bg-primary clearfix">
		<div class="col-md-4">
			<div class="row">
				<div class="col-md-3">
					<!--<img class="profile-image" src="{{ asset('la-assets/img/avatar5.png') }}" alt="">-->
					<div class="profile-icon text-primary"><i class="fa {{ $module->fa_icon }}"></i></div>
				</div>
				<div class="col-md-9">
					<h4 class="name">{{-- $reservaspractica->$view_col --}}{{ $reservaspractica->practica->nombre }}</h4>
					<div class="row stats">
						{{--<div class="col-md-4"><i class="fa fa-facebook"></i> 234</div>
						<div class="col-md-4"><i class="fa fa-twitter"></i> 12</div>
						<div class="col-md-4"><i class="fa fa-instagram"></i> 89</div>--}}
					</div>
					{{--<p class="desc">Test Description in one line</p>--}}
				</div>
			</div>
		</div>
		<div class="col-md-3">
			{{--<div class="dats1"><div class="label2">Admin</div></div>
			<div class="dats1"><i class="fa fa-envelope-o"></i> superadmin@gmail.com</div>
			<div class="dats1"><i class="fa fa-map-marker"></i> Pune, India</div>--}}
		</div>
		<div class="col-md-4">
			{{--<!--
			<div class="teamview">
				<a class="face" data-toggle="tooltip" data-placement="top" title="John Doe"><img src="{{ asset('la-assets/img/user1-128x128.jpg') }}" alt=""><i class="status-online"></i></a>
				<a class="face" data-toggle="tooltip" data-placement="top" title="John Doe"><img src="{{ asset('la-assets/img/user2-160x160.jpg') }}" alt=""></a>
				<a class="face" data-toggle="tooltip" data-placement="top" title="John Doe"><img src="{{ asset('la-assets/img/user3-128x128.jpg') }}" alt=""></a>
				<a class="face" data-toggle="tooltip" data-placement="top" title="John Doe"><img src="{{ asset('la-assets/img/user4-128x128.jpg') }}" alt=""><i class="status-online"></i></a>
				<a class="face" data-toggle="tooltip" data-placement="top" title="John Doe"><img src="{{ asset('la-assets/img/user5-128x128.jpg') }}" alt=""></a>
				<a class="face" data-toggle="tooltip" data-placement="top" title="John Doe"><img src="{{ asset('la-assets/img/user6-128x128.jpg') }}" alt=""></a>
				<a class="face" data-toggle="tooltip" data-placement="top" title="John Doe"><img src="{{ asset('la-assets/img/user7-128x128.jpg') }}" alt=""></a>
				<a class="face" data-toggle="tooltip" data-placement="top" title="John Doe"><img src="{{ asset('la-assets/img/user8-128x128.jpg') }}" alt=""></a>
				<a class="face" data-toggle="tooltip" data-placement="top" title="John Doe"><img src="{{ asset('la-assets/img/user5-128x128.jpg') }}" alt=""></a>
				<a class="face" data-toggle="tooltip" data-placement="top" title="John Doe"><img src="{{ asset('la-assets/img/user6-128x128.jpg') }}" alt=""><i class="status-online"></i></a>
				<a class="face" data-toggle="tooltip" data-placement="top" title="John Doe"><img src="{{ asset('la-assets/img/user7-128x128.jpg') }}" alt=""></a>
			</div>
			-->
			<div class="dats1 pb">
				<div class="clearfix">
					<span class="pull-left">Task #1</span>
					<small class="pull-right">20%</small>
				</div>
				<div class="progress progress-xs active">
					<div class="progress-bar progress-bar-warning progress-bar-striped" style="width: 20%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
						<span class="sr-only">20% Complete</span>
					</div>
				</div>
			</div>
			<div class="dats1 pb">
				<div class="clearfix">
					<span class="pull-left">Task #2</span>
					<small class="pull-right">90%</small>
				</div>
				<div class="progress progress-xs active">
					<div class="progress-bar progress-bar-warning progress-bar-striped" style="width: 90%" role="progressbar" aria-valuenow="90" aria-valuemin="0" aria-valuemax="100">
						<span class="sr-only">90% Complete</span>
					</div>
				</div>
			</div>
			<div class="dats1 pb">
				<div class="clearfix">
					<span class="pull-left">Task #3</span>
					<small class="pull-right">60%</small>
				</div>
				<div class="progress progress-xs active">
					<div class="progress-bar progress-bar-warning progress-bar-striped" style="width: 60%" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100">
						<span class="sr-only">60% Complete</span>
					</div>
				</div>
			</div>--}}
		</div>
		<div class="col-md-1 actions">
			@la_access("ReservasPracticas", "edit")
				<a href="{{ url(config('laraadmin.adminRoute') . '/reservaspracticas/'.$reservaspractica->id.'/edit') }}" class="btn btn-xs btn-edit btn-default"><i class="fa fa-pencil"></i></a><br>
			@endla_access

			@la_access("ReservasPracticas", "delete")
				{{ Form::open(['route' => [config('laraadmin.adminRoute') . '.reservaspracticas.destroy', $reservaspractica->id], 'method' => 'delete', 'style'=>'display:inline']) }}
					<button class="btn btn-default btn-delete btn-xs" type="submit"><i class="fa fa-times"></i></button>
				{{ Form::close() }}
			@endla_access
		</div>
	</div>

	<ul data-toggle="ajax-tab" class="nav nav-tabs profile" role="tablist">
		<li class=""><a href="{{ url(config('laraadmin.adminRoute') . '/reservaspracticas') }}" data-toggle="tooltip" data-placement="right" title="Regresar a Reservaciones de Pr&aacute;cticas"><i class="fa fa-chevron-left"></i></a></li>
		<li class="active"><a role="tab" data-toggle="tab" class="active" href="#tab-general-info" data-target="#tab-info"><i class="fa fa-bars"></i> Informaci&oacute;n General</a></li>
		<li class=""><a role="tab" data-toggle="tab" href="#tab-practica" data-target="#tab-practica"><i class="fa fa-clock-o"></i> Pr&aacute;ctica</a></li>
	</ul>

	<div class="tab-content">
		<div role="tabpanel" class="tab-pane active fade in" id="tab-info">
			<div class="tab-content">
				<div class="panel infolist">
					<div class="panel-default panel-heading">
						<h4>Informaci&oacute;n General</h4>
					</div>
					<div class="panel-body">
						<div class="form-group">
							<label for="practica_id" class="col-md-2">Pr&aacute;ctica a realizar :</label>
							<div class="col-md-10 fvalue">{{ $reservaspractica->practica->nombre }}</div>
						</div>
						<div class="form-group">
							<label for="laboratorio_id" class="col-md-2">Laboratorio :</label>
							<div class="col-md-10 fvalue">{{ $reservaspractica->laboratorio->nombre }}</div>
						</div>
						@la_display($module, 'fecha_inicio')
						@la_display($module, 'solicitante_id')
					</div>
				</div>
			</div>
		</div>
		<div role="tabpanel" class="tab-pane fade in p20 bg-white" id="tab-practica">
			<div class="tab-content">
				<div class="panel infolist">
					<div class="panel-default panel-heading">
						<h4>Pr&aacute;ctica</h4>
					</div>
					<div class="panel-body">
						@la_display($module_practica, 'nombre')
						@la_display($module_practica, 'objetivo')
						<div class="form-group">
							<label for="duracion" class="col-md-2">Duraci&oacute;n  :</label>
							<div class="col-md-10 fvalue">
								{{ (int) ($practica->duracion / 3600) }} horas, {{ (int) ($practica->duracion % 3600) }} minutos
							</div>
						</div>
						@la_display($module_practica, 'practica_pdf')
					</div>
				</div>
			</div>
		</div>

	</div>
	</div>
	</div>
</div>
@endsection
