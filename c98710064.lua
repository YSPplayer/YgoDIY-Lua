--殉道者归来（ZCG）
function c98710064.initial_effect(c)
	  --immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c98710064.target)
	e1:SetOperation(c98710064.operation)
	c:RegisterEffect(e1)
--immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710064.efilter9)
	c:RegisterEffect(e13)
--disable
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_DISABLE)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetTargetRange(0,LOCATION_ONFIELD)
	e12:SetTarget(c98710064.distg9)
	c:RegisterEffect(e12)
end
function c98710064.distg9(e,c)
	return c:IsSetCard(0x666)
end
function c98710064.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x666)
end
function c98710064.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x70c1)
end
function c98710064.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98710064.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c98710064.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c98710064.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_IMMUNE_EFFECT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,3)
		e1:SetValue(c98710064.efilter)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
function c98710064.efilter(e,re)
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer()
end
