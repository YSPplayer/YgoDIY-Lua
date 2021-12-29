--奥利哈刚 末日残影 （ZCG）
function c98710502.initial_effect(c)
	  --activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c98710502.tg)
	e1:SetOperation(c98710502.op)
	c:RegisterEffect(e1)
end
function c98710502.filter(c,e,tp)
	return c:IsFaceup() and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c98710502.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return 
		(Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c98710502.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp)) 
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,2,LOCATION_GRAVE)
end
function c98710502.op(e,tp,eg,ep,ev,re,r,rp)
	local count=0
	local ft1=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft1>0 then
		if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft1=1 end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c98710502.filter,tp,LOCATION_GRAVE,0,ft1,ft1,nil,e,tp)
		if g:GetCount()>0 then
			local tc=g:GetFirst()
			while tc do
				Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
			   local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1,true)
		tc:RegisterFlagEffect(98710502,RESET_EVENT+RESETS_STANDARD,0,1)
		tc:CompleteProcedure()
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetCountLimit(1)
		e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetLabelObject(tc)
		e2:SetCondition(c98710502.descon)
		e2:SetOperation(c98710502.desop)
		Duel.RegisterEffect(e2,tp)
				tc=g:GetNext()
				count=count+1
			end
		end
	end
	if count>0 then Duel.SpecialSummonComplete() end
end
function c98710502.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:GetFlagEffect(98710502)~=0 then
		return true
	else
		e:Reset()
		return false
	end
end
function c98710502.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.Destroy(tc,REASON_EFFECT)
end