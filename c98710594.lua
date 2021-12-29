--奥利哈刚超强壶 （ZCG）
function c98710594.initial_effect(c)
	   --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c98710594.condition)
	e1:SetTarget(c98710594.target)
	e1:SetOperation(c98710594.activate)
	c:RegisterEffect(e1)
end
function c98710594.cfilter(c)
	return c:IsType(TYPE_SPELL)
end
function c98710594.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c98710594.cfilter,tp,LOCATION_DECK,0,1,nil)
end
function c98710594.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c98710594.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
