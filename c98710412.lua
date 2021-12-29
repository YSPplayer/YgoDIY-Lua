--奥利哈刚 七武神·火之灭 （ZCG）
function c98710412.initial_effect(c)
		c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c98710412.spcon)
	c:RegisterEffect(e1)
	--spsummon limit
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e2)
  --att change
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(98710412,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c98710412.atttg)
	e3:SetOperation(c98710412.attop)
	c:RegisterEffect(e3)
end
function c98710412.spfilter(c)
return c:IsSetCard(0x666) and c:IsLevelAbove(5)
end
function c98710412.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c98710412.spfilter,tp,LOCATION_GRAVE,0,7,nil)
end
function c98710412.atttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTRIBUTE)
	aat98710412=Duel.AnnounceAttribute(tp,1,ATTRIBUTE_ALL-ATTRIBUTE_FIRE)
end
function c98710412.attop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
	e4:SetValue(c98710412.adval)
	c:RegisterEffect(e4)
	local att=e:GetLabel()
	local ct=Duel.GetMatchingGroup(Card.IsAttribute,e:GetHandler():GetControler(),0,LOCATION_GRAVE+LOCATION_ONFIELD+LOCATION_HAND,nil,aat98710412)
	if #ct>0 then
	Duel.Remove(ct,POS_FACEUP,REASON_EFFECT)
		end
	end
end
function c98710412.filter(c)
	return c:IsFaceup() and not c:IsCode(98710412) and not c:IsHasEffect(98710412) and c:IsAttribute(aat98710412)
end
function c98710412.adval(e,c)
	local g=Duel.GetMatchingGroup(c98710412.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()==0 then
		return 0
	else
		local tg,val=g:GetMaxGroup(Card.GetAttack)
		return val*2
	end
end