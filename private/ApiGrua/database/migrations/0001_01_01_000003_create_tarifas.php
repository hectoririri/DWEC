<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('tarifas', function (Blueprint $table) {
            $table->id();
            $table->string('opcion_pago', 500)->nullable();
            $table->float('importe_retirada')->nullable();
            $table->float('importe_deposito')->nullable();
            $table->float('horas_gratis')->nullable();
            $table->float('costo_por_hora')->nullable();
            $table->float('total')->nullable();
        });
    }

    public function down()
    {
        Schema::dropIfExists('tarifas');
    }
};