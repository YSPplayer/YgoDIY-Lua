--六芒星 龙父 (ZCG)
function c98710303.initial_effect(c)
	 --destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(98710303,0))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCost(c98710303.descost)
	e3:SetTarget(c98710303.destg)
	e3:SetOperation(c98710303.desop)
	c:RegisterEffect(e3)
end
function c98710303.filter(c)
return c:IsSetCard(0x6551) and c:IsType(TYPE_MONSTER) and c:IsDiscardable()
end
function c98710303.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98710303.filter,tp,LOCATION_HAND,0,1,nil) end
	local sg=Duel.GetTargetCount(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	local ct=Duel.DiscardHand(tp,c98710303.filter,1,sg,REASON_COST+REASON_DISCARD)
	e:SetLabel(ct) 
end
function c98710303.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local number=e:GetLabel()
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,number,number,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c98710303.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local dg=g:Filter(Card.IsRelateToEffect,nil,e)
	Duel.Destroy(dg,REASON_EFFECT)
	--local tc=Duel.GetFirstTarget()
   -- if tc:IsRelateToEffect(e) then
	  --  Duel.Destroy(tc,REASON_EFFECT)
  --  end
end
