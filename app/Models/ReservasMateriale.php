<?php
/**
 * Model genrated using LaraAdmin
 * Help: http://laraadmin.com
 */

namespace App\Models;

use App\Models\Materiale;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ReservasMateriale extends Model
{
    use SoftDeletes;

	protected $table = 'reservasmateriales';

	protected $hidden = [

    ];

	protected $guarded = [];

	protected $dates = ['deleted_at'];

  /**
	 * Función pública para obtener las reservaciones de material que tienen el mismo material en común en un rango de fechas enviado. Si el evento existente empieza en la fecha especificada por $fechaFinYMD, no será retornado por la función.
	 * @param string $fechaInicioYMD: Fecha y hora de inicio en formato "Y-m-d H:i:s"
	 * @param string $fechaFinYMD: Fecha y hora de fin en formato "Y-m-d H:i:s"
	 * @param int $idMaterial: ID de material existente
	 * @return int: Cantidad de material disponible en las fechas
	 */
	public static function encontrarIncidencias($idMaterial, $fechaInicioYMD, $fechaFinYMD)
  {
    return self::where(function($query) use ($fechaInicioYMD, $fechaFinYMD){
			$query->orWhere(function($query) use ($fechaInicioYMD, $fechaFinYMD){
				/* ... Si es que la fecha de inicio del evento existente está dentro del rango... */

				/* Este código busca en rango sin tomar en cuenta el final, a diferencia de usar whereBetween*/
				$query->where(
					'fecha_inicio',
					'>=',
					$fechaInicioYMD
				)->where(
					'fecha_inicio',
					'<',
					$fechaFinYMD
				);
			})->orWhere(function($query) use ($fechaInicioYMD, $fechaFinYMD){
				/*...O si la fecha de fin del evento existente está dentro del rango... */

				/* Este código busca en rango sin tomar en cuenta el inicio, a diferencia de usar whereBetween*/
				$query->where(
					'fecha_fin',
					'>',
					$fechaInicioYMD
				)->where(
					'fecha_fin',
					'<=',
					$fechaFinYMD
				);
			})->orWhere(function($query) use ($fechaInicioYMD, $fechaFinYMD){
				/*... O si el rango de fechas está dentro de otro evento existente... */
				$query->where(
					'fecha_inicio',
					'<=',
					$fechaInicioYMD
				)->where(
					'fecha_fin',
					'>=',
					$fechaFinYMD
				);
			})->orWhere(function($query) use ($fechaInicioYMD, $fechaFinYMD){
				/*... O si el rango de fechas abarca algún evento existente */
				$query->where(
					'fecha_inicio',
					'>=',
					$fechaInicioYMD
				)->where(
					'fecha_fin',
					'<=',
					$fechaFinYMD
				);
			});
		})->where(
      /*con el material indicado...*/
      'material_id',
      $idMaterial
    )->orderBy(
      'id',
      'asc'
    )->get();
	}
}
