--殉道者的休闲时刻（ZCG）
function c98710083.initial_effect(c)
	 --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCost(c98710083.cost)
	e1:SetOperation(c98710083.activate)
	c:RegisterEffect(e1)
--immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710083.efilter9)
	c:RegisterEffect(e13)
--disable
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_DISABLE)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetTargetRange(0,LOCATION_ONFIELD)
	e12:SetTarget(c98710083.distg9)
	c:RegisterEffect(e12)
end
function c98710083.distg9(e,c)
	return c:IsSetCard(0x666)
end
function c98710083.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x666)
end
function c98710083.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	  if chk==0 then return Duel.CheckLPCost(tp,3000) end
		 Duel.PayLPCost(tp,3000)
end
function c98710083.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetCode(EFFECT_SKIP_DP)
	e1:SetReset(RESET_PHASE+PHASE_DRAW+RESET_OPPO_TURN)
	Duel.RegisterEffect(e1,tp)
  if Duel.IsPlayerCanDraw(tp,1) then
	Duel.BreakEffect()
	Duel.Draw(tp,1,REASON_EFFECT)
end
end
