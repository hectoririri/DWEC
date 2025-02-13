<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\SoftDeletes;

class Tarifa extends Model
{
    use SoftDeletes;
    protected $table = "tarifa";
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
        return $this->hasOne(Retirada::class, 'id_tarifa', 'id');
    }

    /**
     * Devuelve todos las tarifas
     *
     * @return json tarifas
     */
    public function index()
    {
        $tarifas = self::all()->toJson();
        return $tarifas;
    }
}
