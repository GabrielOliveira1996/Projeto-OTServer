<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('killers', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('death_id');
            $table->boolean('final_hit')->default(false); // Se deu o golpe final
            $table->boolean('unjustified')->default(false); // Se gerou frag/skull
            
            $table->foreign('death_id')->references('id')->on('player_deaths')->onDelete('cascade');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('killers');
    }
};