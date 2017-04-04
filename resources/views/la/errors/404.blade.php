@extends('la.layouts.app')

@section('htmlheader_title')
    P&aacute;gina no encontrada
@endsection

@section('contentheader_title')
    P&aacute;gina de error 404
@endsection

@section('$contentheader_description')
@endsection

@section('main-content')

<div class="error-page">
    <h2 class="headline text-yellow"> 404</h2>
    <div class="error-content">
        <h3><i class="fa fa-warning text-yellow"></i> &iexcl;Ups! P&aacute;gina no encontrada.</h3>
        <p>
            No pudimos encontrar la p&aacute;gina que estabas buscando.
            Mientras tanto, puedes <a href='{{ url('/home') }}'>regresar al Inicio</a> o volver a intentar usando el formulario de b&uacute;squeda.
        </p>
        <form class='search-form'>
            <div class='input-group'>
                <input type="text" name="search" class='form-control' placeholder="Buscar"/>
                <div class="input-group-btn">
                    <button type="submit" name="submit" class="btn btn-warning btn-flat"><i class="fa fa-search"></i></button>
                </div>
            </div><!-- /.input-group -->
        </form>
    </div><!-- /.error-content -->
</div><!-- /.error-page -->
@endsection
