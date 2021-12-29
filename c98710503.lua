--奥利哈刚 黑暗磁场 （ZCG）
function c98710503.initial_effect(c)
		--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CONTINUOUS_TARGET)
	e1:SetTarget(c98710503.target)
	e1:SetOperation(c98710503.operation)
	c:RegisterEffect(e1)
 --equip limit
	local e0=Effect.CreateEffect(c)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_EQUIP_LIMIT)
	e0:SetValue(c98710503.eqlimit)
	c:RegisterEffect(e0)
 --cannot trigger
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_CANNOT_TRIGGER)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetTargetRange(0,0xa)
	e2:SetTarget(c98710503.distg)
	c:RegisterEffect(e2)
  --disable
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_EQUIP)
	e12:SetCode(EFFECT_DISABLE)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetTargetRange(0,LOCATION_SZONE)
	e12:SetTarget(c98710503.distg)
	c:RegisterEffect(e12)
	--disable effect
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_EQUIP)
	e13:SetCode(EVENT_CHAIN_SOLVING)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetOperation(c98710503.disop)
	c:RegisterEffect(e13)
end
function c98710503.eqlimit(e,c)
	return c:IsSetCard(0x666)
end
function c98710503.distg(e,c)
	return c:IsType(TYPE_SPELL)
end
function c98710503.disop(e,tp,eg,ep,ev,re,r,rp)
	local tl=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	if tl==LOCATION_SZONE and re:IsActiveType(TYPE_SPELL) and ep~=tp then
		Duel.NegateEffect(ev)
	end
end
function c98710503.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x666)
end
function c98710503.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c98710503.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c98710503.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c98710503.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c98710503.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end