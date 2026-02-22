#include "otpch.h"
#include "sagamonster.h"
#include "player.h"
#include "game.h"

extern Game g_game;

SagaMonster::SagaMonster(MonsterType *_type) : Monster(_type)
{
	sagaId = 0;
	experienceGain = 0;
	isElite = false;

	std::string name = getName();

	if (name == "Mizuki")
		requiredStorage = 11112;
	else if (name == "Ebisu")
		requiredStorage = 11117;
	else if (name == "Zabuza")
		requiredStorage = 11120;
	else if (name == "Second Zabuza")
		requiredStorage = 11121;
	else if (name == "Haku")
		requiredStorage = 11122;
	else if (name == "Orochimaru")
		requiredStorage = 11000;
	else if (name == "Zaku")
		requiredStorage = 11127;
	else if (name == "Kin")
		requiredStorage = 11128;
	else if (name == "Dosu")
		requiredStorage = 11129;
	else if (name == "Rain Shinobi")
		requiredStorage = 11131;
	else if (name == "Kiba")
		requiredStorage = 11133;
	else if (name == "Neji")
		requiredStorage = 11136;
	else if (name == "Kankuro")
		requiredStorage = 11138;
	else if (name == "Temari")
		requiredStorage = 11139;
	else if (name == "Gaara")
		requiredStorage = 11140;
	else if (name == "Shukaku One")
		requiredStorage = 11141;
	else if (name == "Shukaku Two")
		requiredStorage = 11142;
	else if (name == "Kabuto")
		requiredStorage = 11146;
	else if (name == "Sasuke")
		requiredStorage = 11148;
	else if (name == "Jiroubou")
		requiredStorage = 11151;
	else if (name == "Jiroubou Cursed")
		requiredStorage = 11152;
	else if (name == "Kidomaru")
		requiredStorage = 11153;
	else if (name == "Kidomaru Cursed")
		requiredStorage = 11154;
	else if (name == "Sakon And Ukon")
		requiredStorage = 11155;
	else if (name == "Sakon And Ukon Cursed")
		requiredStorage = 11156;
	else if (name == "Tayuya")
		requiredStorage = 11157;
	else if (name == "Tayuya Cursed")
		requiredStorage = 11158;
	else if (name == "Kimimaru")
		requiredStorage = 11159;
	else if (name == "Kimimaru Cursed")
		requiredStorage = 11160;
	else
		requiredStorage = 0;
}

SagaMonster::~SagaMonster() {}

bool SagaMonster::isSagaMonsterName(const std::string &name)
{
	if (name == "Mizuki" || name == "Ebisu" || name == "Zabuza" ||
		name == "Second Zabuza" || name == "Haku" || name == "Orochimaru" ||
		name == "Zaku" || name == "Kin" || name == "Dosu" ||
		name == "Rain Shinobi" || name == "Kiba" || name == "Neji" ||
		name == "Kankuro" || name == "Temari" || name == "Gaara" ||
		name == "Shukaku One" || name == "Shukaku Two" || name == "Kabuto" ||
		name == "Sasuke" || name == "Jiroubou" || name == "Jiroubou Cursed" ||
		name == "Kidomaru" || name == "Kidomaru Cursed" || name == "Sakon And Ukon" ||
		name == "Sakon And Ukon Cursed" || name == "Tayuya" || name == "Tayuya Cursed" ||
		name == "Kimimaru" || name == "Kimimaru Cursed")
	{
		return true;
	}
	return false;
}

bool SagaMonster::canBeAttackedBy(const Player *player) const
{
	if (requiredStorage == 0)
		return true;

	std::string value;

	if (!const_cast<Player *>(player)->getStorage(requiredStorage, value))
	{
		return false;
	}

	if (atoi(value.c_str()) <= -1)
	{
		return false;
	}

	return true;
}

bool SagaMonster::isAttackable() const
{
	return Monster::isAttackable();
}

void SagaMonster::drainHealth(Creature *attacker, CombatType_t combatType, int32_t damage)
{
	if (attacker)
	{
		if (Player *attackerPlayer = attacker->getPlayer())
		{
			if (!canBeAttackedBy(attackerPlayer))
			{
				g_game.addMagicEffect(getPosition(), MAGIC_EFFECT_POFF);
				return;
			}
		}
	}
	Monster::drainHealth(attacker, combatType, damage);
}

bool SagaMonster::isTarget(Creature *creature)
{
	if (!Monster::isTarget(creature))
		return false;

	if (Player *targetPlayer = creature->getPlayer())
	{
		if (!canBeAttackedBy(targetPlayer))
			return false;
	}
	return true;
}

bool SagaMonster::searchTarget(TargetSearchType_t searchType)
{
	if (!Monster::searchTarget(searchType))
		return false;

	if (attackedCreature)
	{
		Player *targetPlayer = attackedCreature->getPlayer();
		if (targetPlayer && !canBeAttackedBy(targetPlayer))
		{
			setAttackedCreature(NULL);
			return false;
		}
	}
	return true;
}

void SagaMonster::onCreatureAppear(Creature *creature)
{
	Monster::onCreatureAppear(creature);
}

bool SagaMonster::getNextStep(Direction &dir, uint32_t &flags)
{
	if (attackedCreature)
	{
		Player *targetPlayer = attackedCreature->getPlayer();
		if (targetPlayer)
		{
			if (!canBeAttackedBy(targetPlayer))
			{
				eventWalk = 0;
				return false;
			}
		}
	}
	else
	{
		if (requiredStorage != 0)
		{
			eventWalk = 0;
			return false;
		}
	}

	return Monster::getNextStep(dir, flags);
}

bool SagaMonster::canSee(const Position &pos) const
{
	if (!Monster::canSee(pos))
		return false;

	if (Tile *tile = g_game.getMap()->getTile(pos))
	{
		if (Creature *creature = tile->getTopCreature())
		{
			if (Player *p = creature->getPlayer())
			{
				if (!canBeAttackedBy(p))
					return false;
			}
		}
	}
	return true;
}

bool SagaMonster::canSeeCreature(const Creature *creature) const
{
	if (!Monster::canSeeCreature(creature))
		return false;

	if (const Player *targetPlayer = creature->getPlayer())
	{
		if (!canBeAttackedBy(targetPlayer))
			return false;
	}
	return true;
}

bool SagaMonster::selectTarget(Creature *creature)
{
	if (Player *p = creature->getPlayer())
	{
		if (!canBeAttackedBy(p))
			return false;
	}
	return Monster::selectTarget(creature);
}

bool SagaMonster::isOpponent(const Creature *creature)
{
	if (const Player *targetPlayer = creature->getPlayer())
	{
		if (!canBeAttackedBy(targetPlayer))
			return false;
	}
	return const_cast<SagaMonster *>(this)->Monster::isOpponent(const_cast<Creature *>(creature));
}
