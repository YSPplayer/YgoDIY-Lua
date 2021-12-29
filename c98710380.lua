--奥西里斯之极致伤害 （ZCG）
function c98710380.initial_effect(c)
		  --activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	 --to hand or special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98710380,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c98710380.target)
	e2:SetOperation(c98710380.operation)
	c:RegisterEffect(e2)
--disable effect
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e12:SetCode(EVENT_CHAIN_SOLVING)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetOperation(c98710380.disop9)
	c:RegisterEffect(e12)
 --immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710380.efilter9)
	c:RegisterEffect(e13)
end
function c98710380.disop9(e,tp,eg,ep,ev,re,r,rp)
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
function c98710380.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x70c1)
end
function c98710380.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetDecktopGroup(1-tp,5)
	if chk==0 then return Duel.GetFieldGroupCount(1-tp,LOCATION_DECK,0)>=5 end
end
function c98710380.filter(c,e,tp,ft)
	return (c:IsSetCard(0x666) or c:IsSetCard(0x6551) or c:IsSetCard(0x70c1)) and c:IsType(TYPE_MONSTER)
end
function c98710380.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetDecktopGroup(1-tp,5)
	if #g==5 then
		Duel.ConfirmDecktop(1-tp,5)
		local tg=g:Filter(c98710380.filter,nil,e,tp,ft)
		if #tg>0 then
		  local dam=g:GetSum(Card.GetAttack)
		  Duel.Damage(1-tp,dam,REASON_EFFECT)
end
end
end