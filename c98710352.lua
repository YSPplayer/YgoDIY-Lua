--奥西里斯之业火凤凰 （ZCG）
function c98710352.initial_effect(c)
		--coin
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c98710352.lpcon)
	e1:SetOperation(c98710352.lpop)
	c:RegisterEffect(e1)
--disable effect
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e12:SetCode(EVENT_CHAIN_SOLVING)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetOperation(c98710352.disop9)
	c:RegisterEffect(e12)
 --immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710352.efilter9)
	c:RegisterEffect(e13)
end
function c98710352.disop9(e,tp,eg,ep,ev,re,r,rp)
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
function c98710352.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x70c1)
end
function c98710352.lpcon(e,tp,eg,ep,ev,re,r,rp)
	return  Duel.GetLP(tp)<6000
end
function c98710352.lpop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetLP(tp,6000)
end