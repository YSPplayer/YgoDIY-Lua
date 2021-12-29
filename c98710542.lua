--奥利哈刚 灵魂摄取 （ZCG）
function c98710542.initial_effect(c)
		--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c98710542.cost)
	e1:SetTarget(c98710542.rectg)
	e1:SetOperation(c98710542.recop)
	c:RegisterEffect(e1)
end
function c98710542.costfilter(c)
 return c:IsSetCard(0x666) and c:IsAbleToGraveAsCost()
end
function c98710542.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98710542.costfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c98710542.costfilter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	local number=tc:GetAttack()+tc:GetDefense()
	e:SetLabel(number)
	Duel.SendtoGrave(g,REASON_COST)
end
function c98710542.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local number=e:GetLabel()
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(number)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,number)
end
function c98710542.spfilter(c,e,tp)
	return c:IsSetCard(0x666) and c:IsType(TYPE_MONSTER) and c:IsLevel(4)
end
function c98710542.recop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Recover(p,d,REASON_EFFECT)~=0 then
	Duel.BreakEffect()
	local g=Duel.GetMatchingGroup(c98710542.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp)
	if #g>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
	Duel.Hint(HINT_SELECTMSG,tp,c98710542)
	local g2=Duel.SelectMatchingCard(tp,c98710542.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	Duel.SpecialSummon(g2,0,tp,tp,false,false,POS_FACEUP)
end
end
end
















