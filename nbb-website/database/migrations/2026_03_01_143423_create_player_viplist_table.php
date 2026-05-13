<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('player_viplist', function (Blueprint $table) {
            // O jogador que é dono da lista
            $table->unsignedBigInteger('player_id');
            $table->foreign('player_id')->references('id')->on('players')->onDelete('cascade');
            
            // O jogador que foi adicionado à lista (VIP)
            $table->unsignedBigInteger('vip_id');
            $table->foreign('vip_id')->references('id')->on('players')->onDelete('cascade');
            
            // Chave primária composta para evitar duplicatas na lista
            $table->primary(['player_id', 'vip_id']);
            
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('player_viplist');
    }
};