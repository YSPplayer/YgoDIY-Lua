--奥西里斯之魔人 娜塔莎 （ZCG）
function c98710343.initial_effect(c)
	 --immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetValue(c98710343.efilter)
	c:RegisterEffect(e1)
local e4=Effect.CreateEffect(c)
	   e4:SetDescription(aux.Stringid(98710343,0))
	   e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	   e4:SetType(EFFECT_TYPE_IGNITION)
	   e4:SetRange(LOCATION_MZONE)
	   e4:SetCategory(CATEGORY_DESTROY)
	   e4:SetTarget(c98710343.sptg)
	   e4:SetOperation(c98710343.spop)
	   c:RegisterEffect(e4)
--disable effect
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e12:SetCode(EVENT_CHAIN_SOLVING)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetOperation(c98710343.disop9)
	c:RegisterEffect(e12)
 --immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710343.efilter9)
	c:RegisterEffect(e13)
end
function c98710343.disop9(e,tp,eg,ep,ev,re,r,rp)
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
function c98710343.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x70c1)
end
function c98710343.efilter(e,te)
	return te:IsActiveType(TYPE_TRAP+TYPE_SPELL) and te:GetOwner()~=c
		and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c98710343.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c98710343.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c98710343.filter(chkc)  end
	if chk==0 then return Duel.IsExistingTarget(c98710343.filter,tp,0,LOCATION_ONFIELD,1,nil)  and e:GetHandler():IsAttackAbove(300)  end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c98710343.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c98710343.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsFaceup() or c:GetAttack()<300 then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
	e1:SetValue(-300)
	c:RegisterEffect(e1)
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
