--殉道者的痛彻一击（ZCG）
function c98710067.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_DRAW_PHASE+TIMING_CHAIN_END+TIMING_END_PHASE+TIMING_TOGRAVE)
	e1:SetTarget(c98710067.target)
	e1:SetOperation(c98710067.activate)
	c:RegisterEffect(e1)
--immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710067.efilter9)
	c:RegisterEffect(e13)
--disable
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_DISABLE)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetTargetRange(0,LOCATION_ONFIELD)
	e12:SetTarget(c98710067.distg9)
	c:RegisterEffect(e12)
end
function c98710067.distg9(e,c)
	return c:IsSetCard(0x666)
end
function c98710067.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x666)
end
function c98710067.filter(c)
	return c:IsAbleToRemove()
end
function c98710067.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local rg=Duel.GetMatchingGroup(c98710067.filter,tp,0,LOCATION_HAND,nil)
	if chk==0 then return
	Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_MZONE,0,1,nil) and rg:GetCount()>0 and rg:IsExists(c98710067.filter,1,nil) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,nil)
	local rg=Duel.GetMatchingGroup(c98710067.filter,tp,0,LOCATION_HAND,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c98710067.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,nil)
	local rg=Duel.GetMatchingGroup(c98710067.filter,tp,0,LOCATION_HAND,nil)
	if Duel.Destroy(g,REASON_EFFECT)~=0 then
 Duel.BreakEffect()
 Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
end
end