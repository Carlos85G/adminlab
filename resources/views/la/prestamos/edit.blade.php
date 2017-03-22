@extends("la.layouts.app")

@section("contentheader_title")
	<a href="{{ url(config('laraadmin.adminRoute') . '/prestamos') }}">Pr&eacute;stamo</a> :
@endsection
@section("contentheader_description", $prestamo->$view_col)
@section("section", "Pr&eacute;stamos")
@section("section_url", url(config('laraadmin.adminRoute') . '/prestamos'))
@section("sub_section", "Editar")

@section("htmlheader_title", "Editar P&eacute;estamos : ".$prestamo->$view_col)

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
				{!! Form::model($prestamo, ['route' => [config('laraadmin.adminRoute') . '.prestamos.update', $prestamo->id ], 'method'=>'PUT', 'id' => 'prestamo-edit-form']) !!}
					@la_form($module)

					{{--
					@la_input($module, 'fecha_inicio')
					@la_input($module, 'fecha_fin')
					--}}
                    <br>
					<div class="form-group">
						{!! Form::submit( 'Actualizar', ['class'=>'btn btn-success']) !!} <button class="btn btn-default pull-right"><a href="{{ url(config('laraadmin.adminRoute') . '/prestamos') }}">Cancelar</a></button>
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
	$("#prestamo-edit-form").validate({

	});
});
</script>
@endpush
