<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('guilds', function (Blueprint $table) {
            $table->id(); // id
            $table->integer('world_id')->default(0); // world_id
            $table->string('name', 255)->unique(); // name
            
            // Referência ao Líder da Guilda
            $table->unsignedBigInteger('ownerid'); // ownerid
            $table->foreign('ownerid')->references('id')->on('players')->onDelete('cascade');
            
            $table->bigInteger('creationdata'); // creationdata (Timestamp)
            $table->text('motd')->nullable(); // motd (Message of the Day)
            
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('guilds');
    }
};