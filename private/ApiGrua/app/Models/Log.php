<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class Log extends Model
{
    protected $table = "log";
    protected $primaryKey = "id";
    public $timestamps = false;
    protected $guarded = [];

    // Relación muchos a uno (muchos logs pertenecen a un usuario)
    public function Usuario(): BelongsTo
    {
        return $this->belongsTo(Usuario::class, 'usuario_id'. 'id');
    }

    /**
     * Devuelve todos los log
     *
     * @return json log
     */
    public static function getLogs()
    {
        $log = self::all()->toJson();
        return $log;
    }
}
