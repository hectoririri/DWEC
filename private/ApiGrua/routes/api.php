<?php

use App\Http\Controllers\LogCtrl;
use App\Http\Controllers\RetiradaCtrl;
use App\Http\Controllers\TarifaCtrl;
use App\Http\Controllers\UsuarioCtrl;
use App\Http\Controllers\LiquidacionCtrl;
use Illuminate\Support\Facades\Route;

Route::get('retiradas/disponibles', [RetiradaCtrl::class, 'getDisponibles']);
Route::resource('retiradas', RetiradaCtrl::class);
Route::resource('logs', LogCtrl::class);
Route::resource('usuarios', UsuarioCtrl::class);
Route::resource('tarifas', TarifaCtrl::class);
Route::resource('liquidaciones', LiquidacionCtrl::class);
