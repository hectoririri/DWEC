<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

/**
 * Class Retirada
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
class Retirada extends Model
{
    use SoftDeletes;
    public $timestamps = false;
    protected $perPage = 20;
    protected $table = 'retiradas';
    public $incrementing = false;
    protected $keyType = 'string';
    protected $primaryKey = 'id';
    protected $guarded = [];
    
    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function liquidacion()
    {
        return $this->hasMany(\App\Models\Liquidacion::class, 'id', 'id_vehiculos');
    }
    
}
