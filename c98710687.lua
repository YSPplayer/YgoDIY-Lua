--装甲 移动城堡 （ZCG）
function c98710687.initial_effect(c)
	 --search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98710687,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c98710687.srtg)
	e1:SetOperation(c98710687.srop)
	c:RegisterEffect(e1)
	--todeck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98710687,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c98710687.spcon)
	e2:SetTarget(c98710687.sptg)
	e2:SetOperation(c98710687.spop)
	c:RegisterEffect(e2)
end
function c98710687.tdfilter(c)
	return c:IsLevelBelow(4)  and c:IsCanOverlay()
end
function c98710687.srtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c98710687.tdfilter,tp,LOCATION_DECK,0,1,nil) end
end
function c98710687.srop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=Duel.SelectMatchingCard(tp,c98710687.tdfilter,tp,LOCATION_DECK,0,1,1,nil)
	local c=e:GetHandler()
	local tc=g:GetFirst()
	if c:IsFaceup() then
		local og=tc:GetOverlayGroup()
		if og:GetCount()>0 then
			Duel.SendtoGrave(og,REASON_RULE)
		end
		Duel.Overlay(c,tc)
		tc:RegisterFlagEffect(98710687,0,0,1)
	end
end
function c98710687.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetOverlayGroup()
	return c:IsReason(REASON_DESTROY) and c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousControler(tp) and #ct>0
end
function c98710687.ovfilter(c,e,tp)
return c:IsType(TYPE_MONSTER) and c:GetFlagEffect(98710687)>0 and c:GetPreviousLocation()==LOCATION_OVERLAY and c:IsCanBeSpecialSummoned(e,0,tp,false,false) 
end
function c98710687.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_EXTRA+LOCATION_HAND,LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_EXTRA+LOCATION_HAND,e:GetHandler())
	local g=ct:Filter(c98710687.ovfilter,nil,e,tp)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>=g:GetCount() end
end
function c98710687.spop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_EXTRA+LOCATION_HAND,LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_EXTRA+LOCATION_HAND,e:GetHandler())
	local g=ct:Filter(c98710687.ovfilter,nil,e,tp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<g:GetCount() then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	if g:GetCount()>0 then
		   local tc=g:GetFirst()
		   while tc do
		   Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		   tc:ResetFlagEffect(98710687)
		   tc=g:GetNext()
		end
		Duel.SpecialSummonComplete()
	end
end















