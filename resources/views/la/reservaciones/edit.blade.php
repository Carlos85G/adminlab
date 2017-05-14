@extends("la.layouts.app")

@section("contentheader_title")
	<a href="{{ url(config('laraadmin.adminRoute') . '/reservaciones') }}">Reservacione</a> :
@endsection
@section("contentheader_description", $reservacione->$view_col)
@section("section", "Reservaciones")
@section("section_url", url(config('laraadmin.adminRoute') . '/reservaciones'))
@section("sub_section", "Edit")

@section("htmlheader_title", "Reservaciones Edit : ".$reservacione->$view_col)

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
				{!! Form::model($reservacione, ['route' => [config('laraadmin.adminRoute') . '.reservaciones.update', $reservacione->id ], 'method'=>'PUT', 'id' => 'reservacione-edit-form']) !!}
					@la_form($module)

					{{--
					@la_input($module, 'fecha_inicio')
					@la_input($module, 'fecha_fin')
					--}}
                    <br>
					<div class="form-group">
						{!! Form::submit( 'Actualizar', ['class'=>'btn btn-success']) !!} <button class="btn btn-default pull-right"><a href="{{ url(config('laraadmin.adminRoute') . '/reservaciones') }}">Cancel</a></button>
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
	$("#reservacione-edit-form").validate({

	});
});
</script>
@endpush
