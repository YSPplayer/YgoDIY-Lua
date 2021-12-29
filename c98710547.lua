--奥利哈刚 天神荡 （ZCG）
function c98710547.initial_effect(c)
	 --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE+EFFECT_FLAG_CANNOT_INACTIVATE)
	e1:SetTarget(c98710547.target)
	e1:SetOperation(c98710547.activate)
	c:RegisterEffect(e1)
end
function c98710547.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_DECK+LOCATION_EXTRA+LOCATION_ONFIELD+LOCATION_HAND+LOCATION_GRAVE,1,nil) end
	local sg=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_DECK+LOCATION_EXTRA+LOCATION_ONFIELD+LOCATION_HAND+LOCATION_GRAVE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,sg,sg:GetCount(),0,0)
	Duel.SetChainLimit(aux.FALSE)
end
function c98710547.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_DECK+LOCATION_EXTRA+LOCATION_ONFIELD+LOCATION_HAND+LOCATION_GRAVE,nil)
	local ct=Duel.Remove(sg,POS_FACEUP,REASON_EFFECT+REASON_DESTROY)
end