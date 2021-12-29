--殉道者之远及近（ZCG）
function c98710090.initial_effect(c)
   --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_DRAW_PHASE+TIMING_CHAIN_END+TIMING_END_PHASE)
	c:RegisterEffect(e1)
 --act limit
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98710090,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTarget(c98710090.target)
	e1:SetOperation(c98710090.operation)
	c:RegisterEffect(e1)
--immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710090.efilter9)
	c:RegisterEffect(e13)
--disable
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_DISABLE)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetTargetRange(0,LOCATION_ONFIELD)
	e12:SetTarget(c98710090.distg9)
	c:RegisterEffect(e12)
end
function c98710090.distg9(e,c)
	return c:IsSetCard(0x666)
end
function c98710090.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x666)
end
function c98710090.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CARDTYPE)
	e:SetLabel(Duel.AnnounceType(tp))
end
function c98710090.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(1,1)
	if e:GetLabel()==0 then
		e1:SetDescription(aux.Stringid(98710090,2))
		e1:SetValue(c98710090.aclimit1)
	elseif e:GetLabel()==1 then
		e1:SetDescription(aux.Stringid(98710090,3))
		e1:SetValue(c98710090.aclimit2)
	else
		e1:SetDescription(aux.Stringid(98710090,4))
		e1:SetValue(c98710090.aclimit3)
	end
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,1)
	Duel.RegisterEffect(e1,tp)
end
function c98710090.aclimit1(e,re,tp)
	return re:IsActiveType(TYPE_MONSTER)
end
function c98710090.aclimit2(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL)
end
function c98710090.aclimit3(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_TRAP)
end
