--六芒星的奥义 （ZCG）
function c98710326.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
		--negate
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_NEGATE)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_CHAINING)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetRange(LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED)
	e4:SetCondition(c98710326.negcon)
	e4:SetTarget(c98710326.negtg)
	e4:SetOperation(c98710326.negop)
	c:RegisterEffect(e4)
end
function c98710326.tfilter(c,tp)
	return c:IsLocation(LOCATION_ONFIELD) and c:IsControler(tp) and c:IsFaceup() and c:IsSetCard(0x6551)
end
function c98710326.negcon(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp then return end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return g and g:IsExists(c98710326.tfilter,1,nil,tp) and Duel.IsChainDisablable(ev)
end
function c98710326.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c98710326.negop(e,tp,eg,ep,ev,re,r,rp)
   if Duel.NegateActivation(ev) then
	globeDisCode=eg:GetFirst():GetCode()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAIN_SOLVING)
	e1:SetCondition(c98710326.discon)
	e1:SetOperation(c98710326.disop)
	Duel.RegisterEffect(e1,tp)
end
end
function c98710326.discon(e,tp,eg,ep,ev,re,r,rp)
	return re:GetHandler():IsCode(globeDisCode)
end
function c98710326.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,98710326)
	Duel.ChangeChainOperation(ev,c98710326.repop) 
end
function c98710326.repop(e,tp,eg,ep,ev,re,r,rp)
end
