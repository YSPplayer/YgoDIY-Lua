--达姿的第二仪式 （ZCG）
function c98710511.initial_effect(c)
  --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CANNOT_INACTIVATE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c98710511.cost)
	e1:SetTarget(c98710511.target)
	e1:SetOperation(c98710511.activate)
	c:RegisterEffect(e1)
end
function c98710511.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,Duel.GetLP(tp)-1) end
	Duel.PayLPCost(tp,Duel.GetLP(tp)-1)
end
function c98710511.filter(c,e,tp)
	return c:IsCode(98710512) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,true,true)
end
function c98710511.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98710511.filter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil,e,tp) and Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_MZONE,0)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED)
end
function c98710511.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c98710511.filter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if not tc then return end 
	if Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_MZONE,0)<=0 then return end
	if Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,true,true,POS_FACEUP)~=0 then
		Duel.BreakEffect()
		e:GetHandler():CancelToGrave()
		Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)
		Duel.ShuffleHand(e:GetHandler():GetControler())
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	--e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	--e1:SetCondition(c98710511.wincon)
	e1:SetOperation(c98710511.winop)
	e:GetHandler():RegisterEffect(e1)
	end
end
function c98710511.filter1(c)
return c:IsCode(98710513)
end
function c98710511.filter2(c)
return c:IsCode(98710446)
end
function c98710511.filter3(c)
return c:IsCode(98710510)
end
function c98710511.filter4(c)
return c:IsCode(98710512)
end
function c98710511.filter5(c)
return c:IsCode(98710511)
end
function c98710511.check(g)
	local a1=false
	local a2=false
	local a3=false
	local a4=false
	local a5=false
	local tc=g:GetFirst()
	while tc do
		local code=tc:GetCode()
		if code==98710513 then a1=true
		elseif code==98710446 then a2=true
		elseif code==98710510 then a3=true
		elseif code==98710512 then a4=true
		elseif code==98710511 then a5=true
		end
		tc=g:GetNext()
	end
	return a1 and a2 and a3 and a4 and a5
end
function c98710511.wincon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c98710511.filter1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_ONFIELD,0,1,nil) and Duel.IsExistingMatchingCard(c98710511.filter2,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_ONFIELD,0,1,nil) and Duel.IsExistingMatchingCard(c98710511.filter3,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_ONFIELD,0,1,nil) and Duel.IsExistingMatchingCard(c98710511.filter4,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_ONFIELD,0,1,nil) and Duel.IsExistingMatchingCard(c98710511.filter5,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_ONFIELD,0,1,nil)
end
function c98710511.winop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Win(tp,0x506)
end
--end

 --local g=Duel.GetFieldGroup(tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_ONFIELD,0)
  --  local wtp=c98710511.check(g)
  --  if wtp then


