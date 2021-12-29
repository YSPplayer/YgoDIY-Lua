--奥西里斯的统治者 （ZCG）
function c98710385.initial_effect(c)
 c:SetUniqueOnField(1,1,98710385,LOCATION_MZONE)
		--immune effect
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_ONFIELD,0)
	e3:SetValue(c98710385.efilter)
	c:RegisterEffect(e3)
--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98710385,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c98710385.condition)
	e1:SetOperation(c98710385.operation)
	c:RegisterEffect(e1)
end
function c98710385.cfilter(c,tp)
	return c:IsLocation(LOCATION_GRAVE) and c:IsPreviousControler(tp)
end
function c98710385.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c98710385.cfilter,1,nil,tp)
end
function c98710385.efilter(e,re)
	return re:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c98710385.filter1(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c98710385.filter2(c)
	return c:IsType(TYPE_TRAP) and c:IsAbleToHand()
end
function c98710385.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=eg:GetFirst()
	if tc:IsType(TYPE_MONSTER) then 
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_BATTLE_START)
	e4:SetTarget(c98710385.destg)
	e4:SetOperation(c98710385.desop)
	e4:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e4)
	--end
	elseif tc:IsType(TYPE_TRAP) then
	if not Duel.IsExistingMatchingCard(c98710385.filter1,tp,0,LOCATION_ONFIELD+LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND+LOCATION_REMOVED,1,nil) or not Duel.IsExistingMatchingCard(c98710385.filter2,tp,0,LOCATION_ONFIELD+LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND+LOCATION_REMOVED,1,nil) then return end
	local g2=Duel.GetFieldGroup(tp,0,LOCATION_HAND+LOCATION_DECK)
	Duel.ConfirmCards(tp,g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local t1=Duel.SelectMatchingCard(tp,c98710385.filter1,tp,0,LOCATION_ONFIELD+LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND+LOCATION_REMOVED,1,1,nil)
	if not t1 then return end
	local t2=Duel.SelectMatchingCard(tp,c98710385.filter2,tp,0,LOCATION_ONFIELD+LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND+LOCATION_REMOVED,1,1,nil)
	if not t2 then return end
	local g=Group.FromCards(t1,t2)
	Duel.SendtoHand(g,tp,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(1-tp)
	--end
	elseif tc:IsType(TYPE_SPELL) then
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
		local tpe=tc:GetType()
		local te=tc:GetActivateEffect()
		local tg=te:GetTarget()
		local co=te:GetCost()
		local op=te:GetOperation()
		e:SetCategory(te:GetCategory())
		e:SetProperty(te:GetProperty())
		Duel.ClearTargetCard()
		if bit.band(tpe,TYPE_FIELD)~=0 then
			local of=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
			if of then Duel.Destroy(of,REASON_RULE) end
			of=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
			if of and Duel.Destroy(of,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
		end
		if bit.band(tpe,TYPE_FIELD)~=0 then
		Duel.MoveToField(tc,tp,tp,LOCATION_FZONE,POS_FACEUP,true)
		else
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.Hint(HINT_CARD,0,tc:GetCode())
		tc:CreateEffectRelation(te)
		if bit.band(tpe,TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD)==0 then
			tc:CancelToGrave(false)
		end
		if co then co(te,tp,eg,ep,ev,re,r,rp,1) end
		if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
		Duel.BreakEffect()
		local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
		if g then
			local etc=g:GetFirst()
			while etc do
				etc:CreateEffectRelation(te)
				etc=g:GetNext()
			end
		end
		if op then op(te,tp,eg,ep,ev,re,r,rp) end
		tc:ReleaseEffectRelation(te)
		if etc then 
			etc=g:GetFirst()
			while etc do
				etc:ReleaseEffectRelation(te)
				etc=g:GetNext()
			end
		end 
	end
end
end
function c98710385.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler():GetBattleTarget(),1,0,0)
end
function c98710385.desop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	if bc:IsRelateToBattle() then
		if Duel.Destroy(bc,REASON_EFFECT)~=0 then 
		local atk=bc:GetAttack()
		Duel.Recover(tp,atk,REASON_EFFECT)
	end
	end
end
