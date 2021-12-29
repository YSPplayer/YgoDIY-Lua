--奥西里斯之魔术玩偶 （ZCG）
function c98710370.initial_effect(c)
		--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c98710370.condition)
	e1:SetTarget(c98710370.drtg)
	e1:SetOperation(c98710370.drop)
	c:RegisterEffect(e1)
--disable effect
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e12:SetCode(EVENT_CHAIN_SOLVING)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetOperation(c98710370.disop9)
	c:RegisterEffect(e12)
 --immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710370.efilter9)
	c:RegisterEffect(e13)
end
function c98710370.disop9(e,tp,eg,ep,ev,re,r,rp)
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
function c98710370.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x70c1)
end
function c98710370.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return eg:GetCount()==1 and tc:IsType(TYPE_MONSTER) and tc:IsPreviousControler(tp)
end
function c98710370.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,tc,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c98710370.drop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if not tc:IsAbleToDeck() then return end
	if Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)~=0 then
	Duel.BreakEffect()
	Duel.Draw(tp,1,REASON_EFFECT)
end
end