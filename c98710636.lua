--太阳神的龙之结界 （ZCG）
function c98710636.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c98710636.cost)
	c:RegisterEffect(e1)
	
   --half atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SET_ATTACK_FINAL)
	e2:SetRange(LOCATION_FZONE)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c98710636.atktg)
	e2:SetValue(c98710636.atkval)
	c:RegisterEffect(e2)
	
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(98710636,0))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCondition(c98710636.dmcon)
	e3:SetOperation(c98710636.dmop)
	c:RegisterEffect(e3)

	
   --disable effect
	local e52=Effect.CreateEffect(c)
	e52:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e52:SetCode(EVENT_CHAIN_SOLVING)
	e52:SetRange(LOCATION_ONFIELD)
	e52:SetOperation(c98710636.disop2)
	c:RegisterEffect(e52)
	--disable
	local e53=Effect.CreateEffect(c)
	e53:SetType(EFFECT_TYPE_FIELD)
	e53:SetCode(EFFECT_DISABLE)
	e53:SetRange(LOCATION_ONFIELD)
	e53:SetTargetRange(0xa,0xa)
	e53:SetTarget(c98710636.distg2)
	c:RegisterEffect(e53)
	--self destroy
	local e54=Effect.CreateEffect(c)
	e54:SetType(EFFECT_TYPE_FIELD)
	e54:SetCode(EFFECT_SELF_DESTROY)
	e54:SetRange(LOCATIONLOCATION_ONFIELD_FZONE)
	e54:SetTargetRange(0xa,0xa)
	e54:SetTarget(c98710636.distg2)
	c:RegisterEffect(e54)   
end
-------------------------------------------------------------------------
function c98710636.disop2(e,tp,eg,ep,ev,re,r,rp)
	if re:IsActiveType(TYPE_TRAP) and re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
		local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
		if g and g:IsContains(e:GetHandler()) then
			if Duel.NegateEffect(ev) and re:GetHandler():IsRelateToEffect(re) then
				Duel.Destroy(re:GetHandler(),REASON_EFFECT)
			end
		end
	end
end
function c98710636.distg2(e,c)
	return c:GetCardTargetCount()>0 and c:IsType(TYPE_TRAP)
		and c:GetCardTarget():IsContains(e:GetHandler())
end
-------------------------------------------------------------------------
function c98710636.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
-------------------------------------------------------------------------
function c98710636.atktg(e,c)
	return not c:IsSetCard(0x7c31)
end
function c98710636.atkval(e,c)
	return math.ceil(c:GetAttack()/2)
end
-------------------------------------------------------------------------
function c98710636.dmcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_DESTROY) and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c98710636.dmop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetLP(1-tp,Duel.GetLP()-1000)
end

