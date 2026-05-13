<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('tile_items', function (Blueprint $table) {
            // Referência ao piso (tile) específico no mapa
            $table->unsignedBigInteger('tile_id');
            $table->integer('world_id')->default(0);
            
            // Sequência (sid) e posição (pid) para itens empilhados
            $table->integer('sid');
            $table->integer('pid')->default(0);
            
            // ID do item e quantidade
            $table->integer('itemtype');
            $table->integer('count')->default(1);
            
            // Atributos especiais (usamos binary para o BLOB da imagem)
            $table->binary('attributes')->nullable();
            
            $table->timestamps();
            
            // Index para otimizar o carregamento do mapa por tile
            $table->index(['tile_id', 'world_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('tile_items');
    }
};