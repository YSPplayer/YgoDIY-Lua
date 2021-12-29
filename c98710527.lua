--奥利哈刚 暗黑的馈赠 （ZCG）
function c98710527.initial_effect(c)
		--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c98710527.target)
	e1:SetOperation(c98710527.activate)
	c:RegisterEffect(e1)
end
function c98710527.filter(c)
return c:IsSetCard(0x666) and c:IsType(TYPE_MONSTER)
end
function c98710527.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroupCount(c98710527.filter,e:GetHandler():GetControler(),LOCATION_ONFIELD,0,nil)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,g) and g>0 end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(g)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,g)
end
function c98710527.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
