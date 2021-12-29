--殉道者 地狱魔人使（ZCG）
local m=98710058
local cm=_G["c"..m]
function c98710058.initial_effect(c)
	  --atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(cm.condition)
	e1:SetCost(cm.atkcost)
	e1:SetOperation(cm.operation)
	c:RegisterEffect(e1)
--immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(cm.efilter9)
	c:RegisterEffect(e13)
--disable
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_DISABLE)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetTargetRange(0,LOCATION_ONFIELD)
	e12:SetTarget(cm.distg9)
	c:RegisterEffect(e12)
end
function cm.distg9(e,c)
	return c:IsSetCard(0x666)
end
function cm.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x666)
end
function cm.condition(e,tp,eg,ep,ev,re,r,rp)
   local phase=Duel.GetCurrentPhase()
	if phase~=PHASE_DAMAGE or Duel.IsDamageCalculated() then return false end
	local tc=Duel.GetAttacker()
	if tc:IsControler(1-tp) then tc=Duel.GetAttackTarget() end
	e:SetLabelObject(tc)
	return tc and tc:IsFaceup() and tc:IsSetCard(0x70c1) and tc:IsRelateToBattle()
end
function cm.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToGrave,tp,LOCATION_DECK,0,1,199,nil)
	if g:GetCount()>0 then
		local ct=Duel.SendtoGrave(g,REASON_COST+REASON_EFFECT)
		e:SetLabel(ct)
	end
end
function cm.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetLabelObject()
	if not tc:IsRelateToBattle() or tc:IsFacedown() then return end
	local atk=e:GetLabel()*500
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e1:SetValue(atk)
	tc:RegisterEffect(e1)
end
