<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\SoftDeletes;

class Vehiculo extends Model
{
    use SoftDeletes;
    protected $table = "vehiculos";
    protected $primaryKey = "id";
    public $timestamps = false;
    protected $guarded = [];

    /**
     * Relación uno a uno con retirada
     *
     * @return HasOne
     */
    public function retirada(): HasOne
    {
        return $this->hasOne(Retirada::class, 'id_vehiculos', 'id');
    }

    /**
     * Devuelve todos los vehiculos
     *
     * @return json vehiculos
     */
    public function index()
    {
        $vehiculos = self::all()->toJson();
        return $vehiculos;
    }
}
