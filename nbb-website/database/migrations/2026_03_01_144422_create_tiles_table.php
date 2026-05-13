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
        Schema::create('tiles', function (Blueprint $table) {
            $table->id(); // id
            $table->integer('world_id')->default(0); // world_id
            
            // Relacionamento com a tabela de Houses
            $table->unsignedBigInteger('house_id'); // house_id
            
            // Coordenadas espaciais
            $table->integer('x'); 
            $table->integer('y');
            $table->integer('z');
            
            $table->timestamps();

            // Índices para busca rápida de tiles por coordenada
            $table->index(['x', 'y', 'z']);
            $table->index('house_id');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tiles');
    }
};