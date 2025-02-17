<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Class Retirada
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
class Retirada extends Model
{
    
    protected $perPage = 20;
    public $timestamps = false;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = ['id_vehiculos', 'id_tarifa', 'nombre', 'nif', 'domicilio', 'poblacion', 'provincia', 'permiso', 'fecha', 'agente'];


    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function vehiculo()
    {
        return $this->belongsTo(\App\Models\Vehiculo::class, 'id_vehiculos', 'id');
    }
    
    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function tarifa()
    {
        return $this->belongsTo(\App\Models\Tarifa::class, 'id_tarifa', 'id');
    }
    
}
