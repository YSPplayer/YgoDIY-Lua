--奥利哈刚 达人僵尸 （ZCG）
function c98710418.initial_effect(c)
		 --Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98710418,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1)
	e1:SetTarget(c98710418.target)
	e1:SetOperation(c98710418.operation)
	c:RegisterEffect(e1)
	--atk limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e3:SetValue(c98710418.atlimit)
	c:RegisterEffect(e3)
end
function c98710418.atlimit(e,c)
	return c~=e:GetHandler()
end
function c98710418.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c98710418.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) and not Duel.IsExistingMatchingCard(c98710418.filter,tp,LOCATION_ONFIELD,0,1,nil) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
