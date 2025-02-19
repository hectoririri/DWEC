<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Class Liquidacion
 *
 * @property $id
 * @property $id_vehiculos
 * @property $id_tarifa
 * @property $nombre
 * @property $nif
 * @property $domicilio
 * @property $poblacion
 * @property $provincia
 * @property $permiso
 * @property $fecha
 * @property $agente
 *
 * @property Vehiculo $vehiculo
 * @property Tarifa $tarifa
 * @package App
 * @mixin \Illuminate\Database\Eloquent\Builder
 */
class Liquidacion extends Model
{
    
    protected $perPage = 20;
    public $timestamps = false;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $guarded = [];


    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function retirada()
    {
        return $this->belongsTo(\App\Models\Retirada::class, 'id_vehiculos', 'id');
    }
    
    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function tarifa()
    {
        return $this->belongsTo(\App\Models\Tarifa::class, 'id_tarifa', 'id');
    }
    
}
