--殉道者 地狱狱卒（ZCG）
function c98710034.initial_effect(c)
	local e1=Effect.CreateEffect(c)
		  e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F) 
		  e1:SetCode(EVENT_BATTLE_DAMAGE)
		  e1:SetRange(LOCATION_MZONE)
		  e1:SetCondition(c98710034.con)
		  e1:SetOperation(c98710034.op)
		  c:RegisterEffect(e1)
 --immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710034.efilter9)
	c:RegisterEffect(e13)
--disable
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_DISABLE)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetTargetRange(0,LOCATION_ONFIELD)
	e12:SetTarget(c98710034.distg9)
	c:RegisterEffect(e12)
end
function c98710034.distg9(e,c)
	return c:IsSetCard(0x666)
end
function c98710034.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x666)
end
function c98710034.con(e,tp,eg,ep,ev,re,r,rp)
	  return ep==tp and rp==1-tp and Duel.GetAttacker():IsControler(1-tp)
end 
function c98710034.op(e,tp,eg,ep,ev,re,r,rp)
  local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetCode(EFFECT_SKIP_DP)
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	Duel.RegisterEffect(e1,tp)
end