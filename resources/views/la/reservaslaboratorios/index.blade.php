@extends("la.layouts.app")

@section("contentheader_title", "Reservaci&oacute;n de Laboratorios")
@section("contentheader_description", "Listado de Reservaciones de Laboratorios")
@section("section", "Reservaciones de Laboratorios")
@section("sub_section", "Listado")
@section("htmlheader_title", "Listado de Reservaciones de Laboratorios")

@section("headerElems")
@la_access("ReservasLaboratorios", "create")
	<button class="btn btn-success btn-sm pull-right" data-toggle="modal" data-target="#AddModal">A&ntilde;adir Reservaci&oacute;n</button>
@endla_access
@endsection

@section("main-content")

@php
	$usuarios = \App\User::all();
	$usuarioActual = Auth::user();
@endphp

@if (count($errors) > 0)
    <div class="alert alert-danger">
        <ul>
            @foreach ($errors->all() as $error)
                <li>{{ $error }}</li>
            @endforeach
        </ul>
    </div>
@endif

<div class="box box-success">
	<!--<div class="box-header"></div>-->
	<div class="box-body">
		<table id="example1" class="table table-bordered">
		<thead>
		<tr class="success">
			@foreach( $listing_cols as $col )
			<th>{{ $module->fields[$col]['label'] or ucfirst($col) }}</th>
			@endforeach
			@if($show_actions)
			<th>Acciones</th>
			@endif
		</tr>
		</thead>
		<tbody>

		</tbody>
		</table>
	</div>
</div>

@la_access("ReservasLaboratorios", "create")
<div class="modal fade" id="AddModal" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Cerrar"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="myModalLabel">A&ntilde;adir Reservaci&oacute;n</h4>
			</div>
			{!! Form::open(['action' => 'LA\ReservasLaboratoriosController@store', 'id' => 'reservaslaboratorio-add-form']) !!}
			<div class="modal-body">
				<div class="box-body">
          {{--  @la_form($module) --}}

					@la_input($module, 'laboratorio_id')
					@la_input($module, 'fecha_inicio')
					@la_input($module, 'fecha_fin')
					{{-- Esta no es la manera correcta de revisar por privilegios administrativos, pero es lo necesario --}}
					@if($usuarioActual->hasRole('SUPER_ADMIN') || $usuarioActual->hasRole('LabAdmin'))
					<div class="form-group">
						<label for="solicitante_id">Solicitante</label>
						<select class="form-control" required="1" data-placeholder="Seleccione un Usuario" rel="select2" name="solicitante_id">
							@foreach($usuarios as $usuario)
							<option value="{{ $usuario->id }}"{!! ($usuarioActual->id === $usuario->id)? ' selected="selected"' : '' !!}>{{ $usuario->name }}</option>
							@endforeach
						</select>
					</div>
					@else
					<input type="hidden" value="{{ $usuarioActual->id }}" name="solicitante_id" />
					@endif
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
				{!! Form::submit( 'Enviar', ['class'=>'btn btn-success']) !!}
			</div>
			{!! Form::close() !!}
		</div>
	</div>
</div>
@endla_access

@endsection

@push('styles')
<link rel="stylesheet" type="text/css" href="{{ asset('la-assets/plugins/datatables/datatables.min.css') }}"/>
@endpush

@push('scripts')
<script src="{{ asset('la-assets/plugins/datatables/datatables.min.js') }}"></script>
<script>
$(function () {
	$("#example1").DataTable({
		processing: true,
        serverSide: true,
        ajax: "{{ url(config('laraadmin.adminRoute') . '/reservaslaboratorio_dt_ajax') }}",
				{!! Ayudantes::imprimirLenguageDataTable() !!}
		@if($show_actions)
		columnDefs: [ { orderable: false, targets: [-1] }],
		@endif
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

	$("#reservaslaboratorio-add-form").validate({

	});
});
</script>
@endpush
