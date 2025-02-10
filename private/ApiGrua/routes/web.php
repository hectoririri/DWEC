<?php

use App\Models\Log;
use App\Models\Retirada;
use App\Models\Tarifa;
use App\Models\Vehiculo;
use App\Http\Controllers\UsuarioCtrl;
use Illuminate\Support\Facades\Route;

Route::get('vehiculos', [Vehiculo::class, 'index']);
Route::get('usuarios', [UsuarioCtrl::class, 'index']);
Route::get('logs', [Log::class, 'index']);
Route::get('tarifas', [Tarifa::class, 'index']);
Route::get('retiradas', [Retirada::class, 'index']);

