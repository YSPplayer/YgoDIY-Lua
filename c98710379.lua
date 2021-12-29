--奥西里斯之优胜劣汰 （ZCG）
function c98710379.initial_effect(c)
		  --activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	   --destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(98710379,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e3:SetTarget(c98710379.destg2)
	e3:SetOperation(c98710379.desop2)
	c:RegisterEffect(e3)
--disable effect
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e12:SetCode(EVENT_CHAIN_SOLVING)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetOperation(c98710379.disop9)
	c:RegisterEffect(e12)
 --immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710379.efilter9)
	c:RegisterEffect(e13)
end
function c98710379.disop9(e,tp,eg,ep,ev,re,r,rp)
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
function c98710379.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x70c1)
end
function c98710379.destg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RACE)
	globeRc=Duel.AnnounceRace(tp,1,RACE_ALL)
	--e:SetLabel(rc)
end
function c98710379.desop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetRange(LOCATION_SZONE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetCondition(c98710379.drcon)
	e1:SetTarget(c98710379.destg)
	e1:SetOperation(c98710379.desop)
	c:RegisterEffect(e1)
end
function c98710379.drcon(e,tp,eg,ep,ev,re,r,rp)
	--local race=e:GetLabel()
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if a:IsControler(tp) then
	e:SetLabelObject(d)
	return a:IsFaceup() and a:IsRelateToBattle() and d and d:IsRace(globeRc) and d:IsRelateToBattle()
	else
		e:SetLabelObject(a)
		return d and d:IsFaceup() and d:IsRelateToBattle() and a and a:IsRace(globeRc) and a:IsRelateToBattle()
	end
end
function c98710379.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if chk ==0 then return  (d~=nil and d:IsRelateToBattle() and d:GetControler(1-tp)) or 
	(a~=nil and a:IsRelateToBattle() and d:GetControler(1-tp)) end
	  Duel.SetOperationInfo(0,CATEGORY_DESTROY,d,1,0,0)
end
function c98710379.desop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if  d:IsRace(globeRc) and d:IsControler(1-tp) then
	  Duel.Destroy(d,REASON_EFFECT)
	else
	  Duel.Destroy(a,REASON_EFFECT)
	end
end
