<?php
/**
 * Model genrated using LaraAdmin
 * Help: http://laraadmin.com
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Practica extends Model
{
    use SoftDeletes;

	protected $table = 'practicas';

	protected $hidden = [

    ];

	protected $guarded = [];

	protected $dates = ['deleted_at'];

  /**
   * Función publica para establecer la relación múltiple entre la práctica y la definición de materiales
   * @return array(PracticaMaterial)
   */
  public function materiales()
  {
      return $this->hasMany(\App\PracticaMaterial::class, 'practica_id', 'id');
  }

  /**
   * Función publica para establecer la relación múltiple entre la práctica y la definición de reactivos
   * @return array(PracticaReactivo)
   */
  /*
  Descomentar cuando esté implementado
  public function reactivos()
  {
      return $this->hasMany(\App\PracticaReactivo::class, 'reactivo_id', 'id');
  }
  */
}
