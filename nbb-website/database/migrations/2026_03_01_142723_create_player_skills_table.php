<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('player_skills', function (Blueprint $table) {
            // Referência ao Personagem
            $table->unsignedBigInteger('player_id');
            $table->foreign('player_id')->references('id')->on('players')->onDelete('cascade');
            
            // ID da Skill (0: Fist, 1: Club, 2: Sword, 3: Axe, 4: Distance, 5: Shield, 6: Fishing)
            $table->unsignedTinyInteger('skillid')->default(0);
            
            // Nível atual da skill
            $table->unsignedInteger('value')->default(10);
            
            // Progresso para o próximo nível (tries)
            $table->unsignedBigInteger('count')->default(0);
            
            // Chave primária composta para evitar duplicidade de skills no mesmo player
            $table->primary(['player_id', 'skillid']);
            
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('player_skills');
    }
};