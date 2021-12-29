--奥利哈刚 万蛇灵 （ZCG）
function c98710429.initial_effect(c)
	 --spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98710429,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c98710429.spcost)
	e1:SetTarget(c98710429.sptg)
	e1:SetOperation(c98710429.spop)
	c:RegisterEffect(e1)
end
function c98710429.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
 if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
  Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c98710429.filter(c,e,tp)
	return c:IsCode(98710430) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c98710429.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c98710429.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c98710429.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c98710429.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		if Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)~=0 then
			Duel.BreakEffect()
			Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
		end
	end
end
