 --殉道者之逆转（ZCG）
local m=98710070
local cm=_G["c"..m]
function c98710070.initial_effect(c)
   --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,98710070+EFFECT_COUNT_CODE_DUEL)
	e1:SetHintTiming(0,TIMING_DRAW_PHASE+TIMING_CHAIN_END+TIMING_END_PHASE)
	e1:SetCondition(c98710070.condition)
	e1:SetTarget(c98710070.target)
	e1:SetOperation(c98710070.operation)
	c:RegisterEffect(e1)
--immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710070.efilter9)
	c:RegisterEffect(e13)
--disable
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_DISABLE)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetTargetRange(0,LOCATION_ONFIELD)
	e12:SetTarget(c98710070.distg9)
	c:RegisterEffect(e12)
end
function c98710070.distg9(e,c)
	return c:IsSetCard(0x666)
end
function c98710070.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x666)
end
function cm.condition(e,tp,eg,ep,ev,re,r,rp)
 return Duel.GetLP(tp)<=1000 
end
function c98710070.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(aux.NOT(Card.IsStatus),tp,0x1e,0,nil,STATUS_BATTLE_DESTROYED)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0x1e)
end
function c98710070.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(aux.NOT(Card.IsStatus),tp,0x1e,0,nil,STATUS_BATTLE_DESTROYED)
	if aux.NecroValleyNegateCheck(g) then return end
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	local tg=Duel.GetOperatedGroup():Filter(Card.IsLocation,nil,LOCATION_DECK)
	if tg:IsExists(Card.IsControler,1,nil,tp) then Duel.ShuffleDeck(tp) end
	Duel.BreakEffect()
	Duel.Draw(tp,5,REASON_EFFECT)
	Duel.SetLP(tp,8000)
	if e:GetHandler():IsRelateToEffect(e) and e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
	end
end
