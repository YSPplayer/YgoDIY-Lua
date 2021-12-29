--奥利哈刚 不灭阶段 （ZCG）
function c98710583.initial_effect(c)
	   --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98710519,1))
	e2:SetCategory(CATEGORY_TOGRAVE+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetTarget(c98710583.sptg)
	e2:SetOperation(c98710583.spop)
	c:RegisterEffect(e2)
end
function c98710583.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsLevelAbove(8) and c:IsType(TYPE_MONSTER)
end
function c98710583.thfilter(c)
return c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function c98710583.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then
		local b=false
		if ft>0 then
			b=Duel.IsExistingTarget(c98710583.thfilter,tp,LOCATION_ONFIELD,0,1,nil)
		else
			b=Duel.IsExistingTarget(c98710583.thfilter,tp,LOCATION_MZONE,0,1,nil)
		end
		return b and Duel.IsExistingTarget(c98710583.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp)
	end
	local g1=nil
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	if ft>0 then
		g1=Duel.SelectTarget(tp,c98710583.thfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	else
		g1=Duel.SelectTarget(tp,c98710583.thfilter,tp,LOCATION_MZONE,0,1,1,nil)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectTarget(tp,c98710583.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g1,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g2,1,0,0)
	e:SetLabelObject(g1:GetFirst())
end
function c98710583.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc1,tc2=Duel.GetFirstTarget()
	if tc1~=e:GetLabelObject() then tc1,tc2=tc2,tc1 end
	if tc1:IsRelateToEffect(e) and Duel.SendtoGrave(tc1,REASON_EFFECT)>0
		and tc1:IsLocation(LOCATION_GRAVE) and tc2:IsRelateToEffect(e)
		and aux.NecroValleyFilter()(tc2) then
		Duel.SpecialSummon(tc2,0,tp,tp,false,false,POS_FACEUP)
	end
end
