@extends("la.layouts.app")

@section("contentheader_title")
	<a href="{{ url(config('laraadmin.adminRoute') . '/reservasmateriales') }}">Reservaci&oacute;n de Material</a> :
@endsection
@section("contentheader_description", $reservasmateriale->$view_col)
@section("section", "Reservaci&oacute;n de Material")
@section("section_url", url(config('laraadmin.adminRoute') . '/reservasmateriales'))
@section("sub_section", "Edici&oacute;n")

@section("htmlheader_title", "Edici&oacute;n de Reservaci&oacute;n de Material : ".$reservasmateriale->$view_col)

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

<div class="box">
	<div class="box-header">

	</div>
	<div class="box-body">
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				{!! Form::model($reservasmateriale, ['route' => [config('laraadmin.adminRoute') . '.reservasmateriales.update', $reservasmateriale->id ], 'method'=>'PUT', 'id' => 'reservasmateriale-edit-form']) !!}
					{{--@la_form($module)--}}


					@la_input($module, 'material_id')
					@la_input($module, 'cantidad')
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
                    <br>
					<div class="form-group">
						{!! Form::submit( 'Actualizar', ['class'=>'btn btn-success']) !!} <button class="btn btn-default pull-right"><a href="{{ url(config('laraadmin.adminRoute') . '/reservasmateriales') }}">Cancelar</a></button>
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
	$("#reservasmateriale-edit-form").validate({

	});
});
</script>
@endpush
