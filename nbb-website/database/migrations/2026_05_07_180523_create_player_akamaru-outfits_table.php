<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('player_akamaru_outfits', function (Blueprint $table) {
            $table->unsignedBigInteger('player_id');
            $table->integer('outfit_id');
            $table->primary(['player_id', 'outfit_id']);
            $table->foreign('player_id')->references('id')->on('players')->onDelete('cascade');
        });
    }

    public function down()
    {
        Schema::dropIfExists('player_akamaru_outfits');
    }
};