--殉道者 地狱战神（ZCG）
function c98710044.initial_effect(c)
	--cannot direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetRange(LOCATION_DECK)
	e2:SetCondition(c98710044.spcon)
	c:RegisterEffect(e2)
 --search
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_POSITION)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetTarget(c98710044.target)
	e3:SetOperation(c98710044.operation)
	c:RegisterEffect(e3)
--immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710044.efilter9)
	c:RegisterEffect(e13)
--disable
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_DISABLE)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetTargetRange(0,LOCATION_ONFIELD)
	e12:SetTarget(c98710044.distg9)
	c:RegisterEffect(e12)
end
function c98710044.distg9(e,c)
	return c:IsSetCard(0x666)
end
function c98710044.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x666)
end
function c98710044.spcon(e,c,minc)
	if c==nil then return true end
	return Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_MZONE)>=3 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c98710044.filter(c)
	return not c:IsPosition(POS_FACEUP_DEFENSE) and c:IsCanChangePosition()
end
function c98710044.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98710044.filter,tp,0,LOCATION_MZONE,1,nil) end
end
function c98710044.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c98710044.filter,tp,0,LOCATION_MZONE,nil)
	Duel.ChangePosition(g,POS_FACEUP_DEFENSE,POS_FACEUP_DEFENSE,POS_FACEUP_DEFENSE,POS_FACEUP_DEFENSE)
end