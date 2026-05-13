@extends('layouts.app')

@section('content')
<div class="max-w-6xl mx-auto px-4 py-8">
    <div class="text-center mb-12">
        <h2 class="text-4xl font-extrabold text-orange-500 mb-2">DOAÇÕES</h2>
        <p class="text-zinc-400">Fortaleça o servidor e receba pontos em troca.</p>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
        
        <div class="bg-zinc-900 border border-zinc-800 rounded-xl p-6 flex flex-col items-center hover:border-orange-500/50 transition shadow-lg">
            <h3 class="text-zinc-500 uppercase text-xs font-bold tracking-widest mb-4">Gennin Pack</h3>
            <div class="text-5xl font-black text-white mb-2">100</div>
            <div class="text-orange-500 font-bold mb-6">PONTOS</div>
            <div class="text-2xl font-bold text-zinc-300 mb-8 text-center">R$ 15,00</div>
            <a href="#" class="w-full bg-zinc-800 hover:bg-orange-600 text-white font-bold py-3 rounded-lg text-center transition">
                DOAR AGORA
            </a>
        </div>

        <div class="bg-zinc-900 border-2 border-orange-600 rounded-xl p-6 flex flex-col items-center transform scale-105 shadow-[0_0_20px_rgba(234,88,12,0.2)] relative">
            <span class="absolute -top-4 bg-orange-600 text-white text-[10px] font-bold px-3 py-1 rounded-full uppercase">Mais Popular</span>
            <h3 class="text-zinc-500 uppercase text-xs font-bold tracking-widest mb-4">Chunin Pack</h3>
            <div class="text-5xl font-black text-white mb-2">250</div>
            <div class="text-orange-500 font-bold mb-6">PONTOS</div>
            <div class="text-2xl font-bold text-zinc-300 mb-8 text-center">R$ 30,00</div>
            <a href="#" class="w-full bg-orange-600 hover:bg-orange-700 text-white font-bold py-3 rounded-lg text-center transition">
                DOAR AGORA
            </a>
        </div>

        <div class="bg-zinc-900 border border-zinc-800 rounded-xl p-6 flex flex-col items-center hover:border-orange-500/50 transition shadow-lg">
            <h3 class="text-zinc-500 uppercase text-xs font-bold tracking-widest mb-4">Jounin Pack</h3>
            <div class="text-5xl font-black text-white mb-2">500</div>
            <div class="text-orange-500 font-bold mb-6">PONTOS</div>
            <div class="text-2xl font-bold text-zinc-300 mb-8 text-center">R$ 60,00</div>
            <a href="#" class="w-full bg-zinc-800 hover:bg-orange-600 text-white font-bold py-3 rounded-lg text-center transition">
                DOAR AGORA
            </a>
        </div>

    </div>

    <div class="mt-12 bg-zinc-900/50 border border-zinc-800 rounded-lg p-6 text-center">
        <p class="text-zinc-500 text-sm">
            Após a confirmação do pagamento, os pontos são creditados automaticamente na sua conta. <br>
            Criptografia ativa conforme as configurações do servidor.
        </p>
    </div>
</div>
@endsection