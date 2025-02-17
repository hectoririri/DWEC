<?php

use App\Http\Controllers\VehiculoCtrl;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::resource('vehiculos', VehiculoCtrl::class);
