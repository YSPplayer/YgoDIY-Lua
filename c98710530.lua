--奥利哈刚 炎魔象 （ZCG）
function c98710530.initial_effect(c)
	 --special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCountLimit(1,98710530+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c98710530.spcon)
	c:RegisterEffect(e1)
end
function c98710530.filter(c)
	return c:IsCode(98710440)
end
function c98710530.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c98710530.filter,c:GetControler(),LOCATION_ONFIELD,0,1,nil)
end