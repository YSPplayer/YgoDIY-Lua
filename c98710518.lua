--奥利哈刚 死之计数器 （ZCG）
function c98710518.initial_effect(c)
		c:EnableCounterPermit(0x553)
		--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCondition(c98710518.drcon)
	e2:SetOperation(c98710518.drop)
	c:RegisterEffect(e2)
--destroy
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(98710518,1))
	e8:SetCategory(CATEGORY_REMOVE)
	e8:SetType(EFFECT_TYPE_IGNITION)
	e8:SetRange(LOCATION_FZONE)
	e8:SetCost(c98710518.descost2)
	e8:SetTarget(c98710518.target2)
	e8:SetOperation(c98710518.activate2)
	c:RegisterEffect(e8)
end
function c98710518.descost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x553,1,REASON_COST) end
	e:GetHandler():RemoveCounter(tp,0x553,1,REASON_COST)
end
function c98710518.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_DECK+LOCATION_GRAVE,1,nil) end
	local sg=Duel.GetMatchingGroup(tp,Card.IsAbleToRemove,tp,0,LOCATION_DECK+LOCATION_GRAVE,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,sg,1,0,0)
end
function c98710518.activate2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(tp,Card.IsAbleToRemove,tp,0,LOCATION_DECK+LOCATION_GRAVE,nil)
	Duel.ConfirmCards(tp,g)
	local sg=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,0,LOCATION_DECK+LOCATION_GRAVE,1,1,nil)
	Duel.Remove(sg,POS_FACEUP,REASON_EFFECT) 
end
function c98710518.drcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local bc=tc:GetBattleTarget()
	return  eg:GetCount()==1
		and tc:IsLocation(LOCATION_GRAVE) and tc:IsReason(REASON_BATTLE)
		and bc:IsRelateToBattle() and bc:IsControler(tp) and bc:IsSetCard(0x666)
end
function c98710518.drop(e,tp,eg,ep,ev,re,r,rp)
	  e:GetHandler():AddCounter(0x553,1)
end