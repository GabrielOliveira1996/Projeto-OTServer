<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Player;

class PlayerController extends Controller
{
    public function create() {
        // Lista de vocaÃ§Ãµes iniciais
        $vocations = [
            1 => 'Naruto',
            15 => 'Sasuke',
            24 => 'Sakura',
            33 => 'Kiba',
            //19 => 'Shino',
            //53 => 'Hinata',
        ];
        return view('players.create', compact('vocations'));
    }

    public function store(Request $request) 
    {
        $request->validate([
            'name' => 'required|unique:players,name|min:3|max:20|regex:/^[a-zA-Z\s]*$/',
            'vocation' => 'required|integer'
        ]);

        $vocationSettings = [
            1 => ['sex' => 1, 'looktype' => 352],  // Naruto
            15 => ['sex' => 1, 'looktype' => 358], // Sasuke
            24 => ['sex' => 0, 'looktype' => 387], // Sakura
            33 => ['sex' => 1, 'looktype' => 18],  // Kiba
        ];

        $setup = $vocationSettings[$request->vocation] ?? ['sex' => 1, 'looktype' => 1];

        try {
            \DB::transaction(function () use ($request, $setup) {
                
                // Criação do Player com todos os campos necessários para evitar erros de SQL
                \App\Models\Player::create([
                    'name'             => $request->name,
                    'vocation'         => $request->vocation,
                    'account_id'       => auth()->id(),
                    'sex'              => $setup['sex'],
                    'looktype'         => $setup['looktype'],
                    'level'            => 1,
                    'maglevel'         => 1,
                    'town_id'          => 1,
                    'world_id'         => 0,
                    'group_id'         => 1,
                    'experience'       => 0,
                    'health'           => 150,
                    'healthmax'        => 150,
                    'mana'             => 0,
                    'manamax'          => 0,
                    'stamina'          => 151200000,
                    'cap'              => 400,
                    'posx'             => 100, // Ajuste para o X do seu templo inicial
                    'posy'             => 100, // Ajuste para o Y do seu templo inicial
                    'posz'             => 7,   // Ajuste para o Z do seu templo inicial
                    'conditions'       => '', 
                    'lastlogin'        => 0,
                    'lastip'           => 0,
                    'save'             => 1,
                    'skull'            => 0,
                    'skulltime'        => 0,
                    'lastlogout'       => 0,
                    'blessings'        => 0,
                    'balance'          => 0,
                    'attribute_points' => 0,
                    'lookbody'         => 0,
                    'lookfeet'         => 0,
                    'lookhead'         => 0,
                    'looklegs'         => 0,
                    'lookaddons'       => 0,
                    'manaspent'        => 0,
                    'soul'             => 0,
                    'promotion'        => 0,
                    'online'           => 0,
                    'deleted'          => 0,
                    'description'      => '',
                    'loss_experience'  => 100,
                    'loss_mana'        => 100,
                    'loss_skills'      => 100,
                    'loss_containers'  => 100,
                    'loss_items'       => 100
                ]);

                /* PROCESSO DE SKILLS COMENTADO
                O banco de dados (Trigger) ou o servidor já deve criar as skills automaticamente.
                
                $skills = [];
                for ($i = 0; $i <= 6; $i++) {
                    $skills[] = [
                        'player_id' => $player->id,
                        'skillid'   => $i,
                        'value'     => 1,
                        'count'     => 0
                    ];
                }
                \DB::table('player_skills')->insert($skills);
                */
            });

            return redirect()->route('dashboard')->with('success', 'Ninja criado com sucesso!');
            
        } catch (\Exception $e) {
            // Se ainda der erro em alguma coluna de 'players', o log ou o dd vai te avisar
            \Log::error("Erro na criação de personagem: " . $e->getMessage());
            return redirect()->back()->withErrors(['error' => 'Erro ao criar: ' . $e->getMessage()]);
        }
    }

    public function destroy(\App\Models\Player $player)
    {
        if ($player->account_id !== auth()->id()) {
            return back()->withErrors(['error' => 'Acesso negado.']);
        }

        // Altera o status em vez de apagar a linha do banco
        $player->update(['deleted' => 1]);

        return redirect()->route('dashboard')->with('success', 'Personagem deletado com sucesso!');
    }
}