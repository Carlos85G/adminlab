<?php

namespace App;

use Zizaco\Entrust\EntrustRole;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class PracticaMaterial extends Model
{
    use SoftDeletes;

    protected $table = 'practicasmateriales';

    protected $hidden = [

    ];

    protected $guarded = [];

    protected $dates = ['deleted_at'];

    /**
     * Función publica para establecer la relación entre la cantidad de material y la práctica
     * @return array(Practica)
     */
    public function practica()
    {
        return $this->belongsTo(\App\Models\Practica::class, 'id', 'practica_id');
    }

     /**
      * Función publica para establecer la relación entre la cantidad de material y el material
      * @return array(Materiale)
      */
    public function material()
    {
      return $this->hasOne(\App\Models\Materiale::class, 'id', 'material_id');
    }
}
