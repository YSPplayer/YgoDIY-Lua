--奥利哈刚 西洛诺斯 （ZCG）
function c98710531.initial_effect(c)
		c:EnableReviveLimit()
	--cannot summon
	local e0=Effect.CreateEffect(c)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e0)
 --spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98710531,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetTarget(c98710531.sptg)
	e1:SetOperation(c98710531.spop)
	c:RegisterEffect(e1)
 --ATK goes down
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLED)
	e2:SetCondition(c98710531.statcon)
	e2:SetOperation(c98710531.statop)
	c:RegisterEffect(e2)
	--DEF goes down
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BATTLED)
	e3:SetCondition(c98710531.statcon2)
	e3:SetOperation(c98710531.statop2)
	c:RegisterEffect(e3)
  --
	local e4=Effect.CreateEffect(c)
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetTarget(c98710531.target)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	c:RegisterEffect(e5)
--search
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(98710531,4))
	e6:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e6:SetType(EFFECT_TYPE_IGNITION)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCondition(c98710531.dscon)
	e6:SetCost(c98710531.srcost)
	e6:SetTarget(c98710531.srtg)
	e6:SetOperation(c98710531.srop)
	c:RegisterEffect(e6)
--search
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(98710531,5))
	e7:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e7:SetType(EFFECT_TYPE_IGNITION)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCondition(c98710531.dscon)
	e7:SetCost(c98710531.srcost2)
	e7:SetTarget(c98710531.srtg)
	e7:SetOperation(c98710531.srop)
	c:RegisterEffect(e7)
end
function c98710531.dscon(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	return e:GetHandler():GetAttack()==0
end
function c98710531.srcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,10000) end
	Duel.PayLPCost(tp,10000)
end
function c98710531.target(e,c)
	return c:IsCode(98710532,98710533)
end
function c98710531.srcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
		return g:GetCount()>0 and g:FilterCount(Card.IsDiscardable,nil)==g:GetCount()
	end
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoGrave(g,REASON_COST+REASON_DISCARD)
end
function c98710531.srtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98710531.filter9,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end
function c98710531.filter9(c,e,tp)
	return c:IsCode(98710534) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c98710531.srop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c98710531.filter9,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
function c98710531.filter1(c,e,tp)
	return c:IsCode(98710532) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c98710531.filter2(c,e,tp)
	return c:IsCode(98710533) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c98710531.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsExistingMatchingCard(c98710531.filter1,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) and Duel.IsExistingMatchingCard(c98710531.filter2,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE)
end
function c98710531.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectMatchingCard(tp,c98710531.filter1,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if not g1 then return end
	local g2=Duel.SelectMatchingCard(tp,c98710531.filter2,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if not g2 then return end
	local g=Group.FromCards(g1,g2)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
	end
end
function c98710531.statcon(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local a=Duel.GetAttacker()
local b=Duel.GetAttackTarget()
if c==nil or a==nil or b==nil then return end
if c==a then return b:GetPosition()==POS_FACEUP_ATTACK or b:GetPosition()==POS_FACEDOWN_ATTACK
else if c==b then return a:GetPosition()==POS_FACEUP_ATTACK or a:GetPosition()==POS_FACEDOWN_ATTACK
end
end
end
function c98710531.statop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	local atk=bc:GetAttack()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-atk)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e:GetHandler():RegisterEffect(e1)
end
function c98710531.statcon2(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local a=Duel.GetAttacker()
local b=Duel.GetAttackTarget()
if c==a then return b:GetPosition()==POS_FACEUP_DEFENSE or b:GetPosition()==POS_FACEUP_DEFENSE
else if c==b then return a:GetPosition()==POS_FACEUP_DEFENSE or a:GetPosition()==POS_FACEUP_DEFENSE
end
end
end
function c98710531.statop2(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	local def=bc:GetAttack()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-def)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e:GetHandler():RegisterEffect(e1)
end