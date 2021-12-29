--植物の愤怒 南瓜蛛 （ZCG）
function c98710676.initial_effect(c)
   --tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98710676,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetTarget(c98710676.target)
	e1:SetOperation(c98710676.operation)
	c:RegisterEffect(e1)
--indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98710676,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetCondition(c98710676.con)
	e2:SetCost(c98710676.cost)
	e2:SetOperation(c98710676.op)
	c:RegisterEffect(e2)
end
function c98710676.con(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return d and ((a:GetControler()==tp and a:IsSetCard(0x87c2)) or (d:GetControler()==tp and d:IsSetCard(0x87c2)))
		and Duel.GetFlagEffect(tp,98710676)==0
end
function c98710676.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
	Duel.RegisterFlagEffect(tp,98710676,RESET_PHASE+PHASE_DAMAGE_CAL,0,1)
end
function c98710676.op(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not a:IsRelateToBattle() or not d:IsRelateToBattle() then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetOwnerPlayer(tp)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetValue(1500)
	if a:GetControler()==tp then
		a:RegisterEffect(e1)
	else
		d:RegisterEffect(e1)
	end
end
function c98710676.filter(c)
	return c:IsCode(98710674) and c:IsAbleToHand()
end
function c98710676.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98710676.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c98710676.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c98710676.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
