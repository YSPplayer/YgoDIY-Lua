--奥利哈刚 克莉丝 （ZCG）
function c98710399.initial_effect(c)
	  --actlimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTargetRange(0,1)
	e2:SetValue(c98710399.aclimit)
	e2:SetCondition(c98710399.actcon)
	c:RegisterEffect(e2)
  --to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98710399,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c98710399.tgcon)
	e1:SetTarget(c98710399.tgtg)
	e1:SetOperation(c98710399.tgop)
	c:RegisterEffect(e1)
end
function c98710399.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c98710399.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(aux.TRUE,tp,0,LOCATION_HAND,nil)>0 end
	local ct=Duel.GetMatchingGroupCount(aux.TRUE,tp,0,LOCATION_HAND,nil)
	  Duel.SetTargetPlayer(1-tp)
	  Duel.SetTargetParam(ct*500)
	  Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct*500)
end
function c98710399.tgop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c98710399.actcon(e)
	local tp=e:GetHandlerPlayer()
	local tc=Duel.GetAttacker()
	if not tc then return false end
	if tc:IsControler(1-tp) then tc=Duel.GetAttackTarget() end
	return tc and tc:IsControler(tp)
end
function c98710399.aclimit(e,re,tp)
	return re:IsActiveType(TYPE_TRAP+TYPE_SPELL) and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end