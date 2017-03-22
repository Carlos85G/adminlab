@extends("la.layouts.app")

@section("contentheader_title")
	<a href="{{ url(config('laraadmin.adminRoute') . '/laboratorios') }}">Laboratorio</a> :
@endsection
@section("contentheader_description", $laboratorio->$view_col)
@section("section", "Laboratorios")
@section("section_url", url(config('laraadmin.adminRoute') . '/laboratorios'))
@section("sub_section", "Edit")

@section("htmlheader_title", "Editar Laboratorios : ".$laboratorio->$view_col)

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
				{!! Form::model($laboratorio, ['route' => [config('laraadmin.adminRoute') . '.laboratorios.update', $laboratorio->id ], 'method'=>'PUT', 'id' => 'laboratorio-edit-form']) !!}
					@la_form($module)

					{{--
					@la_input($module, 'nombre')
					--}}
                    <br>
					<div class="form-group">
						{!! Form::submit( 'Actualizar', ['class'=>'btn btn-success']) !!} <button class="btn btn-default pull-right"><a href="{{ url(config('laraadmin.adminRoute') . '/laboratorios') }}">Cancelar</a></button>
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
	$("#laboratorio-edit-form").validate({

	});
});
</script>
@endpush
