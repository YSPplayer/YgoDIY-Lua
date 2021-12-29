--植物の愤怒 魔巨树 （ZCG）
function c98710678.initial_effect(c)
	  --special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c98710678.spcon)
	e1:SetOperation(c98710678.spop)
end
function c98710678.spfilter(c)
	return c:IsCode(98710653) and c:IsAbleToRemoveAsCost()
end
function c98710678.spcon(e,c)
 if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c98710678.spfilter,tp,LOCATION_GRAVE,0,1,nil)
end
function c98710678.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c98710678.spfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end