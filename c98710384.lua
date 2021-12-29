--红通通☆奥西里斯的天空龙 (ZCG)
function c98710384.initial_effect(c)
	   c:EnableReviveLimit()
 aux.AddXyzProcedure(c,nil,12,2)
---XyzSummon2
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98710384,1))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c98710384.xyzcon)
	e2:SetOperation(c98710384.xyzop)
	c:RegisterEffect(e2)
--disim
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98710384,2))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c98710384.discost)
	e1:SetOperation(c98710384.imop)
	c:RegisterEffect(e1)
--Destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(98710384,3))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c98710384.discost)
	e3:SetTarget(c98710384.destg)
	e3:SetOperation(c98710384.desop)
	c:RegisterEffect(e3)
--Destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(98710384,4))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCost(c98710384.discost)
	e4:SetTarget(c98710384.adtg)
	e4:SetOperation(c98710384.adop)
	c:RegisterEffect(e4)
 --atk/def
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_UPDATE_ATTACK)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetRange(LOCATION_MZONE)
	e6:SetValue(c98710384.adval)
	c:RegisterEffect(e6)
	local e7=e6:Clone()
	e7:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e7)
end
function c98710384.tgfilter(c)
	return c:IsSetCard(0x48) and c:IsAbleToGrave()
end
function c98710384.adtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98710384.tgfilter,tp,LOCATION_DECK+LOCATION_EXTRA+LOCATION_ONFIELD+LOCATION_HAND,LOCATION_DECK+LOCATION_EXTRA+LOCATION_ONFIELD+LOCATION_HAND,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK+LOCATION_EXTRA+LOCATION_ONFIELD+LOCATION_HAND)
end
function c98710384.adop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g2=Duel.GetFieldGroup(tp,0,LOCATION_HAND+LOCATION_DECK+LOCATION_EXTRA)
	Duel.ConfirmCards(tp,g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c98710384.tgfilter,tp,LOCATION_DECK+LOCATION_EXTRA+LOCATION_ONFIELD+LOCATION_HAND,LOCATION_DECK+LOCATION_EXTRA+LOCATION_ONFIELD+LOCATION_HAND,1,1,nil)
	if g:GetCount()>0 then
		if Duel.SendtoGrave(g,REASON_EFFECT)~=0 then 
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DIRECT_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
		Duel.ShuffleHand(1-tp)
	end
end
end
function c98710384.adval(e,c)
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_HAND,0)*4000
end
function c98710384.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c98710384.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_MZONE,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_MZONE,2,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c98710384.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local dg=g:Filter(Card.IsRelateToEffect,nil,e)
		if Duel.Destroy(dg,REASON_EFFECT)~=0 then
		local g=Duel.GetOperatedGroup()
		local dam=g:GetSum(Card.GetAttack)
	Duel.Damage(1-tp,dam,REASON_BATTLE)
	end
end
function c98710384.imop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_IMMUNE_EFFECT)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetReset(RESET_EVENT+RESETS_STANDARD)
	e5:SetValue(c98710384.efilter)
	c:RegisterEffect(e5)
end
function c98710384.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c98710384.hofilter(c,tp,xyzc)
	return c:IsCanBeXyzMaterial(xyzc) and c:IsSetCard(0x48)
end
function c98710384.xyzcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return false end
	return Duel.IsExistingMatchingCard(c98710384.hofilter,tp,LOCATION_EXTRA,0,2,nil,tp,c)
end
function c98710384.xyzop(e,tp,eg,ep,ev,re,r,rp,c)
	local tp=c:GetControler()
	Duel.PayLPCost(tp,500)
	local mg=Duel.SelectMatchingCard(tp,c98710384.hofilter,tp,LOCATION_EXTRA,0,2,2,nil,tp,c)
	if mg:GetCount()<0 then return end
	c:SetMaterial(mg)
	Duel.Overlay(c, mg)
end