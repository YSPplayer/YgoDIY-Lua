--七彩幻界植物女王 (ZCG)
function c98710683.initial_effect(c)
	  --cannot be battle target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetValue(c98710683.atktg)
	c:RegisterEffect(e2)
  --destroy replace
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_DESTROY_REPLACE)
	e4:SetTarget(c98710683.reptg)
	c:RegisterEffect(e4)
   --spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98710683,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c98710683.spcost)
	e1:SetTarget(c98710683.sptg)
	e1:SetOperation(c98710683.spop)
	c:RegisterEffect(e1)
end
function c98710683.filter(c,e,tp)
	return c:IsSetCard(0x87c2) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsLevelBelow(6)
end
function c98710683.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
 if chk==0 then return true end
  local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c98710683.atktg2)
	e1:SetReset(RESET_EVENT+RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c98710683.atktg2(e,c)
	return c:IsType(TYPE_MONSTER)
end
function c98710683.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c98710683.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c98710683.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c98710683.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end

function c98710683.atktg(e,c)
	return c:IsFaceup() and not c:IsCode(98710683) and c:IsSetCard(0x87c2)
end
function c98710683.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReason(REASON_BATTLE+REASON_EFFECT) and not c:IsReason(REASON_REPLACE)
		and Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_SZONE,0,1,nil) end
	if Duel.SelectYesNo(tp,aux.Stringid(98710683,0)) then 
		local g=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,LOCATION_SZONE,0,e:GetHandler())
		Duel.SendtoGrave(g,REASON_EFFECT+REASON_REPLACE)
		return true
	else return false end
end