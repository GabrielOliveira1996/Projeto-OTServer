<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('player_spells', function (Blueprint $table) {
            // Referência ao Personagem
            $table->unsignedBigInteger('player_id');
            $table->foreign('player_id')->references('id')->on('players')->onDelete('cascade');
            
            // Nome da Magia/Jutsu (ex: "Kage Bunshin")
            $table->string('name', 255);
            
            // Define a chave primária composta
            $table->primary(['player_id', 'name']);
            
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('player_spells');
    }
};