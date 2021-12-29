--六芒星 龙狂士 （ZCG）
function c98710305.initial_effect(c)
	 --special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c98710305.spcon)
	e1:SetOperation(c98710305.spop)
	c:RegisterEffect(e1) 
   --spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98710305,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c98710305.spcost)
	e2:SetTarget(c98710305.sptg)
	e2:SetOperation(c98710305.spop2)
	c:RegisterEffect(e2)
 --indes
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_FIELD)
	e9:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e9:SetRange(LOCATION_MZONE)
	e9:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
	e9:SetTarget(c98710305.infilter)
	e9:SetValue(1)
	c:RegisterEffect(e9)
	local e11=e9:Clone()
	e11:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	c:RegisterEffect(e11)
end
function c98710305.infilter(e,c)
	return bit.band(c:GetType(),TYPE_SPELL+TYPE_CONTINUOUS)==TYPE_SPELL+TYPE_CONTINUOUS
end
function c98710305.cfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c98710305.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98710305.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c98710305.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c98710305.filter(c,e,tp)
	return c:IsSetCard(0x6551) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c98710305.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c98710305.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c98710305.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c98710305.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c98710305.ifliter(c)
return c:IsFaceup() and c:IsType(TYPE_SPELL)
end
function c98710305.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c98710305.ifliter,c:GetControler(),LOCATION_SZONE,0,1,nil)
end
function c98710305.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetValue(1450)
	e1:SetReset(RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SET_BASE_DEFENSE)
	e2:SetValue(1000)
	e2:SetReset(RESET_PHASE+PHASE_END)
	c:RegisterEffect(e2)
end