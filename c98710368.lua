--奥西里斯之生命代价 （ZCG）
function c98710368.initial_effect(c)
	--Activate(summon)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON)
	e1:SetCondition(c98710368.condition1)
	e1:SetCost(c98710368.cost1)
	e1:SetTarget(c98710368.target1)
	e1:SetOperation(c98710368.activate1)
	c:RegisterEffect(e1)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON)
	c:RegisterEffect(e3)

--Activate(summon)
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e4:SetDescription(aux.Stringid(98710368,0))
	e4:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e4:SetCode(EVENT_SUMMON)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(c98710368.condition1)
	e4:SetCost(c98710368.cost1)
	e4:SetTarget(c98710368.target1)
	e4:SetOperation(c98710368.activate1)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EVENT_SPSUMMON)
	c:RegisterEffect(e5)
	
--disable effect
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e12:SetCode(EVENT_CHAIN_SOLVING)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetOperation(c98710368.disop9)
	c:RegisterEffect(e12)
 --immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710368.efilter9)
	c:RegisterEffect(e13)
end
function c98710368.disop9(e,tp,eg,ep,ev,re,r,rp)
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
function c98710368.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x70c1)
end
function c98710368.condition1(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp
end
function c98710368.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
end
function c98710368.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c98710368.activate1(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
end