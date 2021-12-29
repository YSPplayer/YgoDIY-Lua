--奥利哈刚 多兰之盾（ZCG）
function c98710537.initial_effect(c)
		--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_NEGATE+CATEGORY_DESTROY+CATEGORY_FUSION_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c98710537.condition)
	e1:SetTarget(c98710537.target)
	e1:SetOperation(c98710537.activate)
	c:RegisterEffect(e1)
end
function c98710537.filter(c,tp)
	return c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsSetCard(0x666)
end
function c98710537.condition(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return g and g:IsExists(c98710537.filter,1,nil,tp)
		and Duel.IsChainNegatable(ev) and (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE))
end
function c98710537.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c98710537.refilter(c)
return c:IsCode(code98710537) and c:IsAbleToRemove()
end
function c98710537.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS):Filter(c98710537.filter,nil,tp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) and Duel.Destroy(eg,REASON_EFFECT)~=0 then
	Duel.BreakEffect()
	local g2=Duel.GetOperatedGroup()
	local tc=g2:GetFirst()
	code98710537=tc:GetCode()
	if not Duel.IsExistingMatchingCard(c98710537.refilter,tp,0,LOCATION_DECK,1,nil) then return end  
	local g3=Duel.GetMatchingGroup(c98710537.refilter,tp,0,LOCATION_DECK,nil)
	Duel.Remove(g3,POS_FACEUP,REASON_EFFECT)
	end
end