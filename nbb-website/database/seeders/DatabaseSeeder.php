<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $this->call([
            ServerConfigSeeder::class,
        ]);
        
        // Insere a mensagem de boas-vindas
        DB::table('server_motd')->insertOrIgnore([
            ['id' => 1, 'world_id' => 0, 'text' => 'Bem vindo ao NBBOT!']
        ]);

        // Inicializa a tabela de recorde para o executável não dar erro
        DB::table('server_record')->insertOrIgnore([
            ['record' => 0, 'world_id' => 0, 'timestamp' => 0]
        ]);
    }
}
