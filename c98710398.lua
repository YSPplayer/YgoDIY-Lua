--奥利哈刚 欧墨尼得 （ZCG）
function c98710398.initial_effect(c)
	--battle indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCountLimit(1)
	e1:SetValue(c98710398.valcon)
	c:RegisterEffect(e1)
  --battle
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
--Special Summon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(98710398,0))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCost(c98710398.cost)
	e4:SetTarget(c98710398.target)
	e4:SetOperation(c98710398.operation)
	c:RegisterEffect(e4)
end
function c98710398.cfilter(c)
	return c:IsSetCard(0x666) and c:IsAbleToGraveAsCost() and c:IsType(TYPE_MONSTER)
end
function c98710398.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98710398.cfilter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c98710398.cfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c98710398.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c98710398.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
function c98710398.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0
end
