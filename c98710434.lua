--奥利哈刚 黑魔导女孩 （ZCG）
function c98710434.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c98710434.atkval)
	c:RegisterEffect(e1)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(98710434,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCondition(c98710434.spcon)
	e3:SetCost(c98710434.cost)
	e3:SetTarget(c98710434.target)
	e3:SetOperation(c98710434.operation)
	c:RegisterEffect(e3)
 --damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98710434,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetCondition(c98710434.dmcon)
	e2:SetTarget(c98710434.dmtg)
	e2:SetOperation(c98710434.dmop)
	c:RegisterEffect(e2)
end
function c98710434.dmcon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsReason(REASON_BATTLE) and rp==1-tp
end
function c98710434.dmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,e:GetHandler():GetControler(),0,LOCATION_ONFIELD,1,nil) end
end
function c98710434.dmop(e,tp,eg,ep,ev,re,r,rp)
		local g=Duel.SelectMatchingCard(e:GetHandler():GetControler(),aux.TRUE,e:GetHandler():GetControler(),0,LOCATION_ONFIELD,1,1,nil)
		if #g>0 then
		Duel.Destroy(g,REASON_EFFECT+REASON_RULE)
	end 
end
function c98710434.atkfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x666) and c:IsRace(RACE_SPELLCASTER)
end
function c98710434.atkval(e,c)
	return Duel.GetMatchingGroupCount(c98710434.atkfilter,c:GetControler(),LOCATION_GRAVE,LOCATION_GRAVE,nil)*1000
end
function c98710434.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c98710434.cfilter(c)
	return c:IsSetCard(0x666) and c:IsType(TYPE_MONSTER) and c:IsRace(RACE_SPELLCASTER) and c:IsAbleToRemoveAsCost()
end
function c98710434.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98710434.cfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c98710434.cfilter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c98710434.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c98710434.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end