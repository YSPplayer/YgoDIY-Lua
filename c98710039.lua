--殉道者 抗魔师（ZCG)
function c98710039.initial_effect(c)
	 --cannot trigger
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_TRIGGER)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,0xa)
	e1:SetTarget(c98710039.distg)
	c:RegisterEffect(e1)
	--disable
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_DISABLE)
	e12:SetRange(LOCATION_MZONE)
	e12:SetTargetRange(0,LOCATION_SZONE)
	e12:SetTarget(c98710039.distg)
	c:RegisterEffect(e12)
	--disable effect
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e13:SetCode(EVENT_CHAIN_SOLVING)
	e13:SetRange(LOCATION_MZONE)
	e13:SetOperation(c98710039.disop)
	c:RegisterEffect(e13)
--immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710039.efilter9)
	c:RegisterEffect(e13)
--disable
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_DISABLE)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetTargetRange(0,LOCATION_ONFIELD)
	e12:SetTarget(c98710039.distg9)
	c:RegisterEffect(e12)
end
function c98710039.distg9(e,c)
	return c:IsSetCard(0x666)
end
function c98710039.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x666)
end
function c98710039.distg(e,c)
	return c:IsType(TYPE_SPELL)
end
function c98710039.disop(e,tp,eg,ep,ev,re,r,rp)
	local tl=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	if tl==LOCATION_SZONE and re:IsActiveType(TYPE_SPELL) and ep~=tp then
		Duel.NegateEffect(ev)
	end
end
