<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('house_auctions', function (Blueprint $table) {
            // Referência à Casa
            $table->unsignedBigInteger('house_id'); 
            $table->foreign('house_id')->references('id')->on('houses')->onDelete('cascade');
            
            $table->integer('world_id')->default(0); // world_id
            
            // Referência ao jogador que deu o lance atual
            $table->unsignedBigInteger('player_id'); 
            $table->foreign('player_id')->references('id')->on('players')->onDelete('cascade');
            
            $table->integer('bid')->default(0); // Valor do lance atual
            $table->integer('limit')->default(0); // Limite máximo do lance
            $table->bigInteger('endtime'); // Quando o leilão termina (Timestamp)
            
            // Define a chave primária composta
            $table->primary(['house_id', 'world_id']);
            
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('house_auctions');
    }
};