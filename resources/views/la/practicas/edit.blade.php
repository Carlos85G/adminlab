@extends("la.layouts.app")

@section("contentheader_title")
	<a href="{{ url(config('laraadmin.adminRoute') . '/practicas') }}">Pr&aacute;ctica</a> :
@endsection
@section("contentheader_description", $practica->$view_col)
@section("section", "Pr&aacute;cticas")
@section("section_url", url(config('laraadmin.adminRoute') . '/practicas'))
@section("sub_section", "Editar")

@section("htmlheader_title", "Editar Pr&aacute;cticas : ".$practica->$view_col)

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

<div class="box">
	<div class="box-header">

	</div>
	<div class="box-body">
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				{!! Form::model($practica, ['route' => [config('laraadmin.adminRoute') . '.practicas.update', $practica->id ], 'method'=>'PUT', 'id' => 'practica-edit-form']) !!}
					{{--
						@la_form($module)
					--}}

					@la_input($module, 'nombre')
					@la_input($module, 'objetivo')
					<label for="practica_materiales">Materiales* :</label>
					<div id="practica_materiales">
					@foreach($practica->materiales as $practicamaterial)
						<div class="row practicamaterial">
							<div class="form-group col-md-5">
								<select class="form-control" required="1" data-placeholder="Seleccione un Material" rel="select2" name="practicamaterial[{{ $practicamaterial->id }}]">
									@foreach($materiales as $material)
									<option value="{{ $material->id }}"{{ ($practicamaterial->material_id === $material->id)? ' selected="selected"' : '' }} >{{ $material->descripcion }}</option>
									@endforeach
								</select>
							</div>
							<div class="form-group col-md-2">
								<input class="form-control" placeholder="Indique candidad de material " required="1" name="practicamaterial_cantidad[{{ $practicamaterial->id }}]" type="number" value="{{ $practicamaterial->cantidad }}" />
							</div>
							<div class="form-group col-md-4">
								<label for="practicamaterial_por_grupo[{{ $practicamaterial->id }}]">&iquest;Para todos?:</label>
								<input type="hidden" value="{{ ($practicamaterial->por_grupo == 1)? 'true' : 'false' }}" name="practicamaterial_por_grupo_hidden[{{ $practicamaterial->id }}]" />
								<input class="form-control" name="practicamaterial_por_grupo[{{ $practicamaterial->id }}]" type="checkbox" value="practicamaterial_por_grupo[{{ $practicamaterial->id }}]"{!! ($practicamaterial->por_grupo === 1)? ' checked="checked"' : '' !!} />
								<div class="Switch Round {{ ($practicamaterial->por_grupo == 1)? 'On' : 'Off' }}" style="vertical-align:top;margin-left:10px;">
									<div class="Toggle"></div>
								</div>
							</div>
							<div class="form-group col-md-1">
								<button type="button" class="btn btn-danger btn-xs remove_practicamaterial">
									<i class="fa fa-times"></i>
								</button>
							</div>
						</div>
					@endforeach
					</div>
					<div class="form-group">
						<div class="btn btn-success btn-md" id="nuevo-material">A&ntilde;adir nuevo Material</div>
					</div>
					<label for="practica_reactivos">Reactivos* :</label>
					<div id="practica_reactivos">


						{{--Aquí van los reactivos--}}


						
					</div>
					<div class="form-group">
						<div class="btn btn-success btn-md" id="nuevo-reactivo">A&ntilde;adir nuevo Reactivo</div>
					</div>
					<div class="form-group">
							<label for="Horas">Horas * :</label>
							<input class="form-control" id="horas" placeholder="Introduce n&uacute;mero de horas" required="1" name="horas" type="number" value="{{ (int) ($practica->duracion / 3600) }}" aria-required="true" />
							<label for="Minutos">Minutos * :</label>
							<input class="form-control" id="minutos" placeholder="Introduce n&uacute;mero de minutos" required="1" name="minutos" type="number" value="{{ (int) ($practica->duracion % 3600) }}" aria-required="true" />
							<input id="duracion" name="duracion" type="hidden" value="{{ $practica->duracion }}" />
					</div>
					@la_input($module, 'practica_pdf')
                    <br>
					<div class="form-group">
						{!! Form::submit( 'Actualizar', ['class'=>'btn btn-success']) !!} <button class="btn btn-default pull-right"><a href="{{ url(config('laraadmin.adminRoute') . '/practicas') }}">Cancelar</a></button>
					</div>
				{!! Form::close() !!}
			</div>
		</div>
	</div>
</div>

@endsection

@push('scripts')
<script>
$(function () {
	$("#practica-edit-form").validate({

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
					class: "form-control",
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
		nombre_reactivo.change(function(){
			cantidad_reactivo_unidad.html($(this).find("option:selected").attr('data-unidad'));
		}).change();
		addRemovePracticaReactivo(eliminar_reactivo_button);
	});


	$('button.remove_practicamaterial').each(function(){
			addRemovePracticaMaterial($(this));
	});

	$('button.remove_practicareactivo').each(function(){
			addRemovePracticaReactivo($(this));
	});

	$("#horas,#minutos").change(function(){
		cambiarasegundos();
	});
});
</script>
@endpush
