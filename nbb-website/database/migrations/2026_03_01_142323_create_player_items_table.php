<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('player_items', function (Blueprint $table) {
            // Referência ao Dono do Item
            $table->unsignedBigInteger('player_id'); 
            $table->foreign('player_id')->references('id')->on('players')->onDelete('cascade');
            
            // Parent ID (Slot do corpo ou ID de um container)
            $table->integer('pid')->default(0); 
            
            // Sequence ID (Posição do item)
            $table->integer('sid')->default(0); 
            
            // ID do Item no servidor (itemtype)
            $table->integer('itemtype'); 
            
            // Quantidade ou cargas do item
            $table->integer('count')->default(1); 
            
            // Atributos especiais (Encantamentos, nomes customizados, etc)
            $table->binary('attributes'); 
            
            $table->timestamps();
            
            // Índice para busca rápida de inventário
            $table->index(['player_id', 'pid']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('player_items');
    }
};