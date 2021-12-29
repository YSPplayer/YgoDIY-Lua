--殉道者 火炎焱君（ZCG）
function c98710035.initial_effect(c)
	  local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
			e1:SetRange(LOCATION_MZONE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(c98710035.val)
			c:RegisterEffect(e1)
---
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98710035,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c98710035.tg)
	e2:SetOperation(c98710035.op)
	c:RegisterEffect(e2)
 --immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710035.efilter9)
	c:RegisterEffect(e13)
--disable
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_DISABLE)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetTargetRange(0,LOCATION_ONFIELD)
	e12:SetTarget(c98710035.distg9)
	c:RegisterEffect(e12)
end
function c98710035.distg9(e,c)
	return c:IsSetCard(0x666)
end
function c98710035.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x666)
end
function c98710035.valfilter(c)
return c:IsType(TYPE_MONSTER) and not c:IsSetCard(0x70c1)
end
function c98710035.val(e,c)
return Duel.GetMatchingGroupCount(c98710035.valfilter,tp,0,LOCATION_GRAVE,nil)*300
end
function c98710035.cofilter(c)
return c:IsSetCard(0x70c1) and c:IsType(TYPE_MONSTER) and c:IsLevelBelow(7) and c:IsAbleToRemove()
end
function c98710035.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chkc then return  c98710035.cofilter(chkc) and chkc:GetLocation()==LOCATION_GRAVE end
if chk==0 then return Duel.IsExistingTarget(c98710035.cofilter,tp,LOCATION_GRAVE,0,1,nil) end 
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
  local g=Duel.SelectTarget(tp,c98710035.cofilter,tp,LOCATION_GRAVE,0,1,1,nil)
Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,tp,LOCATION_GRAVE)
end
function c98710035.op(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local tc=Duel.GetFirstTarget()--diao yong g
if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) then 
  if Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)~=1 then return end
   local code=tc:GetCode()
		 c:CopyEffect(code,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,1)
	 local e1=Effect.CreateEffect(c)
		   e1:SetType(EFFECT_TYPE_SINGLE)
		   e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		   e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		   e1:SetCode(EFFECT_CHANGE_CODE)
		  e1:SetValue(code)
		  c:RegisterEffect(e1)
end
end