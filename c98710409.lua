--奥利哈刚 奇甲之盾 （ZCG）
function c98710409.initial_effect(c)
		--immune effect
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_IMMUNE_EFFECT)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetTarget(c98710409.etarget)
	e4:SetValue(c98710409.efilter2)
	c:RegisterEffect(e4)
	--atk limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e3:SetValue(c98710409.atlimit)
	c:RegisterEffect(e3)
  --destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98710409,0))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_START)
	e2:SetTarget(c98710409.destg)
	e2:SetOperation(c98710409.desop)
	c:RegisterEffect(e2)
end
function c98710409.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(aux.TRUE,e:GetHandler():GetControler(),LOCATION_HAND,0,nil)>0 end 
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_HAND)
end
function c98710409.desop(e,tp,eg,ep,ev,re,r,rp)
   local c=e:GetHandler()
   local ct=Duel.SelectMatchingCard(e:GetHandler():GetControler(),aux.TRUE,e:GetHandler():GetControler(),LOCATION_HAND,0,1,4,nil)
   if   Duel.SendtoGrave(ct,REASON_EFFECT)~=0 and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_DEFENSE)
		e1:SetValue(#ct*600)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
end
end
function c98710409.atlimit(e,c)
	return c~=e:GetHandler()
end
function c98710409.etarget(e,c)
	return c:IsFaceup() and c:IsSetCard(0x666)
end
function c98710409.efilter2(e,re)
	return re:GetOwnerPlayer()~=e:GetHandlerPlayer()
end