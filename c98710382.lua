--奥西里斯之神的制裁 （ZCG）
function c98710382.initial_effect(c)
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e0:SetCode(EVENT_PREDRAW)
	e0:SetCountLimit(1,98710382+EFFECT_COUNT_CODE_DUEL)
	e0:SetRange(LOCATION_DECK)
	e0:SetOperation(c98710382.moop)
	c:RegisterEffect(e0)
end
function c98710382.filter(c)
  return c:IsSetCard(0x6551) or c:IsSetCard(0x87c2)
end
function c98710382.refilter1(c)
  return c:IsSetCard(0x6551)
end
function c98710382.refilter2(c)
  return c:IsSetCard(0x87c2)
end
function c98710382.moop(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_SZONE,0)>0 then
	Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Duel.BreakEffect()
	if Duel.GetMatchingGroupCount(c98710382.filter,tp,LOCATION_DECK,LOCATION_DECK,nil)>0 then
	   local g1=Duel.GetMatchingGroup(c98710382.refilter1,tp,LOCATION_DECK,LOCATION_DECK,nil)
	   local g2=Duel.GetMatchingGroup(c98710382.refilter2,tp,LOCATION_DECK,LOCATION_DECK,nil)
			 if  #g2==0 and Duel.Remove(g1+g2,POS_FACEUP,REASON_EFFECT)==#g1  then
			 Duel.BreakEffect()
				if Duel.GetLP(1-tp)>#g1*1000 then
				   Duel.Damage(1-tp,#g1*1000,REASON_EFFECT)
				   Duel.SetLP(1-tp,1)
				else
				   local lp=Duel.GetLP(1-tp)
				   Duel.Damage(1-tp,lp-1,REASON_EFFECT)
				   Duel.SetLP(1-tp,1)
				end
			elseif #g1==0 and Duel.Remove(g1+g2,POS_FACEUP,REASON_EFFECT)==#g2 then
			Duel.BreakEffect()
				if Duel.GetLP(1-tp)>#g2*1000 then
				   Duel.Damage(1-tp,#g2*1000,REASON_EFFECT)
				   Duel.SetLP(1-tp,1)
				else
				  local lp=Duel.GetLP(1-tp)
				  Duel.Damage(1-tp,lp-1,REASON_EFFECT)
				  Duel.SetLP(1-tp,1)
			   end
		   elseif #g1~=0 and #g2~=0 then
		   Duel.Win(tp,0x17)
			   end
			end
	end
end

