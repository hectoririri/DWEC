<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Class Log
 *
 * @property $id
 * @property $usuario_id
 * @property $accion
 * @property $descripcion
 * @property $fecha
 * @property $created_at
 * @property $updated_at
 *
 * @property Usuario $usuario
 * @package App
 * @mixin \Illuminate\Database\Eloquent\Builder
 */
class Log extends Model
{
    
    protected $perPage = 20;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $guarded = [];


    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function usuario()
    {
        return $this->belongsTo(\App\Models\Usuario::class, 'usuario_id', 'id');
    }
    
}
