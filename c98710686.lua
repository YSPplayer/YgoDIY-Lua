--装甲 特种战斗兵 （ZCG）
function c98710686.initial_effect(c)
	 --disable spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetTarget(c98710686.sumlimit)
	c:RegisterEffect(e1)
	--Special summon2
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(98710686,1))
	e3:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCondition(c98710686.spcon2)
	e3:SetTarget(c98710686.target)
	e3:SetOperation(c98710686.activate)
	c:RegisterEffect(e3)
end
function c98710686.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	return c:GetAttack()>=1800
end
function c98710686.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP)
end
function c98710686.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c98710686.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c98710686.filter,tp,0,LOCATION_ONFIELD+LOCATION_HAND,1,c) end
	local sg=Duel.GetMatchingGroup(c98710686.filter,tp,0,LOCATION_ONFIELD+LOCATION_HAND,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c98710686.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c98710686.filter,tp,0,LOCATION_ONFIELD+LOCATION_HAND,aux.ExceptThisCard(e))
	local ct=Duel.Destroy(sg,REASON_EFFECT)
	if ct>0 then 
	Duel.Damage(1-tp,ct*1000,REASON_EFFECT)
end
end







