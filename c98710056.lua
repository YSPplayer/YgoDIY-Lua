--殉道者 领域领主（ZCG）
local m=98710056
local cm=_G["c"..m]
function c98710056.initial_effect(c)
	 --destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(m,0))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e3:SetTarget(cm.destg)
	e3:SetOperation(cm.desop)
	c:RegisterEffect(e3)
--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(m,1))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e3:SetTarget(cm.destg2)
	e3:SetOperation(cm.desop2)
	c:RegisterEffect(e3)
--immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(cm.efilter9)
	c:RegisterEffect(e13)
--disable
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_DISABLE)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetTargetRange(0,LOCATION_ONFIELD)
	e12:SetTarget(cm.distg9)
	c:RegisterEffect(e12)
end
function cm.distg9(e,c)
	return c:IsSetCard(0x666)
end
function cm.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x666)
end
function cm.desfilter(c,attr)
	return c:IsAttribute(attr)
end
function cm.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_DECK,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTRIBUTE)
	local at=Duel.AnnounceAttribute(tp,1,ATTRIBUTE_ALL)
	e:SetLabel(at)
	local dg=Duel.GetMatchingGroup(cm.desfilter,tp,0,LOCATION_DECK,nil,at)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,dg,dg:GetCount(),0,0)
end
function cm.desop(e,tp,eg,ep,ev,re,r,rp)
	local attr=e:GetLabel()
	local dg=Duel.GetMatchingGroup(cm.desfilter,tp,0,LOCATION_DECK,nil,attr)
	if dg:GetCount()>0 then
		Duel.Remove(dg,POS_FACEUP,REASON_EFFECT)
	end
end
function cm.desfilter2(c,race)
	return c:IsRace(race)
end
function cm.destg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_DECK,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RACE)
	local rc=Duel.AnnounceRace(tp,1,RACE_ALL)
	e:SetLabel(rc)
	local dg=Duel.GetMatchingGroup(cm.desfilter2,tp,0,LOCATION_DECK,nil,rc)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,dg,dg:GetCount(),0,0)
end
function cm.desop2(e,tp,eg,ep,ev,re,r,rp)
	local race=e:GetLabel()
	local dg=Duel.GetMatchingGroup(cm.desfilter2,tp,0,LOCATION_DECK,nil,race)
	if dg:GetCount()>0 then
		Duel.Remove(dg,POS_FACEUP,REASON_EFFECT)
	end
end