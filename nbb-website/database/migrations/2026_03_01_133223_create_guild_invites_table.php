<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('guild_invites', function (Blueprint $table) {
            // Cria os campos exatamente como na imagem:
            $table->integer('player_id'); // player_id
            $table->integer('guild_id');   // guild_id

            // Define a chave primária composta (player_id + guild_id)
            $table->primary(['player_id', 'guild_id']);

            // Timestamps para rastrear quando o convite foi criado
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('guild_invites');
    }
};