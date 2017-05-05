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

@php

$materiales = \App\Models\Materiale::all();
$reactivos = \App\Models\Reactivo::all();

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
						<label for="practica_materiales">Materiales* :</label>
						<div id="practica_materiales"></div>
						<div class="form-group">
							<div class="btn btn-success btn-md" id="nuevo-material">A&ntilde;adir nuevo Material</div>
						</div>
						<label for="practica_reactivos">Reactivos* :</label>
						<div id="practica_reactivos"></div>
						<div class="form-group">
							<div class="btn btn-success btn-md" id="nuevo-reactivo">A&ntilde;adir nuevo Reactivo</div>
						</div>
						<label>Duraci&oacute;n * :</label>
						<div class="row">
							<div class="form-group col-md-6">
								<div class="input-group">
									<input class="form-control" id="horas" placeholder="Introduce n&uacute;mero de horas" required="1" name="horas" type="number" value="1" aria-required="true" />
									<span class="input-group-addon">horas</span>
								</div>
							</div>
							<div class="form-group col-md-6">
								<div class="input-group">
									<input class="form-control" id="minutos" placeholder="Introduce n&uacute;mero de minutos" required="1" name="minutos" type="number" value="0" aria-required="true" />
									<span class="input-group-addon">minutos</span>
								</div>
							</div>
							<input id="duracion" name="duracion" type="hidden" value="3600" />
						</div>
						@la_input($module, 'practica_pdf')
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

	function addRemovePracticaMaterial(el){
		el.click(function(){
			$(this).parents("div.practicamaterial").remove();
		});
	}

	function addRemovePracticaReactivo(el){
		el.click(function(){
			$(this).parents("div.practicareactivo").remove();
		});
	}

	function addChangeUnity(el){
		el.change(function(){
			 $(this).parents('div.practicareactivo').find('span.input-group-addon').html($(this).find("option:selected").attr('data-unidad'));
		}).change();
	}

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

	$('#nuevo-material').click(function(){
		var tiempo = new Date().getTime(),
			nuevoId = "nuevo_" + tiempo;
			fila = $(
				'<div />',
				{
					class: 'row practicamaterial'
				}
			),
			nombre_material_container = $(
				'<div />',
				{
					class: 'form-group col-md-5'
				}
			),
			nombre_material = $(
				'<select />',
				{
					class: "form-control",
					required: 1,
					"data-placeholder": "Seleccione un Material",
					rel: "select2",
					name: 'practicamaterial[' + nuevoId + ']'
				}
			),
			cantidad_material_container = $(
				'<div />',
				{
					class: 'form-group col-md-2'
				}
			),
			cantidad_material = $(
				'<input />',
				{
					type: "number",
					class: "form-control",
					placeholder: "Indique candidad de material ",
					required: 1,
					name: 'practicamaterial_cantidad[' + nuevoId + ']',
					value: 1
				}
			),
			por_grupo_material_container = $(
				'<div />',
				{
					class: "form-group col-md-4"
				}
			),
			por_grupo_material_label = $(
				'<label />',
				{
					for: 'practicamaterial_por_grupo[' + nuevoId + ']',
					html: '&iquest;Para todos?:'
				}
			),
			por_grupo_material_hidden = $(
				'<input />',
				{
					type: "hidden",
					value: "false",
					name: 'practicamaterial_por_grupo_hidden[' + nuevoId + ']'
				}
			),
			por_grupo_material_checkbox = $(
				'<input />',
				{
					type: "checkbox",
					class: "form-control",
					name: 'practicamaterial_por_grupo[' + nuevoId + ']',
					value: 'practicamaterial_por_grupo[' + nuevoId + ']'
				}
			),
			por_grupo_material_switch = $(
				'<div />',
				{
					class: 'Switch Round Off',
					style: 'vertical-align:top;margin-left:10px;'
				}
			),
			por_grupo_material_switch_toggle = $(
				'<div />',
				{
					class: 'Toggle'
				}
			),
			eliminar_material_container = $(
				'<div />',
				{
					class: 'form-group col-md-1'
				}
			),
			eliminar_material_button = $(
				'<button />',
				{
					type: 'button',
					class: 'btn btn-danger btn-xs remove_practicamaterial'
				}
			),
			eliminar_material_i = $(
				'<i />',
				{
					class: 'fa fa-times'
				}
			);

		@foreach($materiales as $material)
		nombre_material.append(
			$(
				'<option />',
				{
					value: {{ $material->id }},
					html: '{{ $material->descripcion }}'
				}
			)
		);
		@endforeach

		nombre_material_container.append(nombre_material);
		cantidad_material_container.append(cantidad_material);
		por_grupo_material_switch.append(por_grupo_material_switch_toggle);
		por_grupo_material_container.append(por_grupo_material_label);
		por_grupo_material_container.append(" "); /* Iguala el espacio */
		por_grupo_material_container.append(por_grupo_material_hidden);
		por_grupo_material_container.append(por_grupo_material_checkbox);
		por_grupo_material_container.append(por_grupo_material_switch);
		eliminar_material_button.append(eliminar_material_i);
		eliminar_material_container.append(eliminar_material_button);

		fila.append(nombre_material_container);
		fila.append(cantidad_material_container);
		fila.append(por_grupo_material_container);
		fila.append(eliminar_material_container);

		$('#practica_materiales').append(fila);

		addToggleCheck(por_grupo_material_switch);
		addSelect2(nombre_material);
		addRemovePracticaMaterial(eliminar_material_button);
	});

	$('#nuevo-reactivo').click(function(){
		var tiempo = new Date().getTime(),
			nuevoId = "nuevo_" + tiempo;
			fila = $(
				'<div />',
				{
					class: 'row practicareactivo'
				}
			),
			nombre_reactivo_container = $(
				'<div />',
				{
					class: 'form-group col-md-3'
				}
			),
			nombre_reactivo = $(
				'<select />',
				{
					class: "form-control change-unity",
					required: 1,
					"data-placeholder": "Seleccione un Reactivo",
					rel: "select2",
					name: 'practicareactivo[' + nuevoId + ']'
				}
			),
			cantidad_reactivo_container = $(
				'<div />',
				{
					class: 'form-group col-md-4'
				}
			),
			cantidad_reactivo_wrapper = $(
				'<div />',
				{
					class: 'input-group'
				}
			),
			cantidad_reactivo = $(
				'<input />',
				{
					type: "number",
					class: "form-control",
					placeholder: "Indique candidad de reactivo ",
					required: 1,
					name: 'practicareactivo_cantidad[' + nuevoId + ']',
					value: 1
				}
			),
			cantidad_reactivo_unidad = $(
				'<span />',
				{
					class: 'input-group-addon',
					html: 'unidades'
				}
			),
			por_grupo_reactivo_container = $(
				'<div />',
				{
					class: "form-group col-md-4"
				}
			),
			por_grupo_reactivo_label = $(
				'<label />',
				{
					for: 'practicareactivo_por_grupo[' + nuevoId + ']',
					html: '&iquest;Para todos?:'
				}
			),
			por_grupo_reactivo_hidden = $(
				'<input />',
				{
					type: "hidden",
					value: "false",
					name: 'practicareactivo_por_grupo_hidden[' + nuevoId + ']'
				}
			),
			por_grupo_reactivo_checkbox = $(
				'<input />',
				{
					type: "checkbox",
					class: "form-control",
					name: 'practicareactivo_por_grupo[' + nuevoId + ']',
					value: 'practicareactivo_por_grupo[' + nuevoId + ']'
				}
			),
			por_grupo_reactivo_switch = $(
				'<div />',
				{
					class: 'Switch Round Off',
					style: 'vertical-align:top;margin-left:10px;'
				}
			),
			por_grupo_reactivo_switch_toggle = $(
				'<div />',
				{
					class: 'Toggle'
				}
			),
			eliminar_reactivo_container = $(
				'<div />',
				{
					class: 'form-group col-md-1'
				}
			),
			eliminar_reactivo_button = $(
				'<button />',
				{
					type: 'button',
					class: 'btn btn-danger btn-xs remove_practicareactivo'
				}
			),
			eliminar_reactivo_i = $(
				'<i />',
				{
					class: 'fa fa-times'
				}
			);

		@foreach($reactivos as $reactivo)
		nombre_reactivo.append(
			$(
				'<option />',
				{
					value: {{ $reactivo->id }},
					html: '{{ $reactivo->nombre }}',
					'data-unidad': '{{ $reactivo->unidad }}'
				}
			)
		);
		@endforeach

		nombre_reactivo_container.append(nombre_reactivo);
		cantidad_reactivo_wrapper.append(cantidad_reactivo);
		cantidad_reactivo_wrapper.append(cantidad_reactivo_unidad);

		cantidad_reactivo_container.append(cantidad_reactivo_wrapper);
		por_grupo_reactivo_switch.append(por_grupo_reactivo_switch_toggle);
		por_grupo_reactivo_container.append(por_grupo_reactivo_label);
		por_grupo_reactivo_container.append(" "); /* Iguala el espacio */
		por_grupo_reactivo_container.append(por_grupo_reactivo_hidden);
		por_grupo_reactivo_container.append(por_grupo_reactivo_checkbox);
		por_grupo_reactivo_container.append(por_grupo_reactivo_switch);
		eliminar_reactivo_button.append(eliminar_reactivo_i);
		eliminar_reactivo_container.append(eliminar_reactivo_button);

		fila.append(nombre_reactivo_container);
		fila.append(cantidad_reactivo_container);
		fila.append(por_grupo_reactivo_container);
		fila.append(eliminar_reactivo_container);

		$('#practica_reactivos').append(fila);

		addToggleCheck(por_grupo_reactivo_switch);
		addSelect2(nombre_reactivo);
		addChangeUnity(nombre_reactivo);
		addRemovePracticaReactivo(eliminar_reactivo_button);
	});

	$('button.remove_practicamaterial').each(function(){
			addRemovePracticaMaterial($(this));
	});

	$('button.remove_practicareactivo').each(function(){
			addRemovePracticaReactivo($(this));
	});

	$('select.change-unity').each(function(){
		addChangeUnity($(this));
	});

	$("#horas,#minutos").change(function(){
		cambiarasegundos();
	});
});
</script>
@endpush
