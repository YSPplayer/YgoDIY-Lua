--奥西里斯之寄生面具 （ZCG）
function c98710331.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetTarget(c98710331.ntcon)
	e1:SetTarget(c98710331.target)
	e1:SetOperation(c98710331.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_SUMMON_PROC)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c98710331.ntcon2)
	e3:SetValue(SUMMON_TYPE_NORMAL)
	c:RegisterEffect(e3)
	e1:SetLabelObject(e3)
  --disable effect
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e12:SetCode(EVENT_CHAIN_SOLVING)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetOperation(c98710331.disop9)
	c:RegisterEffect(e12)
 --immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710331.efilter9)
	c:RegisterEffect(e13)
end
function c98710331.disop9(e,tp,eg,ep,ev,re,r,rp)
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
function c98710331.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x70c1)
end
function c98710331.ntcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c98710331.filter(c,se)
	if not c:IsSummonableCard() then return false end
	local mi,ma=c:GetTributeRequirement()
	return mi>0 and (c:IsSummonable(true,se) or c:IsMSetable(true,se))
end
function c98710331.get_targets(se,tp)
	local g=Duel.GetMatchingGroup(c98710331.filter,tp,LOCATION_HAND,0,nil,se)
	local minct=5
	local maxct=0
	local tc=g:GetFirst()
	while tc do
		local mi,ma=tc:GetTributeRequirement()
		if mi>0 and mi<minct then minct=mi end
		if ma>maxct then maxct=ma end
		tc=g:GetNext()
	end
	return minct,maxct
end
function c98710331.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local se=e:GetLabelObject()
	if chk==0 then
		local mi,ma=c98710331.get_targets(se,tp)
		if mi==5 then return false end
		return Duel.CheckLPCost(tp,mi*0)
	end
	local mi,ma=c98710331.get_targets(se,tp)
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c98710331.ntcon2(e,c,minc)
	if c==nil then return true end
	return minc==0 and Duel.CheckTribute(c,0)
end
function c98710331.sfilter(c,se,ct)
	if not c:IsSummonableCard() then return false end
	local mi,ma=c:GetTributeRequirement()
	return (mi~=ct and ma~=ct) and (c:IsSummonable(true,se) or c:IsMSetable(true,se))
end
function c98710331.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local ct=e:GetLabel()
	local se=e:GetLabelObject()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,c98710331.sfilter,tp,LOCATION_HAND,0,1,1,nil,se,ct)
	local tc=g:GetFirst()
	if tc then
		local s1=tc:IsSummonable(true,se)
		local s2=tc:IsMSetable(true,se)
		if (s1 and s2 and Duel.SelectPosition(tp,tc,POS_FACEUP_ATTACK+POS_FACEDOWN_DEFENSE)==POS_FACEUP_ATTACK) or not s2 then
			Duel.Summon(tp,tc,true,se)
		else
			Duel.MSet(tp,tc,true,se)
		end
	end
end