--
function c98710534.initial_effect(c)
	c:EnableCounterPermit(0x557)
		c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetOperation(c98710534.sucop)
	c:RegisterEffect(e4)
	--attack cost
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_ATTACK_COST)
	e6:SetCost(c98710534.atcost)
	e6:SetOperation(c98710534.atop)
	c:RegisterEffect(e6)
--disim
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98710534,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c98710534.discost)
	e2:SetOperation(c98710534.imop)
	c:RegisterEffect(e2)
	local e0=Effect.CreateEffect(c)  
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)  
	e0:SetRange(LOCATION_MZONE)
	e0:SetCode(1040)
	e0:SetTarget(c98710534.target)
	e0:SetOperation(c98710534.activate) 
	c:RegisterEffect(e0) 
   --draw
	local e9=Effect.CreateEffect(c)
	e9:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e9:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e9:SetRange(LOCATION_MZONE)
	e9:SetCountLimit(1)
	e9:SetCode(EVENT_PHASE+PHASE_END)
	e9:SetCondition(c98710534.condition2)
	e9:SetOperation(c98710534.operation2)
	c:RegisterEffect(e9)
 --win
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e10:SetCode(EVENT_ADJUST)
	e10:SetRange(LOCATION_MZONE)
	e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e10:SetOperation(c98710534.winop)
	c:RegisterEffect(e10)
end
function c98710534.winop(e,tp,eg,ep,ev,re,r,rp)
	local WIN_REASON_DESTINY_LEO=0x514
	local c=e:GetHandler()
	if c:GetCounter(0x557)==4 then
		Duel.Win(tp,WIN_REASON_DESTINY_LEO)
	end
end
function c98710534.condition2(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c98710534.operation2(e,tp,eg,ep,ev,re,r,rp)
		  e:GetHandler():AddCounter(0x557,1)
end
function c98710534.atcost(e,c,tp)
	local ct=Duel.GetFlagEffect(tp,98710534)
	return Duel.IsPlayerCanDiscardDeckAsCost(tp,ct)
end
function c98710534.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(tp,10,REASON_COST)
end
function c98710534.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
end
function c98710534.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		while tc do
			local atk=tc:GetBaseAttack()
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			e1:SetValue(atk)
			tc:RegisterEffect(e1)
			tc=g:GetNext()
		end
	end
end

function c98710534.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
		return g:GetCount()>0 and g:FilterCount(Card.IsDiscardable,nil)==g:GetCount()
	end
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoGrave(g,REASON_COST+REASON_DISCARD)
end
function c98710534.imop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_IMMUNE_EFFECT)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetReset(RESET_EVENT+RESETS_STANDARD)
	e5:SetValue(c98710534.efilter)
	c:RegisterEffect(e5)
end
function c98710534.efilter(e,re)
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer()
end
function c98710534.sucop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_LOSE_KOISHI)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_ONFIELD)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e:GetHandler():RegisterEffect(e1)
	Duel.SetLP(tp,0)
end