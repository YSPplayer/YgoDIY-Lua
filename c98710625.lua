--太阳神之机械龙 （ZCG）
function c98710625.initial_effect(c)
	   --special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE+LOCATION_REMOVED)
	e1:SetCondition(c98710625.spcon)
	c:RegisterEffect(e1)
	--summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e2)
   --atk up
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_SET_ATTACK)
	e6:SetRange(LOCATION_MZONE)
	e6:SetValue(c98710625.atkval)
	c:RegisterEffect(e6)
   --cannot trigger
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_TRIGGER)
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,0xa)
	e3:SetTarget(c98710625.distg)
	c:RegisterEffect(e3)
 --Attribute
	local e51=Effect.CreateEffect(c)
	e51:SetType(EFFECT_TYPE_SINGLE)
	e51:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e51:SetCode(EFFECT_ADD_ATTRIBUTE)
	e51:SetRange(LOCATION_MZONE)
	e51:SetValue(ATTRIBUTE_DARK+ATTRIBUTE_EARTH+ATTRIBUTE_FIRE+ATTRIBUTE_LIGHT+ATTRIBUTE_WATER+ATTRIBUTE_WIND)
	c:RegisterEffect(e51)
 --disable effect
	local e52=Effect.CreateEffect(c)
	e52:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e52:SetCode(EVENT_CHAIN_SOLVING)
	e52:SetRange(LOCATION_MZONE)
	e52:SetOperation(c98710625.disop2)
	c:RegisterEffect(e52)
	--disable
	local e53=Effect.CreateEffect(c)
	e53:SetType(EFFECT_TYPE_FIELD)
	e53:SetCode(EFFECT_DISABLE)
	e53:SetRange(LOCATION_MZONE)
	e53:SetTargetRange(0xa,0xa)
	e53:SetTarget(c98710625.distg2)
	c:RegisterEffect(e53)
	--self destroy
	local e54=Effect.CreateEffect(c)
	e54:SetType(EFFECT_TYPE_FIELD)
	e54:SetCode(EFFECT_SELF_DESTROY)
	e54:SetRange(LOCATION_MZONE)
	e54:SetTargetRange(0xa,0xa)
	e54:SetTarget(c98710625.distg2)
	c:RegisterEffect(e54)   
end
-------------------------------------------------------------------------
function c98710625.disop2(e,tp,eg,ep,ev,re,r,rp)
	if re:IsActiveType(TYPE_TRAP) and re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
		local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
		if g and g:IsContains(e:GetHandler()) then
			if Duel.NegateEffect(ev) and re:GetHandler():IsRelateToEffect(re) then
				Duel.Destroy(re:GetHandler(),REASON_EFFECT)
			end
		end
	end
end
function c98710625.distg2(e,c)
	return c:GetCardTargetCount()>0 and c:IsType(TYPE_TRAP)
		and c:GetCardTarget():IsContains(e:GetHandler())
end
function c98710625.distg(e,c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c98710625.spfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x7c31)
end
function c98710625.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c98710625.spfilter,c:GetControler(),LOCATION_GRAVE,0,10,nil)
end
function c98710625.atkfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x7c31) and c:IsLevelAbove(1)
end
function c98710625.atkval(e,c)
	local g=Duel.GetMatchingGroup(c98710625.atkfilter,c:GetControler(),LOCATION_GRAVE,LOCATION_GRAVE,nil)
	local atk=g:GetSum(Card.GetLevel)*200
	return atk
end