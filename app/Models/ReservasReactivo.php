<?php
/**
 * Model genrated using LaraAdmin
 * Help: http://laraadmin.com
 */

namespace App\Models;

use App\MovimientoReactivo;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ReservasReactivo extends Model
{
    use SoftDeletes;

	protected $table = 'reservasreactivos';

	protected $hidden = [

    ];

	protected $guarded = [];

	protected $dates = ['deleted_at'];

  /**
   * Función publica para recuperar los movimientos de reactivos que esta reservación realizó
   * @return Collection(App\MovimientoReactivo)
   */
  public function movimientos()
  {
      return $this->morphMany(MovimientoReactivo::class, 'asignable');
  }
}
