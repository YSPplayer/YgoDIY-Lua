--邪恶的神龙 （ZCG）
function c98710604.initial_effect(c)
	 --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c98710604.target)
	e1:SetOperation(c98710604.activate)
	c:RegisterEffect(e1)
end
function c98710604.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,5) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(5)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,5)
end
function c98710604.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
	local g1=Duel.GetOperatedGroup()
	Duel.ConfirmCards(1-tp,g1)
	local sg=g1:Filter(c98710604.cfilter,nil,e,tp)
	if sg:GetCount()>0 then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sdg=sg:Select(tp,sg:GetCount(),sg:GetCount(),nil)
		Duel.SpecialSummon(sdg,0,tp,tp,true,true,POS_FACEUP)
	end 
	Duel.ShuffleHand(tp)
end
function c98710604.cfilter(c,e,tp)
	return c:IsAttribute(ATTRIBUTE_DIVINE) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end

