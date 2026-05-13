<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('player_depotitems', function (Blueprint $table) {
            $table->id(); // ID único para cada item no banco
            
            // Referência ao dono do item
            $table->unsignedBigInteger('player_id'); 
            $table->foreign('player_id')->references('id')->on('players')->onDelete('cascade');
            
            $table->integer('sid'); // sid (Sequence ID dentro do depot)
            $table->integer('pid'); // pid (Parent ID - ID do container pai)
            $table->integer('itemtype'); // itemtype (ID do item no servidor)
            $table->integer('count'); // count (Quantidade ou cargas)
            $table->binary('attributes'); // attributes (Dados extras via Blob)
            
            $table->timestamps();
            
            // Índice para acelerar a busca de itens por jogador
            $table->index(['player_id', 'sid']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('player_depotitems');
    }
};