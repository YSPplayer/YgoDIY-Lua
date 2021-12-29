--奥利哈刚 拷问刑具 （ZCG）
function c98710505.initial_effect(c)
			--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c98710505.target2)
	e1:SetOperation(c98710505.activate2)
	c:RegisterEffect(e1)
 --damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98710505,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c98710505.target)
	e2:SetOperation(c98710505.operation)
	c:RegisterEffect(e2)
end
function c98710505.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	--destroy
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCondition(c98710505.descon)
	e1:SetOperation(c98710505.desop)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_OPPO_TURN,3)
	e:GetHandler():RegisterEffect(e1)
	e:GetHandler():RegisterFlagEffect(98710505,RESET_PHASE+PHASE_END+RESET_OPPO_TURN,0,3)
	c98710505[e:GetHandler()]=e1
end
function c98710505.activate2(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():SetTurnCounter(0)
end
function c98710505.descon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c98710505.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetTurnCounter()
	ct=ct+1
	c:SetTurnCounter(ct)
	if ct==3 then
		Duel.Remove(c,POS_FACEUP,REASON_RULE)
		c:ResetFlagEffect(98710505)
	end
end
function c98710505.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)>0 end
	Duel.SetTargetPlayer(1-tp)
	local dam=Duel.GetMatchingGroupCount(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)*100
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c98710505.operation(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local dam=Duel.GetMatchingGroupCount(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)*100
	Duel.Damage(p,dam,REASON_EFFECT)
end