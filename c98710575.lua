--奥利哈刚 托利托斯 （ZCG）
function c98710575.initial_effect(c)
	 --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98710442,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c98710575.condition)
	e1:SetOperation(c98710575.moop)
	c:RegisterEffect(e1)
		--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98710442,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c98710575.condition)
	e2:SetTarget(c98710575.motg)
	e2:SetOperation(c98710575.moop2)
	c:RegisterEffect(e2)
	--selfdes
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_ADJUST)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCondition(c98710575.sdcon2)
	e4:SetOperation(c98710575.sdop)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_IMMUNE_EFFECT)
	e5:SetRange(LOCATION_ONFIELD)
	e5:SetTargetRange(LOCATION_MZONE,0)
	e5:SetValue(c98710575.efilter)
	c:RegisterEffect(e5)
	--indes
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetRange(LOCATION_ONFIELD)
	e6:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e6:SetValue(1)
	c:RegisterEffect(e6)
	local e7=e6:Clone()
	e7:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e7)
 --cannot trigger
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_FIELD)
	e8:SetCode(EFFECT_CANNOT_TRIGGER)
	e8:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e8:SetRange(LOCATION_ONFIELD)
	e8:SetTargetRange(0,0xa)
	e8:SetTarget(c98710575.distg)
	c:RegisterEffect(e8)
end
function c98710575.distg(e,c)
	return c:IsType(TYPE_SPELL)
end
function c98710575.efilter(e,re)
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer() and re:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
function c98710575.sdcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(98710442)==0
end
function c98710575.sdop(e,tp,eg,ep,ev,re,r,rp) 
	e:GetHandler():CopyEffect(98710441,RESET_EVENT+0x1fe0000)
	e:GetHandler():RegisterFlagEffect(98710442,RESET_EVENT+0x1fe0000,0,1)
end
function c98710575.cfilter(c)
	return c:IsFaceup() and c:IsCode(98710441)
end
function c98710575.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c98710575.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c98710575.motg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return (Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_SZONE,0)>0 and Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)~=nil) or (Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_SZONE,0)>1 and Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)==nil) end
end
function c98710575.moop(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	Duel.MoveToField(c,tp,tp,LOCATION_FZONE,POS_FACEUP,true)
end
function c98710575.moop2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if (Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_SZONE,0)>0 and Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)~=nil) or (Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_SZONE,0)>1 and Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)==nil) then
	Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
end
end