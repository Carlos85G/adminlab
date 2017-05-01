@extends("la.layouts.app")

@section("contentheader_title", "Pr&aacute;cticas")
@section("contentheader_description", "Listado de Pr&aacute;cticas")
@section("section", "Pr&aacute;cticas")
@section("sub_section", "Listado")
@section("htmlheader_title", "Listado de Pr&aacute;cticas")

@section("headerElems")
@la_access("Practicas", "create")
	<button class="btn btn-success btn-sm pull-right" data-toggle="modal" data-target="#AddModal">A&ntilde;adir Pr&aacute;ctica</button>
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

@la_access("Practicas", "create")
<div class="modal fade" id="AddModal" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="myModalLabel">A&ntilde;adir Pr&aacute;ctica</h4>
			</div>
			{!! Form::open(['action' => 'LA\PracticasController@store', 'id' => 'practica-add-form']) !!}
			<div class="modal-body">
				<div class="box-body">
						{{--  @la_form($module) --}}

						@la_input($module, 'nombre')
						@la_input($module, 'objetivo')
						@la_input($module, 'practica_materiales')
						@la_input($module, 'practica_reactivos')
						<div class="form-group">
								<label for="Horas">Horas * :</label>
								<input class="form-control" id="horas" placeholder="Introduce n&uacute;mero de horas" required="1" name="horas" type="number" value="1" aria-required="true" />
								<label for="Minutos">Minutos * :</label>
								<input class="form-control" id="minutos" placeholder="Introduce n&uacute;mero de minutos" required="1" name="minutos" type="number" value="0" aria-required="true" />
								<input id="duracion" name="duracion" type="hidden" value="3600" />
						</div>
						@la_input($module, 'practica_pdf')
					  {{-- 	@la_input($module, 'duracion')	--}}
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
        ajax: "{{ url(config('laraadmin.adminRoute') . '/practica_dt_ajax') }}",
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

	$("#practica-add-form").validate({

	});

	$("#horas,#minutos").change(function(){
		cambiarasegundos();
	});

	function cambiarasegundos(){
		var segundodhoras = 0,
			segundodminutos = 0,
			totalsegundos = 0;

		try{
			horas = parseInt($("#horas").val());
			segundodhoras = (horas*3600);
			minutos = parseInt($("#minutos").val());
			segundodminutos = (minutos*60);
			totalsegundos = segundodminutos + segundodhoras;
		}catch(e){
			totalsegundos = 0;
		}

		if(isNaN(totalsegundos)){
			totalsegundos = 0;
		}

		$("#duracion").val(totalsegundos);
	}
});
</script>
@endpush
