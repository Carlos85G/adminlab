<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Models\Reactivo;

class MovimientoReactivo extends Model
{
  use SoftDeletes;

  protected $table = 'movimientosreactivos';

  protected $hidden = [];

  protected $guarded = [];

  protected $dates = ['deleted_at'];

  /**
   * Función para recuperar el asignable que pidió el movimiento de material o reactivo.
   * @return mixed: La práctica o préstamo que hizo el movimiento.
   */
  public function asignable()
  {
    $this->morphTo();
  }

  /**
   * Función public de cambio de cantidad en reactivo
   * @return void
   */
  public function efectuarCambio()
  {
    $reactivo = Reactivo::find($this->reactivo_id);

    $reactivo->cantidad += $this->cantidad;
    $reactivo->save();

    /*Guardar el cambio*/
    $this->save();
  }

  /**
   * Función publica de revertimiento de cambio de cantidad en reactivo
   * @return void
   */
  public function deshacerCambio()
  {
    $reactivo = Reactivo::find($this->reactivo_id);

    $reactivo->cantidad -= $this->cantidad;
    $reactivo->save();

    /*Borrar el registro*/
    $this->delete();
  }
}
