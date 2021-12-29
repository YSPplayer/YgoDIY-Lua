--六芒星碎片 （ZCG）
function c98710322.initial_effect(c)
	 --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c98710322.con)
	e1:SetTarget(c98710322.tg)
	e1:SetOperation(c98710322.op)
	c:RegisterEffect(e1)
end
function c98710322.cfilter(c,tp)
	return c:IsReason(REASON_BATTLE) and c:IsPreviousControler(tp) and c:IsSetCard(0x6551) and c:IsPreviousLocation(LOCATION_MZONE) 
end
function c98710322.con(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c98710322.cfilter,1,nil,tp)
end
function c98710322.filter(c,e,tp)
	return c:IsSetCard(0x6551) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c98710322.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local ht=Duel.GetMatchingGroupCount(c98710322.filter,tp,LOCATION_HAND,0,nil)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c98710322.filter,tp,LOCATION_HAND,0,1,nil,e,tp) and ft>=ht end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c98710322.op(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local ht=Duel.GetMatchingGroupCount(c98710322.filter,tp,LOCATION_HAND,0,nil)
	if ft<=0 or ht>ft then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c98710322.filter,tp,LOCATION_HAND,0,ft,ft,nil,e,tp)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		while tc do
			Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
			tc=g:GetNext()
		end
	   Duel.SpecialSummonComplete()
	end
end
