<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('retiradas', function (Blueprint $table) {
            $table->id();
            $table->string('id_vehiculos')->nullable();
            $table->foreignId('id_tarifa')->nullable()->constrained('tarifas')->onDelete('set null');
            $table->string('nombre', 500)->nullable();
            $table->string('nif', 500)->nullable();
            $table->string('domicilio', 500)->nullable();
            $table->string('poblacion', 500)->nullable();
            $table->string('provincia', 500)->nullable();
            $table->string('permiso', 500)->nullable();
            $table->datetime('fecha')->nullable();
            $table->string('agente', 500)->nullable();
            $table->foreign('id_vehiculos')->references('id')->on('vehiculos')->onDelete('set null');
            $table->primary('id');
        });
    }

    public function down()
    {
        Schema::dropIfExists('retiradas');
    }
};