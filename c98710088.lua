--殉道者之异次元穿越（ZCG）
function c98710088.initial_effect(c)
	 --Activate(summon)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c98710088.condition)
	e1:SetTarget(c98710088.target)
	e1:SetOperation(c98710088.activate)
	c:RegisterEffect(e1)
--immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710088.efilter9)
	c:RegisterEffect(e13)
--disable
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_DISABLE)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetTargetRange(0,LOCATION_ONFIELD)
	e12:SetTarget(c98710088.distg9)
	c:RegisterEffect(e12)
end
function c98710088.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp
end
function c98710088.distg9(e,c)
	return c:IsSetCard(0x666)
end
function c98710088.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x666)
end
function c98710088.filter(c,lv)
	return c:IsLevel(lv+2) and c:IsType(TYPE_MONSTER) and c:IsLevelBelow(12)
end
function c98710088.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98710088.filter,tp,LOCATION_DECK,0,1,nil,eg:GetFirst():GetLevel()) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c98710088.activate(e,tp,eg,ep,ev,re,r,rp)
	 if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	 Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	 local g=Duel.SelectMatchingCard(tp,c98710088.filter,tp,LOCATION_DECK,0,1,1,nil,eg:GetFirst():GetLevel(),tp)
	 if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	end
end