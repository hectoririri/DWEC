<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('vehiculos', function (Blueprint $table) {
            $table->string('id', 500)->primary();
            $table->datetime('fecha_entrada')->nullable();
            $table->datetime('fecha_salida')->nullable();
            $table->string('lugar', 500)->nullable();
            $table->string('direccion', 500)->nullable();
            $table->string('agente', 500)->nullable();
            $table->string('matricula', 500)->nullable();
            $table->string('marca', 500)->nullable();
            $table->string('modelo', 500)->nullable();
            $table->string('color', 500)->nullable();
            $table->string('motivo', 500)->nullable();
            $table->string('tipo_vehiculo', 500)->nullable();
            $table->string('grua', 500)->nullable();
            $table->string('estado', 500)->default('En depósito');
            $table->datetime('fecha')->nullable();
            $table->softDeletes();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('vehiculos');
    }
};