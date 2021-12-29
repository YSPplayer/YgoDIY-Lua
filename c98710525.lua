--奥利哈刚 地狱之战 （ZCG）
function c98710525.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c98710525.condition)
	e1:SetCost(c98710525.descost)
	e1:SetTarget(c98710525.target)
	e1:SetOperation(c98710525.activate)
	c:RegisterEffect(e1)
end
function c98710525.tgfilter(c)
return c:IsSetCard(0x666) and c:IsType(TYPE_MONSTER)
end
function c98710525.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c98710525.tgfilter,tp,LOCATION_GRAVE,0,3,nil)
end
function c98710525.filter(c)
return c:IsSetCard(0x666) and c:IsAbleToRemoveAsCost() and c:IsType(TYPE_MONSTER)
end
function c98710525.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98710525.filter,tp,LOCATION_GRAVE,0,1,nil) end
	local sg=Duel.GetTargetCount(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	local g=Duel.SelectMatchingCard(tp,c98710525.filter,tp,LOCATION_GRAVE,0,1,sg,nil)
	local ct=Duel.Remove(g,POS_FACEUP,REASON_COST)
	e:SetLabel(ct) 
end
function c98710525.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local number=e:GetLabel()
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,number,number,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c98710525.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local dg=g:Filter(Card.IsRelateToEffect,nil,e)
	Duel.Remove(dg,POS_FACEUP,REASON_EFFECT)
end