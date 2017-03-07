@extends("la.layouts.app")

@section("contentheader_title")
	<a href="{{ url(config('laraadmin.adminRoute') . '/materiales') }}">Materiale</a> :
@endsection
@section("contentheader_description", $materiale->$view_col)
@section("section", "Materiales")
@section("section_url", url(config('laraadmin.adminRoute') . '/materiales'))
@section("sub_section", "Edit")

@section("htmlheader_title", "Materiales Edit : ".$materiale->$view_col)

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
				{!! Form::model($materiale, ['route' => [config('laraadmin.adminRoute') . '.materiales.update', $materiale->id ], 'method'=>'PUT', 'id' => 'materiale-edit-form']) !!}
					@la_form($module)
					
					{{--
					@la_input($module, 'estante')
					@la_input($module, 'anaquel')
					@la_input($module, 'codigo')
					@la_input($module, 'marca')
					@la_input($module, 'descripcion')
					@la_input($module, 'cantidad')
					--}}
                    <br>
					<div class="form-group">
						{!! Form::submit( 'Update', ['class'=>'btn btn-success']) !!} <button class="btn btn-default pull-right"><a href="{{ url(config('laraadmin.adminRoute') . '/materiales') }}">Cancel</a></button>
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
	$("#materiale-edit-form").validate({
		
	});
});
</script>
@endpush
