--殉道者之回转（ZCG）
function c98710069.initial_effect(c)
	  --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c98710069.target)
	e1:SetOperation(c98710069.activate)
	c:RegisterEffect(e1)
--immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710069.efilter9)
	c:RegisterEffect(e13)
--disable
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_DISABLE)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetTargetRange(0,LOCATION_ONFIELD)
	e12:SetTarget(c98710069.distg9)
	c:RegisterEffect(e12)
end
function c98710069.distg9(e,c)
	return c:IsSetCard(0x666)
end
function c98710069.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x666)
end
function c98710069.filter(c)
	return c:IsSetCard(0x70c1) and c:IsAbleToDeck()
end
function c98710069.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	   if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c98710069.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c98710069.filter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c98710069.filter,tp,LOCATION_GRAVE,0,1,99,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,g:GetCount()*1000)
end
function c98710069.activate(e,tp,eg,ep,ev,re,r,rp)
  local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local ct=Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	if ct>0 then
		Duel.Recover(tp,ct*1000,REASON_EFFECT)
	end
end
