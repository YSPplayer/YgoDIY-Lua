--殉道者毁灭区(ZCG)
function c98710076.initial_effect(c)
	 --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98710076,0))
	e2:SetCategory(CATEGORY_DAMAGE+CATEGORY_SPECIAL_SUMMON+CATEGORY_RECOVER)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c98710076.condition)
	e2:SetTarget(c98710076.target)
	e2:SetOperation(c98710076.activate)
	c:RegisterEffect(e2)
--immune
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_ONFIELD)
	e13:SetCode(EFFECT_IMMUNE_EFFECT)
	e13:SetValue(c98710076.efilter9)
	c:RegisterEffect(e13)
--disable
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_DISABLE)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetTargetRange(0,LOCATION_ONFIELD)
	e12:SetTarget(c98710076.distg9)
	c:RegisterEffect(e12)
end
function c98710076.distg9(e,c)
	return c:IsSetCard(0x666)
end
function c98710076.efilter9(e,te)
	return te:GetHandler():IsSetCard(0x666)
end
function c98710076.filter(c,tp)
	return c:IsType(TYPE_MONSTER) and c:GetControler()==1-tp
end
function c98710076.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c98710076.filter,1,nil,tp)
end
function c98710076.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if not eg then return false end
	local tc=eg:GetFirst()
	if chkc then return chkc==tc end
	if chk==0 then return tc:IsLocation(LOCATION_GRAVE) and tc:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(eg)
	local opt=Duel.SelectOption(tp,aux.Stringid(98710076,1),aux.Stringid(98710076,2),aux.Stringid(98710076,3))
	e:SetLabel(opt)
	if opt==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
	 Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,tc,1,0,0)
	elseif opt==1 then
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,tc:GetAttack())
else
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,math.floor(tc:GetAttack()/2))
end
end
function c98710076.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if  tc:IsRelateToEffect(e)  then
	if e:GetLabel()==0  then 
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	else if e:GetLabel()==1 then
		Duel.Recover(tp,tc:GetAttack(),REASON_EFFECT)
	else
		Duel.Damage(1-tp,math.floor(tc:GetAttack()/2),REASON_EFFECT)
end
end
end
end
