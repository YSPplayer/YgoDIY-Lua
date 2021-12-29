--奥西里斯之邪恶贝斯 （ZCG）
function c98710355.initial_effect(c)
	 --Eraser
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_DAMAGE)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e6:SetCode(EVENT_TO_GRAVE)
	e6:SetCondition(c98710355.erascon)
	e6:SetTarget(c98710355.erastg)
	e6:SetOperation(c98710355.erasop)
	c:RegisterEffect(e6)
--disable effect
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e12:SetCode(EVENT_CHAIN_SOLVING)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetOperation(c98710355.disop9)
	c:RegisterEffect(e12)
 --immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710355.efilter9)
	c:RegisterEffect(e13)
end
function c98710355.disop9(e,tp,eg,ep,ev,re,r,rp)
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
function c98710355.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x70c1)
end
function c98710355.cfilter(c,att)
	return c:IsAttribute(att) and c:IsType(TYPE_MONSTER)
end
function c98710355.erascon(e)
	return e:GetHandler():IsReason(REASON_DESTROY)
end
function c98710355.erastg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dg=Duel.GetMatchingGroupCount(c98710355.cfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil,e:GetHandler():GetAttribute())
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dg*1000)
end
function c98710355.erasop(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetMatchingGroupCount(c98710355.cfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil,e:GetHandler():GetAttribute())
	Duel.Damage(1-tp,dg*1000,REASON_EFFECT)
end