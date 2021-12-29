--殉道者的毁灭一击（ZCG）
function c98710095.initial_effect(c)
	  --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
 --damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98710095,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c98710095.cost)
	e2:SetTarget(c98710095.target)
	e2:SetOperation(c98710095.activate)
	c:RegisterEffect(e2)
--immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710095.efilter9)
	c:RegisterEffect(e13)
--disable
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_DISABLE)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetTargetRange(0,LOCATION_ONFIELD)
	e12:SetTarget(c98710095.distg9)
	c:RegisterEffect(e12)
end
function c98710095.distg9(e,c)
	return c:IsSetCard(0x666)
end
function c98710095.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x666)
end
function c98710095.cfilter(c,ft,tp)
	return c:IsSetCard(0x70c1)
		and (ft>0 or (c:IsControler(tp) and c:GetSequence()<5)) and (c:IsControler(tp) or c:IsFaceup())
end
function c98710095.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then return ft>-1 and Duel.CheckReleaseGroup(tp,c98710095.cfilter,1,nil,ft,tp) end
	local rg=Duel.SelectReleaseGroup(tp,c98710095.cfilter,1,1,nil,ft,tp)
	Duel.Release(rg,REASON_COST)
end
function c98710095.filter(c)
	return c:IsAbleToHand()
end
function c98710095.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return (chkc:IsLocation(LOCATION_GRAVE) or  chkc:IsLocation(LOCATION_HAND)) and c98710095.filter(chkc) end
	if chk==0 then return (Duel.IsExistingTarget(c98710095.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil) or Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)~=0 ) end
	local opt=Duel.SelectOption(tp,aux.Stringid(98710095,1),aux.Stringid(98710095,2))
	e:SetLabel(opt)
	if opt==0 then
	 Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	 Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,tc,1,0,0)
	 local g=Duel.SelectTarget(tp,c98710095.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil)
	 Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
	else
   return true end
end
function c98710095.activate(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0  then 
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
 else
   local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()>0 then
		Duel.ConfirmCards(tp,g)
		local tg=g:Filter(Card.IsType,nil,TYPE_MONSTER+TYPE_SPELL+TYPE_TRAP)
		if tg:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local sg=tg:Select(tp,1,1,nil)
			Duel.SendtoHand(sg,tp,REASON_EFFECT)
		end
		Duel.ShuffleHand(1-tp)
	end
end
end