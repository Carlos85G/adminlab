<?php

namespace App;

use Zizaco\Entrust\EntrustRole;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class PracticaReactivo extends Model
{
    use SoftDeletes;

    protected $table = 'practicasreactivos';

    protected $hidden = [

    ];

    protected $guarded = [];

    protected $dates = ['deleted_at'];

    /**
     * Función publica para establecer la relación entre la cantidad de reactivo y la práctica
     * @return array(Practica)
     */
    public function practica()
    {
        return $this->belongsTo(\App\Models\Practica::class, 'id', 'practica_id');
    }

    /**
     * Función publica para establecer la relación entre la cantidad de reactivo y el reactivo
     * @return array(Reactivo)
     */
    public function reactivo()
    {
      return $this->hasOne(\App\Models\Reactivo::class, 'id', 'reactivo_id');
    }
}
