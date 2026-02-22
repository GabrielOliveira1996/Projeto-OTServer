#ifndef __AKAMARU_H__
#define __AKAMARU_H__

#include "monster.h"

class Player;

class Akamaru : public Monster
{
public:
	Akamaru(MonsterType *_mType, Player *_master);
	virtual ~Akamaru();

	int32_t getMaxHealth() const;
	int32_t getSpeed() const;

	Player *getMaster() const { return master; }
	void updateStats();

private:
	Player *master;
};

#endif