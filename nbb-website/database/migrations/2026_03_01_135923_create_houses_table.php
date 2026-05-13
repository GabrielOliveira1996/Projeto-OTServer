<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('houses', function (Blueprint $table) {
            $table->id(); // id
            $table->integer('world_id')->default(0); // world_id
            
            // Referência ao dono (ID do Player)
            $table->integer('owner')->default(0); // owner
            
            $table->integer('paid')->default(0); // paid
            $table->integer('warnings')->default(0); // warnings
            $table->integer('lastwarning')->default(0); // lastwarning
            $table->string('name', 255); // name (Ex: Konoha 1)
            $table->integer('town')->default(1); // town
            $table->integer('size')->default(0); // size
            $table->integer('price')->default(0); // price
            $table->integer('rent')->default(0); // rent
            $table->integer('doors')->default(0); // doors
            $table->integer('beds')->default(0); // beds
            $table->integer('tiles')->default(0); // tiles
            $table->integer('guild')->default(0); // guild (Indica se é uma Guild House)
            $table->integer('clear')->default(0); // clear
            
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('houses');
    }
};