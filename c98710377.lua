--奥西里斯之穿梭器 （ZCG）
function c98710377.initial_effect(c)
			--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98710377,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c98710377.target)
	e2:SetOperation(c98710377.activate)
	c:RegisterEffect(e2)
--disable effect
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e12:SetCode(EVENT_CHAIN_SOLVING)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetOperation(c98710377.disop9)
	c:RegisterEffect(e12)
 --immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710377.efilter9)
	c:RegisterEffect(e13)
end
function c98710377.disop9(e,tp,eg,ep,ev,re,r,rp)
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
function c98710377.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x70c1)
end
function c98710377.filter(c)
 return c:IsSetCard(0x666) or c:IsSetCard(0x6551) or c:IsSetCard(0x70c1)
end
function c98710377.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local dr=Duel.GetMatchingGroupCount(c98710377.filter,tp,0,LOCATION_ONFIELD,nil)
	if chk==0 then return Duel.GetMatchingGroupCount(c98710377.filter,tp,0,LOCATION_ONFIELD,nil)>0 and Duel.IsPlayerCanDraw(tp,dr) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,dr)
end
function c98710377.activate(e,tp,eg,ep,ev,re,r,rp)
	 local dr=Duel.GetMatchingGroupCount(c98710377.filter,tp,0,LOCATION_ONFIELD,nil)
	 Duel.Draw(tp,dr,REASON_EFFECT)
end