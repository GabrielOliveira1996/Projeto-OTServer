<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('guild_ranks', function (Blueprint $table) {
            $table->id(); // id
            
            // Referência à Guilda
            $table->unsignedBigInteger('guild_id'); // guild_id
            $table->foreign('guild_id')->references('id')->on('guilds')->onDelete('cascade');
            
            $table->string('name', 255); // name (Ex: Leader, Vice-Leader)
            $table->integer('level'); // level (Nível de autoridade do cargo)
            
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('guild_ranks');
    }
};