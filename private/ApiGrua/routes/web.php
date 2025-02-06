<?php

use App\Models\Usuario;
use App\Models\Vehiculo;
use Illuminate\Support\Facades\Route;

Route::get('/todos/vehiculos', [Vehiculo::class, 'index']);
Route::get('/todos/usuarios', [Usuario::class, 'index']);
