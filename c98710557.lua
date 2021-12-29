--奥利哈刚 阿喀琉斯 （ZCG）
function c98710557.initial_effect(c)
 --atkup
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(98710557,1))
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetCategory(CATEGORY_DAMAGE)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY+EFFECT_FLAG_CANNOT_INACTIVATE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c98710557.sdcon)
	e5:SetCost(c98710557.spcost)
	e5:SetTarget(c98710557.rectg)
	e5:SetOperation(c98710557.recop)
	c:RegisterEffect(e5)
	 --indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(1)
	e2:SetCondition(c98710557.indcon)
	c:RegisterEffect(e2)
	if not c98710557.global_check then
	c98710557.global_check=true
	c98710557[0]=0
	c98710557[1]=0
	local ge1=Effect.CreateEffect(c)
	ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	ge1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	ge1:SetOperation(c98710557.checkop)
	Duel.RegisterEffect(ge1,0)
end
end
function c98710557.indcon(e)
	return e:GetHandler():IsAttackPos()
end
function c98710557.checkop(e,tp,eg,ep,ev,re,r,rp)
if bit.band(r,REASON_BATTLE)==0 and Duel.GetAttacker()~=nil and Duel.GetAttackTarget()~=nil then
c98710557[ep]=c98710557[ep]+ev
end
end
function c98710557.sdcon(e,tp,eg,ep,ev,re,r,rp)
   return c98710557[tp]>3000
end
function c98710557.costfilter(c)
	return c:IsSetCard(0x666) and c:IsAbleToGraveAsCost()
end
function c98710557.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	  if chk==0 then return Duel.IsExistingMatchingCard(c98710557.costfilter,tp,LOCATION_MZONE,0,nil) end
	local rg=Duel.GetMatchingGroup(tp,c98710557.costfilter,tp,LOCATION_MZONE,0,nil)
	local dam=rg:GetSum(Card.GetAttack)+rg:GetSum(Card.GetDefense)
	e:SetLabel(#dam)
	Duel.SendtoGrave(rg,REASON_COST)
end
function c98710557.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dam=e:GetLabel()
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,dam)
end
function c98710557.recop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end


