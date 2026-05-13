<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('account_viplist', function (Blueprint $table) {
            // No seu print, os campos são account_id, world_id e player_id
            // Geralmente não há uma chave primária 'id' incremental nesta tabela em OTs
            $table->foreignId('account_id')->constrained('accounts')->onDelete('cascade');
            $table->integer('world_id')->default(0);
            $table->integer('player_id'); // ID do jogador que foi adicionado como VIP
            
            // Adiciona um índice composto para evitar duplicatas e acelerar buscas
            $table->primary(['account_id', 'player_id']);
            
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('account_viplist');
    }
};