--殉道者的抉择（ZCG）
function c98710091.initial_effect(c)
	 --search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9982120,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c98710091.thtg2)
	e1:SetOperation(c98710091.thop2)
	c:RegisterEffect(e1)
--immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710091.efilter9)
	c:RegisterEffect(e13)
--disable
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_DISABLE)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetTargetRange(0,LOCATION_ONFIELD)
	e12:SetTarget(c98710091.distg9)
	c:RegisterEffect(e12)
end
function c98710091.distg9(e,c)
	return c:IsSetCard(0x666)
end
function c98710091.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x666)
end
function c98710091.thtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c98710091.filter1,tp,LOCATION_GRAVE,0,1,nil) and Duel.IsExistingTarget(c98710091.filter2,tp,LOCATION_GRAVE,0,1,nil) and Duel.IsExistingTarget(c98710091.filter3,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,3,tp,LOCATION_GRAVE)
end
function c98710091.filter1(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c98710091.filter2(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c98710091.filter3(c)
	return c:IsType(TYPE_TRAP) and c:IsAbleToHand()
end
function c98710091.thop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local t1=Duel.SelectMatchingCard(tp,c98710091.filter1,tp,LOCATION_GRAVE,0,1,1,nil)
	if not t1 then return end
	local t2=Duel.SelectMatchingCard(tp,c98710091.filter2,tp,LOCATION_GRAVE,0,1,1,nil)
	if not t2 then return end
	local t3=Duel.SelectMatchingCard(tp,c98710091.filter3,tp,LOCATION_GRAVE,0,1,1,nil)
	if not t3 then return end
	local g=Group.FromCards(t1,t2,t3)
	Duel.SendtoHand(g,nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_SKIP_DP)
	e1:SetTargetRange(1,0)
	if Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_DRAW then
		e1:SetReset(RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN,2)
	else
		e1:SetReset(RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN)
	end
	Duel.RegisterEffect(e1,tp)
end