--植物の愤怒 花能量 (ZCG)
function c98710668.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c98710668.condition)
	e1:SetTarget(c98710668.target)
	e1:SetOperation(c98710668.activate)
	c:RegisterEffect(e1)
end
function c98710668.cfilter(c)
	return c:IsFaceup() and c:IsCode(98710658)
end
function c98710668.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c98710668.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c98710668.filter(c)
	return c:IsCode(98710655) and c:IsAbleToHand()
end
function c98710668.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98710668.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c98710668.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c98710668.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
