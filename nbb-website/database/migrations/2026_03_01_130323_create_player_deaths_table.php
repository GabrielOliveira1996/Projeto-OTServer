<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('player_deaths', function (Blueprint $table) {
            $table->id(); // Campo 'id'
            $table->unsignedBigInteger('player_id'); //
            $table->bigInteger('date'); // Timestamp da morte
            $table->integer('level'); // Nível em que morreu
            
            $table->foreign('player_id')->references('id')->on('players')->onDelete('cascade');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('player_deaths');
    }
};