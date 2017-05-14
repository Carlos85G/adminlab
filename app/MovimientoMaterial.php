<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Models\Materiale;

class MovimientoMaterial extends Model
{
  use SoftDeletes;

  protected $table = 'movimientosmateriales';

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
	 * Función publica de cambio de cantidad en material
   * @return void
	 */
  public function efectuarCambio()
  {
    $material = Materiale::find($this->material_id);

    $material->cantidad += $this->cantidad;
    $material->save();

    /*Guardar el cambio*/
    $this->save();
  }

  /**
   * Función publica de revertimiento de cambio de cantidad en material
   * @return void
   */
  public function deshacerCambio()
  {
    $material = Materiale::find($this->material_id);

    $material->cantidad -= $this->cantidad;
    $material->save();

    /*Borrar el registro*/
    $this->delete();
  }
}
