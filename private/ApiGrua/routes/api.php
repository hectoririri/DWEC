<?php

use App\Http\Controllers\LogCtrl;
use App\Http\Controllers\RetiradaCtrl;
use App\Http\Controllers\TarifaCtrl;
use App\Http\Controllers\UsuarioCtrl;
use App\Http\Controllers\VehiculoCtrl;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::resource('vehiculos', VehiculoCtrl::class);
Route::resource('logs', LogCtrl::class);
Route::resource('usuarios', UsuarioCtrl::class);
Route::resource('tarifas', TarifaCtrl::class);
Route::resource('retiradas', RetiradaCtrl::class);