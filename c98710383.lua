--奥西里斯之伤害爆破器 （ZCG）
function c98710383.initial_effect(c)
	  c:EnableCounterPermit(0x144c)
		  --activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
--add
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_COUNTER)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c98710383.adcon)
	e3:SetOperation(c98710383.adop)
	c:RegisterEffect(e3)
  --destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98710383,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCost(c98710383.descost)
	e2:SetTarget(c98710383.destg)
	e2:SetOperation(c98710383.desop)
	c:RegisterEffect(e2)
--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(98710383,1))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCost(c98710383.descost2)
	e4:SetTarget(c98710383.destg2)
	e4:SetOperation(c98710383.desop2)
	c:RegisterEffect(e4)
--Remove
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(98710383,2))
	e4:SetCategory(CATEGORY_REMOVE)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCost(c98710383.descost3)
	e4:SetTarget(c98710383.destg3)
	e4:SetOperation(c98710383.desop3)
	c:RegisterEffect(e4)
--Remove
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(98710383,3))
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCost(c98710383.descost4)
	e5:SetOperation(c98710383.desop4)
	c:RegisterEffect(e5)
--disable effect
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e12:SetCode(EVENT_CHAIN_SOLVING)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetOperation(c98710383.disop9)
	c:RegisterEffect(e12)
 --immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710383.efilter9)
	c:RegisterEffect(e13)
end
function c98710383.disop9(e,tp,eg,ep,ev,re,r,rp)
	 local tc=re:GetHandler()
	if (tc:IsSetCard(0x666) or tc:IsSetCard(0x6551)) and re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
		local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
		if g and g:IsContains(e:GetHandler()) then
			if Duel.NegateEffect(ev) and re:GetHandler():IsRelateToEffect(re) then
				Duel.Destroy(re:GetHandler(),REASON_EFFECT)
			end
		end
	end
end
function c98710383.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x70c1)
end
function c98710383.descost4(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x144c,15,REASON_COST) end
	e:GetHandler():RemoveCounter(tp,0x144c,15,REASON_COST)
end
function c98710383.desop4(e,tp,eg,ep,ev,re,r,rp)
	 Duel.Win(tp,0x17)
end
function c98710383.cfilter2(c,tp,rp)
	return c:IsPreviousControler(1-tp) and (c:IsReason(REASON_BATTLE) or c:IsReason(REASON_EFFECT)) and rp==tp
end
function c98710383.adcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c98710383.cfilter2,1,nil,tp,rp)
end
function c98710383.adop(e,tp,eg,ep,ev,re,r,rp)
		  e:GetHandler():AddCounter(0x144c,1)
end
function c98710383.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x144c,3,REASON_COST) end
	e:GetHandler():RemoveCounter(tp,0x144c,3,REASON_COST)
end
function c98710383.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c98710383.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c98710383.filter,tp,0,LOCATION_ONFIELD,1,c) end
	local sg=Duel.GetMatchingGroup(c98710383.filter,tp,0,LOCATION_ONFIELD,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c98710383.desop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c98710383.filter,tp,0,LOCATION_ONFIELD,aux.ExceptThisCard(e))
	Duel.Destroy(sg,REASON_EFFECT)
end
function c98710383.descost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x144c,5,REASON_COST) end
	e:GetHandler():RemoveCounter(tp,0x144c,5,REASON_COST)
end
function c98710383.destg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c98710383.desop2(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(sg,REASON_EFFECT) 
end
function c98710383.descost3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x144c,8,REASON_COST) end
	e:GetHandler():RemoveCounter(tp,0x144c,8,REASON_COST)
end
function c98710383.destg3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_ONFIELD+LOCATION_HAND,1,nil) end
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD+LOCATION_HAND,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,sg,sg:GetCount(),0,0)
end
function c98710383.desop3(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD+LOCATION_HAND,nil)
	Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
end