--殉道者之伤的倍返（ZCG）
function c98710094.initial_effect(c)
	  --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
--win
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_ADJUST)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCondition(c98710094.wincon)
	e3:SetOperation(c98710094.winop)
	c:RegisterEffect(e3)
--immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710094.efilter9)
	c:RegisterEffect(e13)
--disable
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_DISABLE)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetTargetRange(0,LOCATION_ONFIELD)
	e12:SetTarget(c98710094.distg9)
	c:RegisterEffect(e12)
end
function c98710094.distg9(e,c)
	return c:IsSetCard(0x666)
end
function c98710094.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x666)
end
function c98710094.cfilter(c)
	return c:IsSetCard(0x70c1)
end
function c98710094.wincon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c98710094.cfilter,tp,LOCATION_GRAVE+LOCATION_HAND,0,20,nil)
end
function c98710094.winop(e,tp,eg,ep,ev,re,r,rp)
		Duel.Win(tp,0x17)
end