<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('player_akamarus', function (Blueprint $table) {
            // ReferÃªncia ao Dono
            $table->unsignedBigInteger('player_id')->primary(); 
            $table->foreign('player_id')->references('id')->on('players')->onDelete('cascade');
            
            // Atributos do Akamaru
            $table->integer('level')->default(1); // level
            $table->bigInteger('exp')->default(0); // exp
            $table->integer('points')->default(0); // points (para distribuir)
            $table->integer('attack')->default(0); // attack
            $table->integer('agility')->default(0); // agility
            $table->integer('dodge')->default(0); // dodge
            $table->integer('health_pts')->default(0); // health_pts
            $table->integer('speed_pts')->default(0); // speed_pts
            $table->integer('current_hp')->default(100); // HP atual para persistência
            $table->boolean('is_dead')->default(false);  // Status de vida
            $table->unsignedInteger('death_timestamp')->default(0); // Momento da morte
            $table->integer('current_outfit')->default(45);
            
            $table->timestamps();   
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('player_akamarus');
    }
};