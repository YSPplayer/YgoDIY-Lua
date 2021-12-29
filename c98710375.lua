--奥西里斯之同源劫 （ZCG）
function c98710375.initial_effect(c)
	 --Activate(effect)
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_ACTIVATE)
	e4:SetCode(EVENT_CHAINING)
	e4:SetCondition(c98710375.discon)
	e4:SetCost(c98710375.discost)
	e4:SetTarget(c98710375.distg)
	e4:SetOperation(c98710375.disop)
	c:RegisterEffect(e4)
--disable effect
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e12:SetCode(EVENT_CHAIN_SOLVING)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetOperation(c98710375.disop9)
	c:RegisterEffect(e12)
 --immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710375.efilter9)
	c:RegisterEffect(e13)
end
function c98710375.disop9(e,tp,eg,ep,ev,re,r,rp)
	 local tc=re:GetHandler()
	if (tc:IsSetCard(0x666) or tc:IsSetCard(0x6551)) and re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
		local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
		if g and g:IsContains(e:GetHandler()) then
			if Duel.NegateEffect(ev) and re:GetHandler():IsRelateToEffect(re) then
				Duel.Destroy(re:GetHandler(),REASON_EFFECT)
			end
		end
	end
end
function c98710375.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x70c1)
end
function c98710375.filter(c,tpe)
   return c:IsType(tpe) and c:IsDiscardable()
end
function c98710375.discon(e,tp,eg,ep,ev,re,r,rp)
	return ep==1-tp  and (re:IsHasType(EFFECT_TYPE_ACTIVATE) or re:IsActiveType(TYPE_MONSTER))
end
function c98710375.discost(e,tp,eg,ep,ev,re,r,rp,chk)
   local rtype=bit.band(re:GetActiveType(),0x7)
 if chk==0 then return Duel.IsExistingMatchingCard(c98710375.filter,tp,LOCATION_HAND,0,1,nil,rtype) end
	Duel.DiscardHand(tp,c98710375.filter,1,1,REASON_COST+REASON_DISCARD,nil,rtype)
end
function c98710375.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c98710375.disop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.NegateEffect(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end