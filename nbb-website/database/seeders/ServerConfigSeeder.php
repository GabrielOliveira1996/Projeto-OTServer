<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ServerConfigSeeder extends Seeder
{
    public function run(): void
    {
        // Dados essenciais para o executável do OT reconhecer o banco
        DB::table('server_config')->insertOrIgnore([
            ['config' => 'db_version', 'value' => '23'], // Versão esperada pelo seu OT
            ['config' => 'encryption', 'value' => '2'],  // Tipo de criptografia (SHA1)
        ]);
    }
}