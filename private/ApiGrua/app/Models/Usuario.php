<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Usuario extends Model
{
    use SoftDeletes;
    protected $table = "usuario";
    protected $primaryKey = "id";
    public $timestamps = false;
    protected $guarded = [];

    // Relación uno a muchos (un usuario tiene muchos logs)
    public function log(): HasMany
    {
        return $this->hasMany(Log::class);
    }

    /**
     * Devuelve todos los usuarios
     *
     * @return json usuarios
     */
    public function index()
    {
        $usuarios = self::all()->toJson();
        return $usuarios;
    }

}

