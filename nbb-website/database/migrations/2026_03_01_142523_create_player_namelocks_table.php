<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('player_namelocks', function (Blueprint $table) {
            // Referência ao Personagem
            $table->unsignedBigInteger('player_id');
            $table->foreign('player_id')->references('id')->on('players')->onDelete('cascade');
            
            $table->string('name', 255); // Nome antigo (ou atual bloqueado)
            $table->string('new_name', 255); // Novo nome escolhido
            $table->bigInteger('date'); // Data da aplicação do lock (Timestamp)
            
            $table->timestamps();
            
            // Define player_id como chave primária para evitar múltiplos locks ativos simultâneos
            $table->primary('player_id');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('player_namelocks');
    }
};