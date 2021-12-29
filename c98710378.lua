--奥西里斯之极限防御 （ZCG）
function c98710378.initial_effect(c)
		  --activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98710378,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c98710378.condition)
	e2:SetTarget(c98710378.cost2)
	e2:SetOperation(c98710378.regop)
	c:RegisterEffect(e2)
--disable effect
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e12:SetCode(EVENT_CHAIN_SOLVING)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetOperation(c98710378.disop9)
	c:RegisterEffect(e12)
 --immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710378.efilter9)
	c:RegisterEffect(e13)
end
function c98710378.disop9(e,tp,eg,ep,ev,re,r,rp)
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
function c98710378.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x70c1)
end
function c98710378.condition(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return tp==Duel.GetTurnPlayer() and bit.band(ph,PHASE_MAIN2+PHASE_END)==0
end
function c98710378.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_SKIP_BP)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(1,0)
	e3:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e3,tp)
end
function c98710378.regop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetCountLimit(1)
	e1:SetCondition(c98710378.drcon)
	e1:SetTarget(c98710378.drtg)
	e1:SetOperation(c98710378.drop)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,1)
	Duel.RegisterEffect(e1,tp)
end

function c98710378.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c98710378.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local dr=7-Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,dr) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,dr)
end
function c98710378.drop(e,tp,eg,ep,ev,re,r,rp)
	 local dr=7-Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	 Duel.Draw(tp,dr,REASON_EFFECT)
end