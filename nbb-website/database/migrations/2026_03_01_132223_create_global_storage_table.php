<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('global_storage', function (Blueprint $table) {
            // Cria os campos exatamente como na imagem:
            $table->integer('key'); // key
            $table->integer('world_id')->default(0); // world_id
            $table->integer('value'); // value

            // Define a chave primária composta (key + world_id)
            $table->primary(['key', 'world_id']);
            
            $table->timestamps(); // Recomendado pelo Laravel, embora opcional para tabelas de OT puro.
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('global_storage');
    }
};