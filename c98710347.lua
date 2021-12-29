--奥西里斯之魔法学徒 （ZCG）
function c98710347.initial_effect(c)
	 --remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98710347,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c98710347.rmtg)
	e1:SetOperation(c98710347.rmop)
	c:RegisterEffect(e1)
--disable effect
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e12:SetCode(EVENT_CHAIN_SOLVING)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetOperation(c98710347.disop9)
	c:RegisterEffect(e12)
 --immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710347.efilter9)
	c:RegisterEffect(e13)
end
function c98710347.disop9(e,tp,eg,ep,ev,re,r,rp)
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
function c98710347.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x70c1)
end
function c98710347.filter(c)
	return c:IsFacedown()
end
function c98710347.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) and c98710347.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c98710347.filter,tp,0,LOCATION_ONFIELD,1,e:GetHandler()) end
	e:SetProperty(EFFECT_FLAG_CARD_TARGET)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWN)
	Duel.SelectTarget(tp,c98710347.filter,tp,0,LOCATION_ONFIELD,1,1,e:GetHandler())
end
function c98710347.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CARDTYPE)
	local op=Duel.AnnounceType(tp)
	Duel.ConfirmCards(tp,tc)
	if ((op==0 and tc:IsType(TYPE_MONSTER)) or (op==1 and tc:IsType(TYPE_SPELL)) or (op==2 and tc:IsType(TYPE_TRAP))) and tc:IsAbleToRemove() then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end