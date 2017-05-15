<?php
/**
 * Model genrated using LaraAdmin
 * Help: http://laraadmin.com
 */

namespace App\Models;

use App\MovimientoReactivo;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ReservasPractica extends Reserva
{
  /**
   * Función publica para establecer la relación única entre la reservación de práctica y la definición de práctica
   * @return \App\Models\Practica
   */
  public function practica()
  {
      return $this->hasOne(\App\Models\Practica::class, 'id', 'practica_id');
  }

  /**
   * Función publica para recuperar los movimientos de reactivos que esta práctica realizó
   * @return Collection(App\MovimientoReactivo)
   */
  public function movimientosReactivos()
  {
      return $this->morphMany(MovimientoReactivo::class, 'asignable');
  }
}
