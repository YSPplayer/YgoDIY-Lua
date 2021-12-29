--植物の愤怒 狂树虎 (ZCG)
function c98710661.initial_effect(c)
		--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,98710652,98710659,true,true)
 --battle indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c98710661.val)
	c:RegisterEffect(e2)
   --recover
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c98710661.reccon)
	e2:SetTarget(c98710661.rectg)
	e2:SetOperation(c98710661.recop)
	c:RegisterEffect(e2)
end
function c98710661.val(e,c)
	return Duel.GetMatchingGroupCount(aux.TRUE,c:GetControler(),0,LOCATION_ONFIELD,nil)*500
end
function c98710661.reccon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c98710661.filter(c)
return c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c98710661.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroupCount(aux.TRUE,tp,LOCATION_HAND,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,g,tp,LOCATION_HAND)
end
function c98710661.recop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_HAND,0,nil)
	if #g>0 then Duel.SendtoGrave(g,REASON_EFFECT)
	if Duel.GetMatchingGroupCount(aux.TRUE,tp,LOCATION_HAND,0,nil)==0 and Duel.IsExistingMatchingCard(c98710661.filter,tp,LOCATION_DECK,0,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(98710661,1)) then
	local dg=Duel.SelectMatchingCard(tp,c98710661.filter,tp,LOCATION_DECK,0,1,1,nil)
	 if dg:GetCount()>0 then
		Duel.SendtoHand(dg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,dg)
		end
	end
	end
end














