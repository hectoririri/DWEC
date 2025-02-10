<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasOne;

class Retirada extends Model
{
    protected $table = "retiradas";
    protected $primaryKey = "id";
    public $timestamps = false;
    protected $guarded = [];

    /**
     * Relación uno a uno con tarifa
     *
     * @return HasOne
     */
    public function tarifa(): BelongsTo
    {
        return $this->BelongsTo(Tarifa::class, 'id_tarifa', 'id');
    }

    /**
     * Relación uno a uno con vehiculo
     *
     * @return HasOne
     */
    public function vehiculo(): BelongsTo
    {
        return $this->BelongsTo(Vehiculo::class, 'id_vehiculos', 'id');
    }

    /**
     * Devuelve todos las retiradas
     *
     * @return json retirada
     */
    public function index()
    {
        $retirada = self::all()->toJson();
        return $retirada;
    }
}
