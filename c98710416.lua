--奥利哈刚 亚美鲁达 （ZCG）
function c98710416.initial_effect(c)
  --can not be attack target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetCondition(c98710416.atcon)
	e1:SetValue(aux.imval1)
	c:RegisterEffect(e1)
	  --recover
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCountLimit(1)
	e2:SetCondition(c98710416.reccon)
	e2:SetTarget(c98710416.rectg)
	e2:SetOperation(c98710416.recop)
	c:RegisterEffect(e2)
end
function c98710416.atfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x666)
end
function c98710416.atcon(e)
	return Duel.IsExistingMatchingCard(c98710416.atfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end
function c98710416.filter(c)
  return c:IsSetCard(0x666) and c:IsType(TYPE_MONSTER)
end
function c98710416.reccon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c98710416.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98710416.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local ct=Duel.GetMatchingGroupCount(c98710416.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(ct*500)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct*500)
end
function c98710416.recop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end