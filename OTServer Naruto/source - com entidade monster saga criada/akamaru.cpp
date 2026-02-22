#include "akamaru.h"
#include "player.h"
#include "game.h"

Akamaru::Akamaru(MonsterType *_mType, Player *_master) : Monster(_mType), master(_master)
{
	this->isSummon = true;
	this->master = _master;

	updateStats();
	this->health = this->healthMax;
}

Akamaru::~Akamaru() {}

int32_t Akamaru::getMaxHealth() const
{
	if (master)
	{
		if (AkamaruData *data = master->getAkamaruData())
		{
			return 150 + (data->healthPts * 10);
		}
	}
	return 150;
}

int32_t Akamaru::getSpeed() const
{
	if (master)
	{
		if (AkamaruData *data = master->getAkamaruData())
		{
			return 200 + (data->speedPts * 5);
		}
	}
	return 200;
}

void Akamaru::updateStats()
{
	this->healthMax = getMaxHealth();
	g_game.changeSpeed(this, getSpeed());
}