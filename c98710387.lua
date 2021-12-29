--奥西里斯的制裁 （ZCG）
function c98710387.initial_effect(c)
		   --activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
--Destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(98710387,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCost(c98710387.discost)
	e3:SetTarget(c98710387.destg)
	e3:SetOperation(c98710387.desop)
	c:RegisterEffect(e3)
--Destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(98710387,1))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetCategory(CATEGORY_HANDES)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCost(c98710387.discost)
	e4:SetTarget(c98710387.target)
	e4:SetOperation(c98710387.activate)
	c:RegisterEffect(e4)
end
function c98710387.cfilter(c)
	return c:IsType(TYPE_MONSTER)
end
function c98710387.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c98710387.cfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c98710387.cfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c98710387.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>1 end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,1-tp,1)
end
function c98710387.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetFieldGroup(p,0,LOCATION_HAND)
	if g:GetCount()>0 then
		local sg=Duel.SelectMatchingCard(p,aux.TRUE,p,0,LOCATION_HAND,2,2,nil)
		Duel.SendtoGrave(sg,REASON_EFFECT)
	 end
end
function c98710387.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_ONFIELD,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,2,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c98710387.desfilter(c,e,tp)
return c:IsLocation(LOCATION_GRAVE) and c:IsType(TYPE_MONSTER)
	-- and c:IsCanBeSpecialSummoned(true,true) 
end
function c98710387.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local dg=g:Filter(Card.IsRelateToEffect,nil,e)
		if Duel.Destroy(dg,REASON_EFFECT)~=0 then
		local g=Duel.GetOperatedGroup()
		local g2=g:Filter(c98710387.desfilter,nil)
		local ct=Duel.GetLocationCount(tp,LOCATION_MZONE)
		if g2:GetCount()<=ct then
		if g2:GetCount()>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
		local tc=g2:GetFirst()
		while tc do
			if tc:IsType(TYPE_MONSTER) then 
			Duel.SpecialSummonStep(tc,0,tp,tp,true,true,POS_FACEUP)
			tc=g:GetNext()
			else
			tc=g:GetNext()
		end
		Duel.SpecialSummonComplete()
	end
end
end
end