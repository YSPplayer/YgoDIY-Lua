--太阳神之圣龙徽章 （ZCG）
function c98710613.initial_effect(c)
	 --coin
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98710613,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetTarget(c98710613.target)
	e1:SetOperation(c98710613.activate)
	c:RegisterEffect(e1)

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
	e52:SetOperation(c98710613.disop2)
	c:RegisterEffect(e52)
	--disable
	local e53=Effect.CreateEffect(c)
	e53:SetType(EFFECT_TYPE_FIELD)
	e53:SetCode(EFFECT_DISABLE)
	e53:SetRange(LOCATION_MZONE)
	e53:SetTargetRange(0xa,0xa)
	e53:SetTarget(c98710613.distg2)
	c:RegisterEffect(e53)
	--self destroy
	local e54=Effect.CreateEffect(c)
	e54:SetType(EFFECT_TYPE_FIELD)
	e54:SetCode(EFFECT_SELF_DESTROY)
	e54:SetRange(LOCATION_MZONE)
	e54:SetTargetRange(0xa,0xa)
	e54:SetTarget(c98710613.distg2)
	c:RegisterEffect(e54)   
end
-------------------------------------------------------------------------
function c98710613.disop2(e,tp,eg,ep,ev,re,r,rp)
	if re:IsActiveType(TYPE_TRAP) and re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
		local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
		if g and g:IsContains(e:GetHandler()) then
			if Duel.NegateEffect(ev) and re:GetHandler():IsRelateToEffect(re) then
				Duel.Destroy(re:GetHandler(),REASON_EFFECT)
			end
		end
	end
end
function c98710613.distg2(e,c)
	return c:GetCardTargetCount()>0 and c:IsType(TYPE_TRAP)
		and c:GetCardTarget():IsContains(e:GetHandler())
end
-------------------------------------------------------------------------
function c98710613.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then 
		if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<1 then return false end
		local g=Duel.GetDecktopGroup(tp,1)
		local result=g:FilterCount(Card.IsAbleToHand,nil)>0
		return result
	end
	Duel.Hint(HINT_SELECTMSG,tp,555)
	local op=Duel.SelectOption(tp,70,71,72)
	e:SetLabel(op)  
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,LOCATION_DECK)
end
function c98710613.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetDecktopGroup(tp,1)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,1-tp,REASON_EFFECT)
		Duel.ConfirmCards(tp,g)
		if (g:GetFirst():GetType()==TYPE_MONSTER and e:GetLabel()==0) or (g:GetFirst():GetType()==TYPE_SPELL and e:GetLabel()==1) or (g:GetFirst():GetType()==TYPE_TRAP and e:GetLabel()==2) then
			Duel.SendtoHand(g,tp,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
			Duel.ChangeAttackTarget(nil)
		else
			Duel.SendtoGrave(g,REASON_EFFECT)
			Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)
		end
		Duel.ShuffleHand(tp)
	end
end

