--达姿 （ZCG）
function c98710536.initial_effect(c)
		--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c98710536.activate)
	c:RegisterEffect(e1)
end
function c98710536.activate(e,tp,eg,ep,ev,re,r,rp)
	local opt=Duel.SelectOption(tp,aux.Stringid(98710536,1),aux.Stringid(98710536,2),aux.Stringid(98710536,3))
	if opt==0 then
	local ct=Duel.CreateToken(tp,98710440)
	Duel.SendtoDeck(ct,tp,0,REASON_EFFECT)
   elseif opt==1 then
	local ct=Duel.CreateToken(tp,98710441)
	Duel.SendtoDeck(ct,tp,0,REASON_EFFECT)
	  elseif opt==1 then
	  local ct=Duel.CreateToken(tp,98710442)
	Duel.SendtoDeck(ct,tp,0,REASON_EFFECT)
end
end