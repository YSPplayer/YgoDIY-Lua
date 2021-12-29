--太阳神的蔷薇限定 （ZCG）
function c98710641.initial_effect(c)
		--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetCode(EVENT_DRAW)
	e1:SetCondition(c98710641.condition)
	e1:SetOperation(c98710641.activate)
	c:RegisterEffect(e1)
 --disable effect
	local e52=Effect.CreateEffect(c)
	e52:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e52:SetCode(EVENT_CHAIN_SOLVING)
	e52:SetRange(LOCATION_SZONE)
	e52:SetOperation(c98710641.disop2)
	c:RegisterEffect(e52)
	--disable
	local e53=Effect.CreateEffect(c)
	e53:SetType(EFFECT_TYPE_FIELD)
	e53:SetCode(EFFECT_DISABLE)
	e53:SetRange(LOCATION_SZONE)
	e53:SetTargetRange(0xa,0xa)
	e53:SetTarget(c98710641.distg2)
	c:RegisterEffect(e53)
	--self destroy
	local e54=Effect.CreateEffect(c)
	e54:SetType(EFFECT_TYPE_FIELD)
	e54:SetCode(EFFECT_SELF_DESTROY)
	e54:SetRange(LOCATION_SZONE)
	e54:SetTargetRange(0xa,0xa)
	e54:SetTarget(c98710641.distg2)
	c:RegisterEffect(e54)	 
end
-------------------------------------------------------------------------
function c98710641.disop2(e,tp,eg,ep,ev,re,r,rp)
	if re:IsActiveType(TYPE_TRAP) and re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
		local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
		if g and g:IsContains(e:GetHandler()) then
			if Duel.NegateEffect(ev) and re:GetHandler():IsRelateToEffect(re) then
				Duel.Destroy(re:GetHandler(),REASON_EFFECT)
			end
		end
	end
end
function c98710641.distg2(e,c)
	return c:GetCardTargetCount()>0 and c:IsType(TYPE_TRAP)
		and c:GetCardTarget():IsContains(e:GetHandler())
end
function c98710641.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and r==REASON_RULE
end
function c98710641.filter(c,typ)
	return c:IsType(typ)
end
function c98710641.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc:IsLocation(LOCATION_HAND) then
	   Duel.ConfirmCards(tp,tc)
	  local typ=tc:GetType()
	  local g=Duel.GetMatchingGroup(c98710641.filter,tp,0,LOCATION_ONFIELD+LOCATION_HAND,nil,typ)
	  if g:GetCount()>0 then
	  Duel.ConfirmCards(tp,g)
	  local eg=Duel.SelectMatchingCard(tp,c98710641.filter,tp,0,LOCATION_ONFIELD+LOCATION_HAND,1,1,nil,typ)
	  Duel.Destroy(eg,REASON_EFFECT)
	   end
	Duel.ShuffleHand(1-tp)
	end
end
