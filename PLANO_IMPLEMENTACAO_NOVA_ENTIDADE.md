# Plano Detalhado: Implementação de Nova Entidade no OTServer

## Análise da Base de Código

O servidor OT (Open Tibia) utiliza uma arquitetura bem estruturada com herança de classes para gerenciar entidades. A hierarquia atual é:

```
Thing (abstrata)
  └── Creature (abstrata)
      ├── Player (jogadores)
      ├── Monster (monstros)
      └── Npc (NPCs)
```

Cada entidade possui um **intervalo de ID único** definido pela função `rangeId()`:
- **Player**: `0x10000000` (ID base para jogadores)
- **Monster**: `0x40000000` (ID base para monstros)
- **Npc**: `0x80000000` (ID base para NPCs)

---

## Passo a Passo Completo para Adicionar Nova Entidade

### FASE 1: ESTRUTURA BÁSICA DAS CLASSES

#### Passo 1.1: Criar Arquivo Header da Nova Entidade
**Arquivo**: `newentity.h`

Deve conter:
- Definição da classe que herda de `Creature`
- Enumeração para o tipo de entidade (com prefix único)
- Estrutura de dados específica (se aplicável)
- Métodos virtuais obrigatórios da classe pai
- Métodos específicos da entidade

**Estrutura mínima obrigatória:**

```cpp
#ifndef __NEWENTITY__
#define __NEWENTITY__

#include "creature.h"

// Definir intervalo de ID único (usar range não utilizado)
// Exemplo: 0xC0000000 (ou outro range disponível)

class NewEntity : public Creature
{
public:
    NewEntity(const std::string& name);
    virtual ~NewEntity();

    // Métodos virtuais obrigatórios de Creature
    virtual NewEntity* getNewEntity() { return this; }
    virtual const NewEntity* getNewEntity() const { return this; }
    
    virtual uint32_t rangeId() { return 0xC0000000; } // ID range único
    
    virtual void addList() { autoList[id] = this; }
    virtual void removeList() { autoList.erase(id); }
    
    // AutoList para gerenciamento de entidades
    static AutoList<NewEntity> autoList;
    
    // Métodos de criação
    static NewEntity* createNewEntity(const std::string& name);
    
    // Métodos específicos necessários
    virtual void onThink(uint32_t interval);
    virtual bool getNextStep(Direction& dir, uint32_t& flags);
    virtual void onCreatureAppear(const Creature* creature);
    virtual void onCreatureDisappear(const Creature* creature, bool isLogout);
    virtual void drainHealth(Creature* attacker, CombatType_t combatType, int32_t damage);
    virtual void changeHealth(int32_t healthChange);

private:
    // Dados privados específicos da entidade
};

#endif // __NEWENTITY__
```

#### Passo 1.2: Criar Arquivo Implementation da Nova Entidade
**Arquivo**: `newentity.cpp`

Deve conter:
- Inicialização da `AutoList<NewEntity>`
- Implementação do construtor
- Implementação do destrutor
- Implementação de todos os métodos virtuais

**Estrutura essencial:**

```cpp
#include "otpch.h"
#include "newentity.h"
#include "creature.h"
#include "game.h"

extern Game g_game;

AutoList<NewEntity> NewEntity::autoList;

NewEntity::NewEntity(const std::string& name) : Creature()
{
    this->name = name;
    this->nameDescription = name;
    
    // Inicializar atributos específicos
    health = 100;
    healthMax = 100;
    baseSpeed = 220;
    
    // Adicionar à lista de entidades
    addList();
}

NewEntity::~NewEntity()
{
    removeList();
}

NewEntity* NewEntity::createNewEntity(const std::string& name)
{
    return new NewEntity(name);
}

void NewEntity::onThink(uint32_t interval)
{
    Creature::onThink(interval);
    // Lógica de comportamento específico
}

bool NewEntity::getNextStep(Direction& dir, uint32_t& flags)
{
    // Implementar lógica de movimento
    return false;
}

// ... implementar outros métodos virtuais
```

---

### FASE 2: INTEGRAÇÃO COM O SISTEMA CENTRAL

#### Passo 2.1: Registrar a Nova Entidade no Game
**Arquivo a Modificar**: `game.h`

Adicionar:
```cpp
#include "newentity.h"

class Game
{
    // ... código existente ...
    
    // Adicionar métodos para gerenciar nova entidade
    uint32_t getNewEntitiesOnline() { return (uint32_t)NewEntity::autoList.size(); }
};
```

#### Passo 2.2: Registrar no Game Implementation
**Arquivo a Modificar**: `game.cpp`

Adicionar em `Game::getStatus()` ou função similar:
```cpp
newEntitiesOnline = getNewEntitiesOnline();
```

#### Passo 2.3: Atualizar creature.h com Métodos Acessores
**Arquivo a Modificar**: `creature.h` (seção de métodos virtuais)

Adicionar:
```cpp
virtual NewEntity* getNewEntity() { return NULL; }
virtual const NewEntity* getNewEntity() const { return NULL; }
```

Isso permite que qualquer Creature possa ser testado para ver se é uma NewEntity:
```cpp
NewEntity* entity = creature->getNewEntity();
if(entity) {
    // É uma nova entidade
}
```

---

### FASE 3: INTEGRAÇÃO COM O PROTOCOLO DE REDE

#### Passo 3.1: Adicionar Suporte no ProtocolGame
**Arquivo a Modificar**: `protocolgame.cpp`

Na função `AddCreature()`, adicionar caso para nova entidade:

```cpp
void ProtocolGame::AddCreature(NetworkMessage_ptr msg, const Creature* creature, 
                                bool known, uint32_t remove)
{
    const Player* player = creature->getPlayer();
    const Monster* monster = creature->getMonster();
    const Npc* npc = creature->getNpc();
    const NewEntity* newentity = creature->getNewEntity(); // ADICIONAR ESTA LINHA
    
    // ... código existente ...
    
    if(player)
    {
        // Enviar dados específicos do Player
        msg->AddU16(player->getPlayerInfo(PLAYERINFO_MAXHEALTH));
        // ...
    }
    else if(monster)
    {
        // Enviar dados específicos do Monster
        msg->AddU16(monster->getHealth());
        // ...
    }
    else if(npc)
    {
        // Enviar dados específicos do NPC
        msg->AddU16(0); // NPCs geralmente enviam 0
    }
    else if(newentity) // ADICIONAR ESTE BLOCO
    {
        // Enviar dados específicos da nova entidade
        msg->AddU16(newentity->getHealth());
        // ... adicionar outros dados necessários
    }
}
```

#### Passo 3.2: Adicionar ao Header do Protocolo
**Arquivo a Modificar**: `protocolgame.h`

Adicionar forward declaration:
```cpp
class NewEntity;
```

---

### FASE 4: SISTEMA DE CONFIGURAÇÃO E CARREGAMENTO

#### Passo 4.1: Criar Sistema de Configuração (Opcional)
Se a entidade precisar de configurações em arquivo XML, criar:
**Arquivo**: `newentities.h` e `newentities.cpp`

Estrutura similar a `monsters.h/cpp` ou `npc.h/cpp`:

```cpp
#ifndef __NEWENTITIES__
#define __NEWENTITIES__

typedef std::map<std::string, NewEntityType*> NewEntityTypeMap;

class NewEntities
{
public:
    NewEntities();
    ~NewEntities();
    
    void reload();
    NewEntityType* getNewEntityType(const std::string& name);
    
private:
    NewEntityTypeMap newEntityTypes;
    bool loadFromXml();
};

extern NewEntities g_newEntities;

#endif
```

#### Passo 4.2: Arquivo de Configuração XML
**Arquivo**: `data/newentities/newentities.xml`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<newentities>
    <newentity name="example_entity">
        <health max="100" />
        <speed base="220" />
        <outfit type="1" head="0" body="0" legs="0" feet="0" />
    </newentity>
</newentities>
```

---

### FASE 5: EVENTOS E COMPORTAMENTO

#### Passo 5.1: Implementar Handlers de Eventos
**Arquivo a Modificar**: `newentity.cpp`

Implementar métodos de evento:

```cpp
void NewEntity::onCreatureAppear(const Creature* creature)
{
    Creature::onCreatureAppear(creature);
    if(creature == this)
    {
        // Entidade apareceu no mapa
        updateIdleStatus();
    }
}

void NewEntity::onCreatureDisappear(const Creature* creature, bool isLogout)
{
    Creature::onCreatureDisappear(creature, isLogout);
    if(creature == this)
    {
        // Entidade desapareceu do mapa
        setIdle(true);
    }
}

void NewEntity::drainHealth(Creature* attacker, CombatType_t combatType, int32_t damage)
{
    changeHealth(-damage);
    // Implementar resposta ao dano (fuga, contraataque, etc)
}

void NewEntity::changeHealth(int32_t healthChange)
{
    health += healthChange;
    if(health > healthMax)
        health = healthMax;
    else if(health <= 0)
        health = 0;
        // Disparar evento de morte
}
```

---

### FASE 6: SISTEMA DE SCRIPTS LUA (OPCIONAL)

#### Passo 6.1: Criar Interface Lua para Nova Entidade
**Arquivo**: `luascript.cpp` - Adicionar funções Lua

```cpp
static int32_t luaGetNewEntityHealth(lua_State* L)
{
    NewEntity* entity = getNewEntity(L, 1);
    if(!entity)
    {
        lua_pushnil(L);
        return 1;
    }
    
    lua_pushnumber(L, entity->getHealth());
    return 1;
}

static int32_t luaSetNewEntityHealth(lua_State* L)
{
    NewEntity* entity = getNewEntity(L, 1);
    if(!entity)
        return 0;
    
    int32_t health = luaL_checknumber(L, 2);
    entity->setHealth(health);
    return 0;
}
```

Registrar no `registerFunctions()`:
```cpp
lua_register(m_luaState, "getNewEntityHealth", luaGetNewEntityHealth);
lua_register(m_luaState, "setNewEntityHealth", luaSetNewEntityHealth);
```

---

### FASE 7: COMPILAÇÃO E INTEGRAÇÃO

#### Passo 7.1: Atualizar Sistema de Build
**Arquivo a Modificar**: `Makefile.am`

Adicionar a lista de fontes:
```makefile
SOURCES = \
    # ... arquivos existentes ...
    newentity.cpp \
    newentities.cpp \
    # ... resto dos arquivos ...
```

#### Passo 7.2: Atualizar arquivo principal de includes
**Arquivo a Modificar**: `otpch.h`

Adicionar:
```cpp
#include "newentity.h"
#include "newentities.h"
```

#### Passo 7.3: Compilar e Testar
```bash
./autogen.sh
./configure
make clean
make
```

---

## LISTA DE ARQUIVOS A MODIFICAR/CRIAR

### Criar (Novos):
1. `newentity.h` - Header da classe
2. `newentity.cpp` - Implementação
3. `newentities.h` - Gerenciador (se configuração XML necessária)
4. `newentities.cpp` - Implementação do gerenciador
5. `data/newentities/newentities.xml` - Arquivo de configuração

### Modificar (Existentes):
1. `creature.h` - Adicionar métodos acessores virtuais
2. `game.h` - Incluir header e adicionar métodos de gerenciamento
3. `game.cpp` - Implementar métodos de contagem
4. `protocolgame.h` - Forward declaration
5. `protocolgame.cpp` - Adicionar suporte ao envio de dados
6. `otpch.h` - Incluir novos headers
7. `Makefile.am` - Adicionar novos arquivos ao build
8. `luascript.cpp` - Funções Lua (opcional)

---

## DIAGRAMA DE FLUXO

```
Criação da Entidade:
├─ NewEntity::createNewEntity(name)
├─ Construtor NewEntity(name)
├─ addList() → AutoList<NewEntity>
├─ setID() → ID único com range 0xC0000000
└─ placeCreature() → Adiciona ao mapa

Quando entra no mapa:
├─ Game::placeCreature()
├─ onCreatureAppear() é chamado
├─ ProtocolGame::sendAddCreature()
└─ Clients recebem via AddCreature()

Ataque/Dano:
├─ Creature::drainHealth() → NewEntity::drainHealth()
├─ changeHealth()
├─ Atualizar clients via sendCreatureHealth()
└─ Se health <= 0, disparar evento de morte

Saída do mapa:
├─ Game::removeCreature()
├─ onCreatureDisappear() é chamado
├─ sendRemoveCreature() aos clients
└─ removeList() → Remove da AutoList
```

---

## CHECKLIST DE IMPLEMENTAÇÃO

- [ ] Criar `newentity.h` com classe herdando de Creature
- [ ] Criar `newentity.cpp` com implementações
- [ ] Adicionar métodos virtuais em `creature.h`
- [ ] Modificar `game.h` e `game.cpp`
- [ ] Adicionar suporte em `protocolgame.cpp`
- [ ] Criar sistema de configuração (XML)
- [ ] Implementar handlers de eventos
- [ ] Testar criação e posicionamento
- [ ] Testar movimentação e combate
- [ ] Testar remoção e limpeza de memória
- [ ] Adicionar funções Lua (se necessário)
- [ ] Atualizar documentação interna

---

## PONTOS IMPORTANTES

### ID Management
```cpp
/*
 * 0x10000000 - Player
 * 0x40000000 - Monster
 * 0x80000000 - NPC
 * 0xC0000000 - NewEntity (sugestão)
 */
```

### AutoList
Cada tipo de criatura mantém sua própria AutoList para gerenciamento rápido:
```cpp
AutoList<NewEntity> NewEntity::autoList;
// Permite iteração eficiente: for(auto it : NewEntity::autoList)
```

### Métodos Virtuais Obrigatórios
1. `getNewEntity()` - Retorna this ou NULL
2. `rangeId()` - Retorna 0xC0000000
3. `addList()` / `removeList()` - Gerenciam AutoList
4. `onThink()` - Lógica de update periódico
5. `getNextStep()` - Movimento
6. `onCreatureAppear()` / `onCreatureDisappear()`
7. `drainHealth()` / `changeHealth()` - Sistema de vida

### Serialização de Dados
O protocolo espera que cada tipo de criatura envie dados específicos em AddCreature():
- Players: health, mana, level, mana, soul, etc.
- Monsters: health
- NPCs: 0 (NPCs não mostram health bar)
- NewEntity: Definir conforme necessário

---

## EXEMPLO PRÁTICO: MINION

Se implementar uma entidade "Minion" (servo/ajudante):

```cpp
// minion.h
class Minion : public Creature
{
public:
    virtual uint32_t rangeId() { return 0x20000000; } // Range diferente
    virtual const Minion* getMinion() const { return this; }
    
    void setMaster(Creature* master);
    Creature* getMaster() const { return master; }
    
private:
    Creature* master;
};
```

Isso permitiria:
- Servidores controlar minions
- Minions seguem seu mestre
- Minions herdam habilidades do mestre
- Sistema de invocação dinâmica
