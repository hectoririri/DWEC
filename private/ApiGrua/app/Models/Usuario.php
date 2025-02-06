<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Usuario extends Model
{
    use SoftDeletes;
    protected $table = "usuarios";
    protected $primaryKey = "id";
    public $timestamps = false;
    protected $guarded = [];

    public function index()
    {
        $usuarios = self::all()->toJson();
        return $usuarios;
    }

}

