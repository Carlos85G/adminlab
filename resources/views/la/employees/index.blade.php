@extends("la.layouts.app")

@section("contentheader_title", "Usuarios")
@section("contentheader_description", "Listado de Usuarios")
@section("section", "Usuarios")
@section("sub_section", "Listado")
@section("htmlheader_title", "Listado de Usuarios")

@section("headerElems")
@la_access("Employees", "create")
	<button class="btn btn-success btn-sm pull-right" data-toggle="modal" data-target="#AddModal">A&ntilde;adir Usuario</button>
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

@la_access("Employees", "create")
<div class="modal fade" id="AddModal" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Cerrar"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="myModalLabel">A&ntilde;adir Usuario</h4>
			</div>
			{!! Form::open(['action' => 'LA\EmployeesController@store', 'id' => 'employee-add-form']) !!}
			<div class="modal-body">
				<div class="box-body">
                    @la_form($module)

					{{--
					@la_input($module, 'name')
					@la_input($module, 'designation')
					@la_input($module, 'gender')
					@la_input($module, 'mobile')
					@la_input($module, 'mobile2')
					@la_input($module, 'email')
					@la_input($module, 'dept')
					@la_input($module, 'city')
					@la_input($module, 'address')
					@la_input($module, 'about')
					@la_input($module, 'date_birth')
					@la_input($module, 'date_hire')
					@la_input($module, 'date_left')
					@la_input($module, 'salary_cur')
					--}}
					<div class="form-group">
						<label for="role">Rol* :</label>
						<select class="form-control" required="1" data-placeholder="Seleccione un Rol" rel="select2" name="role">
							<?php $roles = App\Role::all(); ?>
							@foreach($roles as $role)
								@if($role->id != 1)
									<option value="{{ $role->id }}">{{ $role->name }}</option>
								@endif
							@endforeach
						</select>
					</div>
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
        ajax: "{{ url(config('laraadmin.adminRoute') . '/employee_dt_ajax') }}",
				language: {
						lengthMenu: "_MENU_",
						search: "_INPUT_",
						searchPlaceholder: "Buscar",
						emptyTable: "No hay registros",
						info: "Mostrando desde _START_ hasta _END_ de _TOTAL_ registros",
						infoEmpty: "Mostrando desde 0 hasta 0 de 0 registros",
						infoFiltered: "(filtrado de un total de _MAX_ registros)",
						infoPostFix: "",
						thousands: ",",
						lengthMenu: "Mostrar los _MENU_ registros",
						loadingRecords: "Cargando...",
						processing: "Procesando...",
						zeroRecords: "No se encontraron coincidencias",
						paginate: {
								first: "Primero",
								last: "&Uacute;ltimo",
								next: "Siguiente",
								previous: "Anterior"
						},
						aria: {
								sortAscending: ": activar para ordenar la columna de manera ascendente",
								sortDescending: ": activar para ordenar la columna de manera descendente"
						}
				},
		@if($show_actions)
		columnDefs: [ { orderable: false, targets: [-1] }],
		@endif
	});
	$("#employee-add-form").validate({

	});
});
</script>
@endpush