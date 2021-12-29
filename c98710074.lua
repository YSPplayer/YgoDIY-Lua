--殉道者的繁殖兽鱼（ZCG）
function c98710074.initial_effect(c)
	c:EnableCounterPermit(0x142c)
	  --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c98710074.condition)
	e2:SetOperation(c98710074.operation)
	c:RegisterEffect(e2)
 --win
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_ADJUST)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetOperation(c98710074.winop)
	c:RegisterEffect(e3)
--immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710074.efilter9)
	c:RegisterEffect(e13)
--disable
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_DISABLE)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetTargetRange(0,LOCATION_ONFIELD)
	e12:SetTarget(c98710074.distg9)
	c:RegisterEffect(e12)
end
function c98710074.distg9(e,c)
	return c:IsSetCard(0x666)
end
function c98710074.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x666)
end
function c98710074.filter(c,tp)
	return c:GetControler()==1-tp
end
function c98710074.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c98710074.filter,1,nil,tp)
end
function c98710074.operation(e,tp,eg,ep,ev,re,r,rp)
		  e:GetHandler():AddCounter(0x142c,1)
end
function c98710074.winop(e,tp,eg,ep,ev,re,r,rp)
	local WIN_REASON_DESTINY_LEO=0x17
	local c=e:GetHandler()
	if c:GetCounter(0x142c)==20 then
		Duel.Win(tp,WIN_REASON_DESTINY_LEO)
	end
end