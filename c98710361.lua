--奥西里斯之祭品收割者 （ZCG）
function c98710361.initial_effect(c)
		--recover
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_CANNOT_DISABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c98710361.con)
	e1:SetTarget(c98710361.tg)
	e1:SetOperation(c98710361.op)
	c:RegisterEffect(e1)
 --disable effect
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e12:SetCode(EVENT_CHAIN_SOLVING)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetOperation(c98710361.disop9)
	c:RegisterEffect(e12)
 --immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710361.efilter9)
	c:RegisterEffect(e13)
end
function c98710361.disop9(e,tp,eg,ep,ev,re,r,rp)
	 local tc=re:GetHandler()
	if (tc:IsSetCard(0x666) or tc:IsSetCard(0x6551)) and re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
		local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
		if g and g:IsContains(e:GetHandler()) then
			if Duel.NegateEffect(ev) and re:GetHandler():IsRelateToEffect(re) then
				Duel.Destroy(re:GetHandler(),REASON_EFFECT)
			end
		end
	end
end
function c98710361.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x70c1)
end
function c98710361.con(e,tp,eg,ep,ev,re,r,rp)
	return not eg:IsContains(e:GetHandler()) and ep==1-tp
end
function c98710361.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local atk=eg:GetFirst():GetAttack()
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,atk)
end
function c98710361.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc:IsLevelAbove(5) then
	while tc do
	local atk=tc:GetAttack()
	Duel.Recover(tp,atk,REASON_EFFECT)
	tc=eg:GetNext()
end
end
end
