--奥利哈刚 暗黑破坏神 （ZCG）
function c98710395.initial_effect(c)   
	--pos change
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c98710395.target)
	e1:SetOperation(c98710395.operation)
	c:RegisterEffect(e1)
end
function c98710395.filter(c)
return not c:IsAttackPos() 
end
function c98710395.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE)  and not chkc:IsAttackPos() end
	if chk==0 then return Duel.IsExistingTarget(c98710395.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DEFENCE)
	local g=Duel.SelectTarget(tp,c98710395.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c98710395.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and not tc:IsAttackPos() then
		Duel.ChangePosition(tc,POS_FACEUP_ATTACK)
	end
end
