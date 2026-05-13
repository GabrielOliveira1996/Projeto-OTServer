@extends('layouts.app')

@section('content')
    <div class="space-y-6">
        <h2 class="text-2xl font-bold text-white mb-4">Últimas Notícias</h2>
        
        <article class="bg-zinc-900 border border-zinc-800 rounded-lg overflow-hidden">
            <div class="bg-orange-600/10 px-4 py-2 border-b border-zinc-800 flex justify-between text-xs text-orange-400">
                <span>POSTADO POR: ADMIN</span>
                <span>28/02/2026</span>
            </div>
            <div class="p-6">
                <h3 class="text-xl font-bold mb-2">Bem-vindo ao Naruto Battle Begin!</h3>
                <p class="text-zinc-400 leading-relaxed">
                    Preparamos um servidor focado em equilíbrio e diversão. Explore o mapa, escolha sua vocação e torne-se um Kage!
                </p>
            </div>
        </article>
    </div>
@endsection