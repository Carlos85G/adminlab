@extends("la.layouts.app")

@section("contentheader_title")
	<a href="{{ url(config('laraadmin.adminRoute') . '/mensajes') }}">Mensaje</a> :
@endsection
@section("contentheader_description", $mensaje->$view_col)
@section("section", "Mensajes")
@section("section_url", url(config('laraadmin.adminRoute') . '/mensajes'))
@section("sub_section", "Editar")

@section("htmlheader_title", "Edici&oacute;n de Mensajes : ".$mensaje->$view_col)

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

<div class="box">
	<div class="box-header">

	</div>
	<div class="box-body">
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				{!! Form::model($mensaje, ['route' => [config('laraadmin.adminRoute') . '.mensajes.update', $mensaje->id ], 'method'=>'PUT', 'id' => 'mensaje-edit-form']) !!}
					@la_form($module)

					{{--
					@la_input($module, 'nombre')
					@la_input($module, 'email')
					@la_input($module, 'mensaje')
					--}}
                    <br>
					<div class="form-group">
						{!! Form::submit( 'Actualizar', ['class'=>'btn btn-success']) !!} <button class="btn btn-default pull-right"><a href="{{ url(config('laraadmin.adminRoute') . '/mensajes') }}">Cancelar</a></button>
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
	$("#mensaje-edit-form").validate({

	});
});
</script>
@endpush
