<?php

use App\Models\Log;
use App\Models\Retirada;
use App\Models\Tarifa;
use App\Models\Usuario;
use App\Models\Vehiculo;
use Illuminate\Support\Facades\Route;

Route::get('/todos/vehiculos', [Vehiculo::class, 'index']);
Route::get('/todos/usuarios', [Usuario::class, 'index']);
Route::get('/todos/logs', [Log::class, 'index']);
Route::get('/todos/tarifas', [Tarifa::class, 'index']);
Route::get('/todos/retiradas', [Retirada::class, 'index']);

