--太阳神的引导者 （ZCG）
function c98710684.initial_effect(c)
	   --draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98710684,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetCondition(c98710684.drcon)
	e1:SetTarget(c98710684.drtg)
	e1:SetOperation(c98710684.drop)
	c:RegisterEffect(e1)
end
function c98710684.drcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsReason(REASON_EFFECT) and c:IsReason(REASON_DESTROY) and c:IsLocation(LOCATION_GRAVE) then
		return true
	else return false end
end
function c98710684.filter(c,e,tp)
	return c:IsSetCard(0x7c31) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c98710684.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c98710684.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c98710684.drop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c98710684.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end