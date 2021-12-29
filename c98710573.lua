--奥利哈刚的结界 （ZCG）
function c98710573.initial_effect(c)
	 --Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)  
	e1:SetType(EFFECT_TYPE_FIELD)  
	e1:SetTargetRange(LOCATION_MZONE,0)  
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE)
	e1:SetRange(LOCATION_ONFIELD)
	e1:SetCode(EFFECT_CHANGE_ATTRIBUTE)  
	e1:SetValue(0x0)  
	c:RegisterEffect(e1)
	   --
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_ONFIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetValue(500)
	c:RegisterEffect(e3)
 --atk limit
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e5:SetRange(LOCATION_ONFIELD)
	e5:SetTargetRange(0,LOCATION_MZONE)
	e5:SetCondition(c98710573.atkcon)
	e5:SetValue(c98710573.atlimit)
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
end
function c98710573.atkcon(e)
	return Duel.IsExistingMatchingCard(Card.IsPosition,e:GetHandlerPlayer(),LOCATION_MZONE,0,2,nil,POS_FACEUP_ATTACK)
end
function c98710573.atkfilter(c,atk)
	return c:IsFaceup() and c:GetAttack()<atk
end
function c98710573.atlimit(e,c)
	return c:IsFaceup() and not Duel.IsExistingMatchingCard(c98710573.atkfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,c,c:GetAttack())
end