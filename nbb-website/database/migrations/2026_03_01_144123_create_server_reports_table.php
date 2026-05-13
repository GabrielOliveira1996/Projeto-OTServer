<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('server_reports', function (Blueprint $table) {
            $table->id(); // id
            $table->integer('world_id')->default(0); // world_id
            
            // Relacionamento com o Jogador que reportou
            $table->unsignedBigInteger('player_id'); // player_id
            $table->foreign('player_id')->references('id')->on('players')->onDelete('cascade');
            
            // Coordenadas do mapa (Position)
            $table->integer('posx'); 
            $table->integer('posy');
            $table->integer('posz');
            
            $table->bigInteger('timestamp'); // Data do report
            $table->text('report'); // Conteúdo da denúncia
            $table->integer('reads')->default(0); // Status (0: Novo, 1: Lido)
            
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('server_reports');
    }
};