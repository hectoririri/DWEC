<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Class Tarifa
 *
 * @property $id
 * @property $opcion_pago
 * @property $importe_retirada
 * @property $importe_deposito
 * @property $horas_gratis
 * @property $costo_por_hora
 * @property $total
 *
 * @property Retirada[] $retiradas
 * @package App
 * @mixin \Illuminate\Database\Eloquent\Builder
 */
class Tarifa extends Model
{
    public $timestamps = false;

    protected $perPage = 20;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = ['opcion_pago', 'importe_retirada', 'importe_deposito', 'horas_gratis', 'costo_por_hora', 'total'];


    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function retiradas()
    {
        return $this->hasMany(\App\Models\Retirada::class, 'id', 'id_tarifa');
    }
    
}
