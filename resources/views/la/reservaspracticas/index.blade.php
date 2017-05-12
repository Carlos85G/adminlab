@extends("la.layouts.app")

@section("contentheader_title", "Reservaci&oacute;n de Pr&aacute;cticas")
@section("contentheader_description", "Listado de Reservaciones de Pr&aacute;cticas")
@section("section", "Reservaciones de Pr&aacute;cticas")
@section("sub_section", "Listado")
@section("htmlheader_title", "Listado de Reservaciones de Pr&aacute;cticas")

@section("headerElems")
@la_access("ReservasPracticas", "create")
	<button class="btn btn-success btn-sm pull-right" data-toggle="modal" data-target="#AddModal">A&ntilde;adir Reservaci&oacute;n</button>
@endla_access
@endsection

@section("main-content")

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

@la_access("ReservasPracticas", "create")
<div class="modal fade" id="AddModal" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Cerrar"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="myModalLabel">A&ntilde;adir Reservaci&oacute;n</h4>
			</div>
			{!! Form::open(['action' => 'LA\ReservasPracticasController@store', 'id' => 'reservaspractica-add-form']) !!}
			<div class="modal-body">
				<div class="box-body">
          {{--  @la_form($module) --}}

					@la_input($module, 'practica_id')
					@la_input($module, 'laboratorio_id')
					@la_input($module, 'participantes')
					@la_input($module, 'fecha_inicio')
					<input type="hidden" value="{{ Auth::user()->id }}" name="solicitante_id" />
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
        ajax: "{{ url(config('laraadmin.adminRoute') . '/reservaspractica_dt_ajax') }}",
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

	$("#reservaspractica-add-form").validate({

	});
});
</script>
@endpush
