--奥西里斯之孤城斗士 （ZCG）
function c98710336.initial_effect(c)
	 local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
			e1:SetRange(LOCATION_MZONE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(c98710336.val)
			c:RegisterEffect(e1)
---
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98710336,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c98710336.tg)
	e2:SetOperation(c98710336.op)
	c:RegisterEffect(e2)
end
function c98710336.valfilter(c)
return  c:IsSetCard(0x7c11)
end
function c98710336.val(e,c)
return Duel.GetMatchingGroupCount(c98710336.valfilter,tp,LOCATION_GRAVE,0,nil)*700
end
function c98710336.cofilter(c)
return c:IsSetCard(0x7c11) and c:IsType(TYPE_MONSTER) and c:IsLevelBelow(7) and c:IsAbleToRemove()
end
function c98710336.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chkc then return  c98710336.cofilter(chkc) and chkc:GetLocation()==LOCATION_GRAVE end
if chk==0 then return Duel.IsExistingTarget(c98710336.cofilter,tp,LOCATION_GRAVE,0,1,nil) end 
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
  local g=Duel.SelectTarget(tp,c98710336.cofilter,tp,LOCATION_GRAVE,0,1,1,nil)
Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,tp,LOCATION_GRAVE)
end
function c98710336.op(e,tp,eg,ep,ev,re,r,rp)
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