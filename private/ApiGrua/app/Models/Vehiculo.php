<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Vehiculo extends Model
{
    use SoftDeletes;
    protected $table = "vehiculos";
    protected $primaryKey = "id";
    public $timestamps = false;
    protected $guarded = [];

    public function index()
    {
        $vehiculos = self::all()->toJson();
        return $vehiculos;
    }
}
