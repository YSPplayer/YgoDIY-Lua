--奥利哈刚 赫耳墨斯 （ZCG）
function c98710556.initial_effect(c)
		--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98710556,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c98710556.srtg)
	e2:SetOperation(c98710556.srop)
	c:RegisterEffect(e2)
end
function c98710556.srtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c98710556.srop(e,tp,eg,ep,ev,re,r,rp)
	local ct=math.floor(Duel.GetLP(tp)/1000)
	local ac=Duel.AnnounceNumber(tp,1,2,3,4,5,6,7,8,9,10,11,12)
	if ac>ct then return Duel.SelectOption(tp,aux.Stringid(98710556,1)) end
	Duel.PayLPCost(tp,ac*1000)
	Duel.Damage(1-tp,ac*1000,REASON_EFFECT)
end

