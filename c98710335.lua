--
function c98710335.initial_effect(c)
		--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98710335,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c98710335.cost)
	e1:SetTarget(c98710335.copytg)
	e1:SetOperation(c98710335.copyop)
	c:RegisterEffect(e1)
--disable effect
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e12:SetCode(EVENT_CHAIN_SOLVING)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetOperation(c98710335.disop9)
	c:RegisterEffect(e12)
 --immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710335.efilter9)
	c:RegisterEffect(e13)
end
function c98710335.disop9(e,tp,eg,ep,ev,re,r,rp)
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
function c98710335.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x70c1)
end
function c98710335.cfilter(c)
	return  c:IsAbleToRemoveAsCost()
end
function c98710335.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98710335.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c98710335.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c98710335.copyfilter(c)
	return c:IsType(TYPE_MONSTER) and not c:IsType(TYPE_TOKEN) and c:IsLocation(LOCATION_GRAVE)
end
function c98710335.copytg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c98710335.copyfilter(chkc) and chkc~=c end
	if chk==0 then return Duel.IsExistingTarget(c98710335.copyfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c98710335.copyfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil)
end
function c98710335.copyop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) and tc:IsLocation(LOCATION_GRAVE) then
		local code=tc:GetOriginalCodeRule()
		local cid=c:CopyEffect(code,RESET_EVENT+RESETS_STANDARD)	   
	end
end
