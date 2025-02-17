<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

/**
 * Class Vehiculo
 *
 * @property $id
 * @property $fecha_entrada
 * @property $fecha_salida
 * @property $lugar
 * @property $direccion
 * @property $agente
 * @property $matricula
 * @property $marca
 * @property $modelo
 * @property $color
 * @property $motivo
 * @property $tipo_vehiculo
 * @property $grua
 * @property $estado
 * @property $fecha
 * @property $deleted_at
 *
 * @property Retirada[] $retiradas
 * @package App
 * @mixin \Illuminate\Database\Eloquent\Builder
 */
class Vehiculo extends Model
{
    use SoftDeletes;
    public $timestamps = false;
    protected $perPage = 20;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = ['fecha_entrada', 'fecha_salida', 'lugar', 'direccion', 'agente', 'matricula', 'marca', 'modelo', 'color', 'motivo', 'tipo_vehiculo', 'grua', 'estado', 'fecha'];


    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function retiradas()
    {
        return $this->hasMany(\App\Models\Retirada::class, 'id', 'id_vehiculos');
    }
    
}
