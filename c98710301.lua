--六芒星 日光龙 （ZCG）
function c98710301.initial_effect(c)
	  --search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98710301,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c98710301.cost)
	e1:SetTarget(c98710301.target)
	e1:SetOperation(c98710301.operation)
	c:RegisterEffect(e1)
	c98710301.discard_effect=e1
end
function c98710301.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	 if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c98710301.filter(c)
	return c:IsCode(98710301) and c:IsAbleToHand()
end
function c98710301.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c98710301.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c98710301.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c98710301.filter,tp,LOCATION_DECK,0,1,2,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
