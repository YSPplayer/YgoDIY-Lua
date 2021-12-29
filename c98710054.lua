--殉道者 地狱主导者
function c98710054.initial_effect(c)
	 c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e1:SetTargetRange(POS_FACEUP,0)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c98710054.spcon)
	e1:SetOperation(c98710054.spop)
	c:RegisterEffect(e1)
 --atk/def
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_UPDATE_ATTACK)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetRange(LOCATION_MZONE)
	e6:SetValue(c98710054.adval)
	c:RegisterEffect(e6)
--immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710054.efilter9)
	c:RegisterEffect(e13)
--disable
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_DISABLE)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetTargetRange(0,LOCATION_ONFIELD)
	e12:SetTarget(c98710054.distg9)
	c:RegisterEffect(e12)
end
function c98710054.distg9(e,c)
	return c:IsSetCard(0x666)
end
function c98710054.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x666)
end
function c98710054.filter(c)
	return c:GetSequence()<5 and c:IsAbleToGraveAsCost()
end
function c98710054.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c98710054.filter,c:GetControler(),LOCATION_SZONE,0,1,nil)
end
function c98710054.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c98710054.filter,tp,LOCATION_SZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c98710054.adval(e,c)
	return Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_HAND)*1000
end