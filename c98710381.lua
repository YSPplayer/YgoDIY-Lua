--奥西里斯之号令 （ZCG）
function c98710381.initial_effect(c)
	   --activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCondition(c98710381.con)
	e1:SetTarget(c98710381.tg)
	e1:SetOperation(c98710381.op)
	c:RegisterEffect(e1)
	 local e2=e1:Clone()
	e2:SetCode(EVENT_MSET)
	c:RegisterEffect(e2)
--recover
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c98710381.con2)
	e3:SetTarget(c98710381.tg)
	e3:SetOperation(c98710381.op)
	c:RegisterEffect(e3)
  --atk
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_SEARCH)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_CHAINING)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(c98710381.atkcon)
	e4:SetTarget(c98710381.tg)
	e4:SetOperation(c98710381.op)
	c:RegisterEffect(e4)
end
function c98710381.filter(c)
  return c:IsPreviousLocation(LOCATION_HAND)
end
function c98710381.con(e,tp,eg,ep,ev,re,r,rp)
	return ep==e:GetHandler():GetControler() and eg:IsExists(c98710381.filter,1,nil,tp)
end
function c98710381.spfilter(c,tp)
	return c:IsSummonPlayer(tp) and c:IsSummonLocation(LOCATION_HAND)
end
function c98710381.con2(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c98710381.spfilter,1,nil,tp)
end
function c98710381.thfilter(c)
	return c:IsSetCard(0x7c11) and c:IsAbleToHand() and c:IsType(TYPE_MONSTER)
end
function c98710381.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98710381.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c98710381.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c98710381.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c98710381.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	return re:IsActiveType(TYPE_MONSTER+TYPE_SPELL+TYPE_TRAP) and loc==LOCATION_HAND and ep==tp
end