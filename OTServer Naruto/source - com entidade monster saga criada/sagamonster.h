#ifndef __SAGAMONSTER_H__
#define __SAGAMONSTER_H__

#include "monster.h"

class SagaMonster : public Monster
{
public:
	SagaMonster(MonsterType *_type);
	virtual ~SagaMonster();

	uint32_t sagaId;
	uint32_t experienceGain;
	bool isElite;
	uint32_t requiredStorage;

	void setSagaId(uint32_t _id) { sagaId = _id; }
	uint32_t getSagaId() const { return sagaId; }

	bool canBeAttackedBy(const Player *player) const;

	virtual void drainHealth(Creature *attacker, CombatType_t combatType, int32_t damage);
	virtual bool isTarget(Creature *creature);
	virtual void onCreatureAppear(Creature *creature);
	virtual bool getNextStep(Direction &dir, uint32_t &flags);
	virtual bool searchTarget(TargetSearchType_t searchType = TARGETSEARCH_DEFAULT);
	static bool isSagaMonsterName(const std::string &name);
	virtual bool isAttackable() const;
	virtual bool selectTarget(Creature *creature);
	virtual bool canSee(const Position &pos) const;
	virtual bool canSeeCreature(const Creature *creature) const;
	virtual bool isOpponent(const Creature *creature);

private:
};

#endif
