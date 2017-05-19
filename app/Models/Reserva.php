<?php
/**
 * Model genrated using LaraAdmin
 * Help: http://laraadmin.com
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Reserva extends Model
{
    use SoftDeletes;

	protected $table = 'reservas';

	protected $hidden = [

    ];

	protected $guarded = [];

	protected $dates = ['deleted_at'];

  /**
   * Sobreescritura de función para recuperar el original de acuerdo al tipo (polimorfismo).
   * @param array $attributes: los valores de cada columna, proveniente de la base de datos
   * @param connection|null $connection: Conexión a usar para recuperar la instancia (necesario por interfaz)
   * @return mixed: Nueva instancia de reservación
   */
  public function newFromBuilder($attributes = array(), $connection = null)
  {
      $instance = new $attributes->reserva_type;
      $instance->exists = true;
      $instance->setRawAttributes((array) $attributes, true);
      return $instance;
  }

  /**
	 * Función pública para obtener las reservaciones de un laboratorio especificado de acuerdo al rango de fechas enviado. Si el evento existente empieza en la fecha especificada por $fechaFinYMD, no será retornado por la función.
	 * @param string $fechaInicioYMD: Fecha y hora de inicio en formato "Y-m-d H:i:s"
	 * @param string $fechaFinYMD: Fecha y hora de fin en formato "Y-m-d H:i:s"
	 * @param int $idLaboratorio: ID de laboratorio existente
	 * @return Illuminate\Database\Eloquent\Collection(ReservasPractica)
	 */
	public static function encontrarConflictos($idLaboratorio, $fechaInicioYMD, $fechaFinYMD)
  {
    /*
    Cambio de lógica en las fechas cruzadas

    return self::where(function($query) use ($fechaInicioYMD, $fechaFinYMD){
			$query->orWhere(function($query) use ($fechaInicioYMD, $fechaFinYMD){

        ... Si es que la fecha de inicio del evento existente está dentro del rango...

				Este código busca en rango sin tomar en cuenta el final, a diferencia de usar whereBetween

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

        ...O si la fecha de fin del evento existente está dentro del rango...

				Este código busca en rango sin tomar en cuenta el inicio, a diferencia de usar whereBetween

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

        ... O si el rango de fechas está dentro de otro evento existente...

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

        ... O si el rango de fechas abarca algún evento existente

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

      En el laboratorio indicado...

      'laboratorio_id',
      $idLaboratorio
    )->orderBy(
      'id',
      'asc'
    )->get();*/

    return self::where(function($query) use ($fechaInicioYMD, $fechaFinYMD){
      $query->orWhere(function($query) use ($fechaInicioYMD, $fechaFinYMD){
				/* ... Si es que el rango de fechas del evento existente cruza al menos con la fecha de inicio... */

				/* Este código busca en rango sin tomar en cuenta el final, a diferencia de usar whereBetween*/
				$query->where(
					'fecha_inicio',
					'<=',
					$fechaInicioYMD
				)->where(
					'fecha_fin',
					'>',
					$fechaInicioYMD
				);
			})->orWhere(function($query) use ($fechaInicioYMD, $fechaFinYMD){
				/* ... O si es que el rango de fechas del evento existente cruza al menos con la fecha de fin... */

				/* Este código busca en rango sin tomar en cuenta el inicio, a diferencia de usar whereBetween*/
				$query->where(
					'fecha_inicio',
					'<',
					$fechaFinYMD
				)->where(
					'fecha_fin',
					'>=',
					$fechaFinYMD
				);
			})->orWhere(function($query) use ($fechaInicioYMD, $fechaFinYMD){
				/*... O si el rango de fechas contiene otros eventos existente... */
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
      /*En el laboratorio indicado...*/
      'laboratorio_id',
      $idLaboratorio
    )->orderBy(
      'id',
      'asc'
    )->get();
	}

  /**
   * Función publica para establecer la relación única entre la reservación de práctica y la definición de laboratorio
   * @return \App\Models\Laboratorio
   */
  public function laboratorio()
  {
      return $this->hasOne(\App\Models\Laboratorio::class, 'id', 'laboratorio_id');
  }

  /**
   * Función publica para establecer la relación única entre la reservación de práctica y la definición de usuario
   * @return \App\Models\User
   */
  public function solicitante()
  {
      return $this->hasOne(\App\Models\User::class, 'id', 'solicitante_id');
  }
}
