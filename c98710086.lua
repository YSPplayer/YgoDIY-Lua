--殉道者的苦痛（ZCG）
function c98710086.initial_effect(c)
	 --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_DRAW_PHASE+TIMING_CHAIN_END+TIMING_END_PHASE)
	e1:SetCost(c98710086.cost)
	e1:SetTarget(c98710086.target)
	e1:SetOperation(c98710086.activate)
	c:RegisterEffect(e1)
--immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710086.efilter9)
	c:RegisterEffect(e13)
--disable
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_DISABLE)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetTargetRange(0,LOCATION_ONFIELD)
	e12:SetTarget(c98710086.distg9)
	c:RegisterEffect(e12)
end
function c98710086.distg9(e,c)
	return c:IsSetCard(0x666)
end
function c98710086.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x666)
end
function c98710086.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLP(tp)>1 end
	local lp=Duel.GetLP(tp)
	e:SetLabel(lp-1)
	Duel.PayLPCost(tp,lp-1)
end
function c98710086.tgfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function c98710086.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98710086.tgfilter,tp,0,LOCATION_DECK,1,nil) end
	local sg=Duel.GetMatchingGroup(c98710086.tgfilter,tp,0,LOCATION_DECK,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,sg,sg:GetCount(),0,0)
end
function c98710086.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c98710086.tgfilter,tp,0,LOCATION_DECK,nil)
	Duel.SendtoGrave(sg,REASON_EFFECT)
end
