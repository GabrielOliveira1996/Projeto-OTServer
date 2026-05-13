<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('house_lists', function (Blueprint $table) {
            // Referência à Casa
            $table->unsignedBigInteger('house_id'); 
            $table->foreign('house_id')->references('id')->on('houses')->onDelete('cascade');
            
            $table->integer('world_id')->default(0); // world_id
            
            // ID da lista (Ex: 1 para convidados, 2 para sub-donos)
            $table->integer('listid'); 
            
            // O texto da lista (nomes dos jogadores permitidos)
            $table->text('list'); 
            
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('house_lists');
    }
};