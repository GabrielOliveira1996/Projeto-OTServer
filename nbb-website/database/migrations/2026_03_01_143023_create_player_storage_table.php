<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('player_storage', function (Blueprint $table) {
            // Relacionamento com o Jogador
            $table->unsignedBigInteger('player_id');
            $table->foreign('player_id')->references('id')->on('players')->onDelete('cascade');
            
            // A 'key' identifica qual quest ou sistema está salvando o dado
            $table->integer('key');
            
            // O 'value' é o valor armazenado (ex: 1 para concluído, -1 para resetado)
            $table->bigInteger('value')->default(0);
            
            // Chave primária composta para garantir que cada player tenha apenas uma entrada por chave
            $table->primary(['player_id', 'key']);
            
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('player_storage');
    }
};