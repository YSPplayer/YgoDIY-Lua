--殉道者之宿命（ZCG）
function c98710065.initial_effect(c)
	  --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c98710065.activate)
	c:RegisterEffect(e1)
--immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710065.efilter9)
	c:RegisterEffect(e13)
--disable
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_DISABLE)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetTargetRange(0,LOCATION_ONFIELD)
	e12:SetTarget(c98710065.distg9)
	c:RegisterEffect(e12)
end
function c98710065.distg9(e,c)
	return c:IsSetCard(0x666)
end
function c98710065.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x666)
end
function c98710065.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetFlagEffect(tp,95308449)~=0 then return end
	Duel.RegisterFlagEffect(tp,95308449,RESET_PHASE+PHASE_END,0,5)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetOperation(c98710065.checkop)
	e1:SetCountLimit(1)
	e1:SetReset(RESET_PHASE+PHASE_END,5)
	Duel.RegisterEffect(e1,tp)
	c:RegisterFlagEffect(1082946,RESET_PHASE+PHASE_END,0,5)
	c98710065[c]=e1
end
function c98710065.checkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=Duel.GetFlagEffect(tp,95308449)
	c:SetHint(CHINT_TURN,ct)
	Duel.RegisterFlagEffect(tp,95308449,RESET_PHASE+PHASE_END,0,6-ct)
	if ct==5 then
		Duel.Win(tp,0x18)
		c:ResetFlagEffect(1082946)
	end
end
