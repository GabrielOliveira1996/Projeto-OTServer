<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('players', function (Blueprint $table) {
            $table->id();
            $table->string('name', 255)->unique();
            $table->integer('world_id')->default(0);
            $table->integer('group_id')->default(1);
            $table->foreignId('account_id')->constrained('accounts')->onDelete('cascade');
            
            // Status e Progressão
            $table->integer('level')->default(1);
            $table->integer('attribute_points')->default(0);
            $table->integer('vocation')->default(0);
            $table->bigInteger('experience')->default(0);
            $table->integer('maglevel')->default(0);
            $table->bigInteger('manaspent')->default(0);
            
            // Atributos Vitais
            $table->integer('health')->default(150);
            $table->integer('healthmax')->default(150);
            $table->integer('mana')->default(100);
            $table->integer('manamax')->default(100);
            
            // Visual (Look Settings)
            $table->integer('lookbody')->default(0);
            $table->integer('lookfeet')->default(0);
            $table->integer('lookhead')->default(0);
            $table->integer('looklegs')->default(0);
            $table->integer('looktype')->default(1);
            $table->integer('lookaddons')->default(0);
            
            // Posição e Mundo
            $table->integer('town_id')->default(1);
            $table->integer('posx')->default(0);
            $table->integer('posy')->default(0);
            $table->integer('posz')->default(0);
            
            // Mecânicas de Jogo
            $table->integer('cap')->default(400);
            $table->integer('soul')->default(100);
            $table->integer('sex')->default(1);
            $table->integer('stamina')->default(2520);
            $table->integer('direction')->default(2);
            $table->binary('conditions')->nullable(); // Blob para condições especiais
            
            // Sistemas de Guild e Rank
            $table->integer('rank_id')->default(0);
            $table->string('guildnick', 255)->default('');
            
            // Economia e PvP
            $table->bigInteger('balance')->default(0);
            $table->integer('skull')->default(0);
            $table->integer('skulltime')->default(0);
            $table->integer('blessings')->default(0);
            
            // Taxas de Perda (Loss)
            $table->integer('loss_experience')->default(100);
            $table->integer('loss_mana')->default(100);
            $table->integer('loss_skills')->default(100);
            $table->integer('loss_containers')->default(100);
            $table->integer('loss_items')->default(100);
            
            // Timestamps e Status de Login
            $table->bigInteger('lastlogin')->default(0);
            $table->bigInteger('lastlogout')->default(0);
            $table->string('lastip', 100)->default('0.0.0.0');
            $table->integer('online')->default(0);
            $table->integer('save')->default(1);
            
            // Outros Sistemas
            $table->bigInteger('premend')->default(0);
            $table->integer('marriage')->default(0);
            $table->integer('promotion')->default(0);
            $table->string('description', 255)->default('');
            
            // Campo de Deleção Lógica
            $table->integer('deleted')->default(0); // 0 = ativo, 1 = deletado [cite: 2026-02-22]

            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('players');
    }
};