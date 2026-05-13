<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Naruto Battle Begin</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body class="bg-zinc-950 text-zinc-200">

    <nav class="bg-zinc-900 border-b border-orange-600 p-4 sticky top-0 z-50">
        <div class="max-w-7xl mx-auto flex justify-between items-center">
            <div class="flex items-center gap-4">
                <a href="{{ route('home') }}" class="text-2xl font-bold text-orange-500 tracking-tighter">NBB<span class="text-white">OT</span></a>
            </div>
            <div class="flex gap-6 font-medium">
                @auth
                    <span class="text-zinc-400">Olá, {{ auth()->user()->name }}</span>
                    <form action="{{ route('logout') }}" method="POST">@csrf <button class="hover:text-orange-500 text-xs uppercase font-bold">Logout</button></form>
                @else
                    <a href="{{ route('login') }}" class="hover:text-orange-500">LOGIN</a>
                    <a href="{{ route('register') }}" class="hover:text-orange-500">REGISTER</a>
                @endauth
            </div>
        </div>
    </nav>

    <div class="max-w-7xl mx-auto grid grid-cols-12 gap-6 mt-8 px-4">
        
        <aside class="col-span-12 md:col-span-3">
            <div class="bg-zinc-900 rounded-lg p-4 border border-zinc-800 shadow-xl">
                <h3 class="text-orange-500 font-bold border-b border-zinc-800 mb-4 pb-2 uppercase text-xs tracking-widest">Menu Principal</h3>
                <ul class="flex flex-col gap-3 text-sm">
                    <li><a href="#" class="hover:text-orange-400 transition">HIGHSCORES</a></li>
                    <li><a href="#" class="hover:text-orange-400 transition">VOCAÇÕES</a></li>
                    <li><a href="#" class="hover:text-orange-400 transition">MAPA MUNDI</a></li>
                    <li><a href="#" class="hover:text-orange-400 transition">DOWNLOAD CLIENT</a></li>
                </ul>
            </div>
        </aside>

        <main class="col-span-12 md:col-span-6">
            @yield('content')
        </main>

        <aside class="col-span-12 md:col-span-3">
            <div class="bg-zinc-900 rounded-lg p-5 border border-orange-600/30 shadow-2xl relative overflow-hidden group">
                <div class="absolute -top-10 -right-10 w-32 h-32 bg-orange-600/10 rounded-full blur-3xl group-hover:bg-orange-600/20 transition"></div>
                
                <h3 class="text-orange-500 font-bold border-b border-zinc-800 mb-4 pb-2 uppercase text-xs tracking-widest relative z-10">Doações</h3>
                
                <div class="relative z-10 text-center">
                    <p class="text-zinc-400 text-xs mb-4">Ajude o NBBOT a crescer e receba bônus exclusivos!</p>
                    
                    <div class="space-y-2 mb-6">
                        <div class="bg-zinc-950/50 p-2 rounded border border-zinc-800 text-xs flex justify-between">
                            <span>100 Pontos</span>
                            <span class="text-orange-500 font-bold text-xs uppercase font-bold">R$ 15,00</span>
                        </div>
                        <div class="bg-zinc-950/50 p-2 rounded border border-zinc-800 text-xs flex justify-between">
                            <span>250 Pontos</span>
                            <span class="text-orange-500 font-bold text-xs uppercase font-bold">R$ 30,00</span>
                        </div>
                        <div class="bg-zinc-950/50 p-2 rounded border border-zinc-800 text-xs flex justify-between">
                            <span>500 Pontos</span>
                            <span class="text-orange-500 font-bold text-xs uppercase font-bold">R$ 50,00</span>
                        </div>
                    </div>

                    @auth
                        <a href="{{ route('donate.index') }}" class="block w-full bg-orange-600 hover:bg-orange-700 text-white text-xs font-black py-3 rounded shadow-lg transition text-center">
                            QUERO DOAR AGORA
                        </a>
                    @else
                        <a href="{{ route('login') }}" class="block w-full bg-zinc-800 hover:bg-zinc-700 text-zinc-400 text-xs font-bold py-3 rounded border border-zinc-700 transition text-center">
                            FAÇA LOGIN PARA DOAR
                        </a>
                    @endauth
                </div>
            </div>
        </aside>

    </div>

</body>
</html>