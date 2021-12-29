--六芒龙神骑术 （ZCG）
function c98710325.initial_effect(c)
		--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c98710325.cost)
	e1:SetCondition(c98710325.condition)
	e1:SetTarget(c98710325.target)
	e1:SetOperation(c98710325.activate)
	c:RegisterEffect(e1)
end
function c98710325.cfilter(c)
	return c:IsSetCard(0x6550)
end
function c98710325.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c98710325.cfilter,tp,LOCATION_HAND,0,1,nil)
end
function c98710325.hfilter(c)
	return c:IsAbleToGraveAsCost()
end
function c98710325.hgfilter(c)
	return not c:IsSetCard(0x6550)
end
function c98710325.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local hg=Duel.GetMatchingGroup(c98710325.hgfilter,tp,LOCATION_HAND,0,nil)
	hg:RemoveCard(e:GetHandler())
	if chk==0 then return hg:GetCount()>0 and hg:FilterCount(c98710325.hfilter,nil)==hg:GetCount() end
	Duel.SendtoGrave(hg,REASON_COST)
end
function c98710325.filter(c)
	return c:IsCode(98710304) and c:IsAbleToHand()
end
function c98710325.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98710325.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c98710325.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c98710325.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
