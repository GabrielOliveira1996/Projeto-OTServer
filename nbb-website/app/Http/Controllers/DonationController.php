<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use App\Models\Account;
use Illuminate\Support\Facades\Auth;

class DonationController extends Controller
{
    // Exibe a página de pacotes (aquela que criamos com Gennin/Jounin Pack)
    public function index()
    {
        return view('donate.index');
    }

    // Processa o clique no botão de doar
    public function checkout(Request $request)
    {
        $user = Auth::user();
        
        // Define os pacotes (valores em centavos para gateways de pagamento)
        $packages = [
            1 => ['amount' => 1500, 'points' => 100, 'name' => 'Gennin Pack'],
            2 => ['amount' => 3000, 'points' => 250, 'name' => 'Chunin Pack'],
            3 => ['amount' => 6000, 'points' => 500, 'name' => 'Jounin Pack'],
        ];

        $packageId = $request->package_id;
        if (!isset($packages[$packageId])) {
            return back()->withErrors('Pacote inválido.');
        }

        $selected = $packages[$packageId];

        // Aqui você faria a chamada para a API do AbacatePay
        // Exemplo genérico de criação de cobrança:
        $response = Http::withToken(env('ABACATEPAY_KEY'))
            ->post('https://api.abacatepay.com/v1/billing/create', [
                'amount' => $selected['amount'],
                'methods' => ['pix'],
                'customer' => [
                    'name' => $user->name,
                    'email' => $user->email ?? 'contato@nbbot.com',
                ],
                // Metadata é vital para saber quem deu o dinheiro no Webhook
                'metadata' => [
                    'account_id' => $user->id,
                    'points' => $selected['points']
                ],
                'return_url' => route('donate.index'),
                'completion_url' => route('dashboard'),
            ]);

        if ($response->successful()) {
            return redirect($response->json('data.url')); // Redireciona para o PIX
        }

        return back()->withErrors('Erro ao gerar pagamento. Tente novamente.');
    }

    public function webhook(Request $request)
    {
        // 1. Validar o Token de Segurança do Webhook (Importante!)
        if ($request->header('x-abacatepay-signature') !== env('ABACATEPAY_WEBHOOK_SECRET')) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        $data = $request->json()->all();

        // 2. Se o status for "paid" (pago)
        if ($data['status'] === 'paid') {
            $accountId = $data['metadata']['account_id'];
            $points = $data['metadata']['points'];

            // 3. Adiciona os pontos diretamente na conta do jogador
            $account = Account::find($accountId);
            if ($account) {
                $account->increment('premium_points', $points); // Supondo que a coluna seja 'premium_points'
                return response()->json(['success' => true]);
            }
        }

        return response()->json(['status' => 'ignored']);
    }
}