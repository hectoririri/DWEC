<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

/**
 * Class Usuario
 *
 * @property $id
 * @property $email
 * @property $password
 * @property $borrado
 * @property $rol
 * @property $deleted_at
 *
 * @property Log[] $logs
 * @package App
 * @mixin \Illuminate\Database\Eloquent\Builder
 */
class Usuario extends Model
{
    use SoftDeletes;
    public $timestamps = false;

    protected $perPage = 20;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = ['email', 'rol', 'password'];


    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function logs()
    {
        return $this->hasMany(\App\Models\Log::class, 'id', 'usuario_id');
    }
    
}
