--六芒星的水祭 （ZCG）
function c98710323.initial_effect(c)
	 --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c98710323.condition)
	e1:SetTarget(c98710323.target)
	e1:SetOperation(c98710323.operation)
	c:RegisterEffect(e1)
end
function c98710323.cfilter(c,tp)
	return c:IsType(TYPE_MONSTER) and c:IsReason(REASON_DESTROY) and c:IsPreviousControler(tp) 
end
function c98710323.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c98710323.cfilter,1,nil,tp)
end
function c98710323.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
 if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,PLAYER_ALL,LOCATION_MZONE)
end
function c98710323.filter(c,e,tp)
	return c:IsCode(98710313)
  -- and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP)
end
function c98710323.operation(e,tp,eg,ep,ev,re,r,rp)
 Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToGrave,tp,0,LOCATION_MZONE,1,1,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e2:SetValue(ATTRIBUTE_WATER)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e2)
		Duel.HintSelection(g)
	   if Duel.SendtoGrave(g,REASON_COST)~=0 then
	   Duel.BreakEffect()
	   if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end   
	   if Duel.IsExistingMatchingCard(c98710323.filter,tp,LOCATION_HAND,0,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(98710323,1)) then
	   local g=Duel.SelectMatchingCard(tp,c98710323.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	   if g:GetCount()>0 then
	   Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
	end
	end
	end
end