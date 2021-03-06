@extends("la.layouts.app")

@section("contentheader_title")
	<a href="{{ url(config('laraadmin.adminRoute') . '/roles') }}">Rol</a> :
@endsection
@section("contentheader_description", $role->$view_col)
@section("section", "Roles")
@section("section_url", url(config('laraadmin.adminRoute') . '/roles'))
@section("sub_section", "Editar")

@section("htmlheader_title", "Edici&oacute;n de Rol : ".$role->$view_col)

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
				{!! Form::model($role, ['route' => [config('laraadmin.adminRoute') . '.roles.update', $role->id ], 'method'=>'PUT', 'id' => 'role-edit-form']) !!}
					{{--@la_form($module)--}}

					@la_input($module, 'name')
					@la_input($module, 'display_name')
					@la_input($module, 'description')
					@la_input($module, 'parent')
					@la_input($module, 'dept')
					@if(Entrust::hasRole('SUPER_ADMIN') || Entrust::hasRole('LabAdmin'))
						@la_input($module, 'dias_max_laboratorio')
						@la_input($module, 'dias_max_material')
					@endif
                    <br>
					<div class="form-group">
						{!! Form::submit( 'Actualizar', ['class'=>'btn btn-success']) !!} <button class="btn btn-default pull-right"><a href="{{ url(config('laraadmin.adminRoute') . '/roles') }}">Cancelar</a></button>
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
	$("#role-edit-form").validate({

	});
});
</script>
@endpush
