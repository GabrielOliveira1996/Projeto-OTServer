@extends('layouts.app')

@section('content')
<div class="space-y-6">
    @if(session('success'))
        <div class="bg-green-600/20 border border-green-600 text-green-500 p-3 rounded text-sm font-bold">
            {{ session('success') }}
        </div>
    @endif

    <div class="bg-zinc-900 border border-zinc-800 rounded-lg p-6">
        <h2 class="text-2xl font-bold text-orange-500 mb-4">Painel da Conta</h2>
        <div class="grid grid-cols-2 gap-4 text-sm">
            <p><span class="text-zinc-500 uppercase font-bold">Conta:</span> {{ auth()->user()->name }}</p>
            <p><span class="text-zinc-500 uppercase font-bold">E-mail:</span> {{ auth()->user()->email }}</p>
            <p><span class="text-zinc-500 uppercase font-bold">Premium Days:</span> {{ auth()->user()->premdays }}</p>
        </div>
    </div>

    <div class="bg-zinc-900 border border-zinc-800 rounded-lg p-6">
        <div class="flex justify-between items-center mb-4">
            <h3 class="text-xl font-bold text-white">Meus Personagens</h3>
            <a href="{{ route('player.create') }}" class="bg-green-600 hover:bg-green-700 text-white text-xs px-4 py-2 rounded font-bold transition">CRIAR PERSONAGEM</a>
        </div>

        <table class="w-full text-left">
            <thead class="bg-zinc-800 text-zinc-400 text-xs uppercase">
                <tr>
                    <th class="p-3">Nome</th>
                    <th class="p-3">Level</th>
                    <th class="p-3">Vocação</th>
                    <th class="p-3 text-right">Ações</th>
                </tr>
            </thead>
            <tbody class="divide-y divide-zinc-800">
                @foreach(auth()->user()->players as $player)
                <tr class="hover:bg-zinc-800/50 transition">
                    <td class="p-3">
                        <span class="text-white font-medium">{{ $player->name }}</span>
                    </td>
                    <td class="p-3 text-orange-400 font-bold">{{ $player->level }}</td>
                    <td class="p-3 text-zinc-400">{{ $player->vocation_name }}</td>
                    <td class="p-3 text-right">
                        <form action="{{ route('player.destroy', $player->id) }}" method="POST" id="delete-form-{{ $player->id }}">
                            @csrf
                            @method('DELETE')
                            <button type="button" 
                                    onclick="confirmDelete('{{ $player->id }}', '{{ $player->name }}')"
                                    class="text-red-500 hover:text-red-400 text-xs font-bold uppercase tracking-widest transition">
                                [ Deletar ]
                            </button>
                        </form>
                    </td>
                </tr>
                @endforeach
            </tbody>
        </table>
        
        @if(auth()->user()->players->isEmpty())
            <div class="text-center py-8 text-zinc-500 italic text-sm">
                Nenhum personagem ativo encontrado.
            </div>
        @endif
    </div>
</div>

<script>
function confirmDelete(playerId, playerName) {
    Swal.fire({
        title: 'Tem certeza?',
        text: "O personagem " + playerName + " será desativado!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#16a34a', // green-600
        cancelButtonColor: '#dc2626',  // red-600
        confirmButtonText: 'Sim, deletar!',
        cancelButtonText: 'Cancelar',
        background: '#18181b', // zinc-900
        color: '#fff',
        customClass: {
            popup: 'border border-zinc-800'
        }
    }).then((result) => {
        if (result.isConfirmed) {
            document.getElementById('delete-form-' + playerId).submit();
        }
    })
}

// Exibir mensagem de sucesso se houver
@if(session('success'))
    Swal.fire({
        icon: 'success',
        title: 'Sucesso!',
        text: "{{ session('success') }}",
        background: '#18181b',
        color: '#fff',
        confirmButtonColor: '#16a34a',
    });
@endif
</script>
@endsection