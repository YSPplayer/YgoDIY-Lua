--奥利哈刚 米诺 （ZCG）
function c98710405.initial_effect(c)
		--atk limit
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(0,LOCATION_MZONE)
	e4:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e4:SetValue(c98710405.atlimit)
	c:RegisterEffect(e4)
	--Eraser
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(98710405,0))
	e6:SetCategory(CATEGORY_ATKCHANGE)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e6:SetCode(EVENT_TO_GRAVE)
	e6:SetCondition(c98710405.erascon)
	e6:SetTarget(c98710405.erastg)
	e6:SetOperation(c98710405.erasop)
	c:RegisterEffect(e6)
end
function c98710405.erascon(e)
	return e:GetHandler():IsReason(REASON_DESTROY)
end
function c98710405.filter(c)
return c:IsSetCard(0x666)
end
function c98710405.erastg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c98710405.filter(chkc) end
	if chk==0 then return Duel.GetMatchingGroupCount(c98710405.filter,tp,LOCATION_MZONE,0,nil)>0 end
   Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c98710405.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c98710405.erasop(e,tp,eg,ep,ev,re,r,rp)
   local tc=Duel.GetFirstTarget()
   local c=e:GetHandler()
if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local atk=c:GetDefense() 
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
end
end
function c98710405.atlimit(e,c)
	return c~=e:GetHandler()
end