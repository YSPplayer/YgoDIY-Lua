--达姿的仪式 （ZCG）
function c98710553.initial_effect(c)
		   c:EnableReviveLimit()
		--special summon condition
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e0)
 --special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c98710553.spcon)
	e1:SetOperation(c98710553.spop)
	c:RegisterEffect(e1)
 --Cost Change
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_LPCOST_CHANGE)
	e7:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e7:SetRange(LOCATION_MZONE)
	e7:SetTargetRange(1,0)
	e7:SetValue(c98710553.costchange)
	c:RegisterEffect(e7)
	--immune spell
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetCode(EFFECT_IMMUNE_EFFECT)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetRange(LOCATION_MZONE)
	e11:SetValue(c98710553.efilter)
	c:RegisterEffect(e11)
  --spsummon
	local e9=Effect.CreateEffect(c)
	e9:SetDescription(aux.Stringid(98710553,0))
	e9:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e9:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e9:SetCode(EVENT_SPSUMMON_SUCCESS)
	e9:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e9:SetTarget(c98710553.sptg2)
	e9:SetOperation(c98710553.spop2)
	c:RegisterEffect(e9)
end
function c98710553.spcon1(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.CheckLPCost(c:GetControler(),500)
end
function c98710553.spop1(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.PayLPCost(tp,500)
end
function c98710553.filter(c,e,tp)
	return c:IsCode(98710510) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c98710553.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c98710553.filter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c98710553.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c98710553.filter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
	end
function c98710553.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c98710553.costchange(e,re,rp,val)
 if re then
		return 0
	else
		return val
	end
end
function c98710553.spfilter9(c,tp)
return c:IsType(TYPE_RITUAL) and c:IsAbleToGraveAsCost() and c:IsType(TYPE_SPELL)
end
function c98710553.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c98710553.spfilter9,tp,LOCATION_DECK,0,1,nil,tp,c) end
end
function c98710553.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c98710553.spfilter9,tp,LOCATION_DECK,0,1,1,nil,tp,c)
	Duel.SendtoGrave(g,REASON_COST)
end
