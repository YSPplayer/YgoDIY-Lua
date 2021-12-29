--奥利哈刚 奇甲卡拉 （ZCG）
function c98710425.initial_effect(c)
			--immune effect
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_ONFIELD,0)
	e3:SetTarget(c98710425.etarget)
	e3:SetValue(c98710425.efilter)
	c:RegisterEffect(e3)
 --direct atk
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e6)
end
function c98710425.etarget(e,c)
	return c:IsSetCard(0x666) and c:IsType(TYPE_MONSTER)
end
function c98710425.efilter(e,re)
	return re:GetOwnerPlayer()~=e:GetHandlerPlayer()
end