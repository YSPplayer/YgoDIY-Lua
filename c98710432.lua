--奥利哈刚 圣母EX （ZCG）
function c98710432.initial_effect(c)
	  c:EnableReviveLimit()
	--special summon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c98710432.spcon)
	e2:SetOperation(c98710432.spop)
	c:RegisterEffect(e2)
  --atkup
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_UPDATE_ATTACK)
	e5:SetValue(c98710432.value)
	c:RegisterEffect(e5)
	--damage 0
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD)
	e10:SetCode(EFFECT_CHANGE_DAMAGE)
	e10:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e10:SetRange(LOCATION_MZONE)
	e10:SetTargetRange(1,0)
	e10:SetValue(c98710432.damval)
	c:RegisterEffect(e10)
	local e11=e10:Clone()
	e11:SetCode(EFFECT_NO_EFFECT_DAMAGE)
	c:RegisterEffect(e11)

		--immune effect
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_ONFIELD,0)
	e3:SetTarget(c98710432.etarget)
	e3:SetValue(c98710432.efilter)
	c:RegisterEffect(e3)
--copy
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e6:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCountLimit(1)
	e6:SetCondition(c98710432.coccon)
	e6:SetTarget(c98710432.cotg)
	e6:SetOperation(c98710432.coop)
	c:RegisterEffect(e6)
--copyMAX
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(98710432,2))
	e7:SetType(EFFECT_TYPE_IGNITION)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCountLimit(1)
	e7:SetCost(c98710432.spcost2)
	e7:SetOperation(c98710432.spop2)
	c:RegisterEffect(e7)

end
function c98710432.damval(e,re,val,r,rp,rc)
	if bit.band(r,REASON_EFFECT+REASON_BATTLE)~=0 then return 0 end
	return val
end
function c98710432.cffilter(c)
	return c:IsType(TYPE_MONSTER) and not c:IsPublic()
end
function c98710432.spcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98710432.cffilter,tp,LOCATION_DECK,0,1,nil) end
	local dg=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
	Duel.ConfirmCards(tp,dg)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c98710432.cffilter,tp,LOCATION_DECK,0,1,1,e:GetHandler())
	card98710432=g:GetFirst()
	Duel.ConfirmCards(1-tp,card98710432)
	Duel.ShuffleDeck(tp)
end
function c98710432.spop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local code=card98710432:GetOriginalCode()
		c:CopyEffect(code,RESET_EVENT+RESETS_STANDARD)
end
function c98710432.coccon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c98710432.cotg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c98710432.coop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,98710433,0,TYPES_TOKEN_MONSTER,0,2500,4,RACE_FAIRY,ATTRIBUTE_LIGHT) then return end
	local token=Duel.CreateToken(tp,98710433)
	if Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)~=0 then
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c98710432.atlimit)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD)
	token:RegisterEffect(e1)
end
end
function c98710432.atlimit(e,c)
	return c~=e:GetHandler()
end
function c98710432.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x666)
end
function c98710432.value(e,c)
	return Duel.GetMatchingGroupCount(c98710432.filter,0,LOCATION_MZONE,LOCATION_MZONE,nil)*1000
end
function c98710432.etarget(e,c)
	return c:IsSetCard(0x666) and c:IsType(TYPE_MONSTER)
end
function c98710432.efilter(e,re)
	return re:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c98710432.spfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x666) and c:IsAbleToGraveAsCost()
end
function c98710432.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c98710432.spfilter,c:GetControler(),LOCATION_MZONE,0,3,c)
end
function c98710432.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c98710432.spfilter,tp,LOCATION_MZONE,0,3,3,c)
	Duel.SendtoGrave(g,REASON_COST)
end