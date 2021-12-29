--奥西里斯之雷斧战士 （ZCG）
function c98710341.initial_effect(c)
	 --summon & set with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98710341,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c98710341.ntcon)
	e1:SetOperation(c98710341.ntop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_PROC)
	c:RegisterEffect(e2)
---
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(98710336,1))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c98710341.tg)
	e3:SetOperation(c98710341.op)
	c:RegisterEffect(e3)
--disable effect
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e12:SetCode(EVENT_CHAIN_SOLVING)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetOperation(c98710341.disop9)
	c:RegisterEffect(e12)
 --immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710341.efilter9)
	c:RegisterEffect(e13)
end
function c98710341.disop9(e,tp,eg,ep,ev,re,r,rp)
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
function c98710341.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x70c1)
end
function c98710341.cofilter(c)
return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c98710341.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chkc then return  c98710341.cofilter(chkc) and chkc:GetLocation()==LOCATION_GRAVE end
if chk==0 then return Duel.IsExistingTarget(c98710341.cofilter,tp,LOCATION_GRAVE,0,1,nil) end 
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
  local g=Duel.SelectTarget(tp,c98710341.cofilter,tp,LOCATION_GRAVE,0,1,1,nil)
Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,tp,LOCATION_GRAVE)
end
function c98710341.op(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local tc=Duel.GetFirstTarget()
if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) then 
	if Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)~=1 then return end
		   local atk=tc:GetAttack()
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD)
			e2:SetValue(atk/2)
			c:RegisterEffect(e2)
end
end
function c98710341.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c98710341.ntop(e,tp,eg,ep,ev,re,r,rp,c)
	--change base attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetReset(RESET_EVENT+0xff0000)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetValue(1700)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_BASE_DEFENSE)
	e2:SetValue(1600)
	c:RegisterEffect(e2)
end
