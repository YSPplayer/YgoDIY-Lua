--殉道者之随机抽取（ZCG）
function c98710075.initial_effect(c)
		--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c98710075.target)
	e1:SetOperation(c98710075.activate)
	c:RegisterEffect(e1)
--immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710075.efilter9)
	c:RegisterEffect(e13)
--disable
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_DISABLE)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetTargetRange(0,LOCATION_ONFIELD)
	e12:SetTarget(c98710075.distg9)
	c:RegisterEffect(e12)
end
function c98710075.distg9(e,c)
	return c:IsSetCard(0x666)
end
function c98710075.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x666)
end
function c98710075.filter(c)
	return c:IsAbleToHand()
end
function c98710075.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98710075.filter,tp,0,LOCATION_DECK,5,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,5,1-tp,LOCATION_DECK)
end
function c98710075.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_DECK)
	if g:GetCount()>4 then
		local sg=g:RandomSelect(1-tp,5)
		Duel.SendtoHand(sg,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end