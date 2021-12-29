--六芒星之龙 封锁水龙 （ZCG）
function c98710313.initial_effect(c)
	  --summon with 2 tribute or 1 setcard
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98710303,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e1:SetCondition(c98710313.ttcon)
	e1:SetOperation(c98710313.ttop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_PROC)
	c:RegisterEffect(e2)
  --disable spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(0,1)
	c:RegisterEffect(e3)
--Negate
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EVENT_CHAINING)
	e5:SetCondition(c98710313.condition)
	e5:SetTarget(c98710313.target)
	e5:SetOperation(c98710313.activate)
	c:RegisterEffect(e5)
  --disable
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetCode(EFFECT_DISABLE)
	e12:SetRange(LOCATION_MZONE)
	e12:SetTargetRange(0,LOCATION_SZONE)
	e12:SetTarget(c98710313.distg)
	c:RegisterEffect(e12)
 --summon
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e7)
--negate
	local e11=Effect.CreateEffect(c)
	e11:SetCategory(CATEGORY_NEGATE+CATEGORY_REMOVE+CATEGORY_DAMAGE)
	e11:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e11:SetCode(EVENT_CHAINING)
	e11:SetRange(LOCATION_MZONE)
	e11:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_CANNOT_DISABLE)
	e11:SetCondition(c98710313.negcon)
	e11:SetTarget(c98710313.negtg)
	e11:SetOperation(c98710313.negop)
	c:RegisterEffect(e11)
end
function c98710313.distg(e,c)
	return c:IsType(TYPE_TRAP)
end
function c98710313.condition(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and rp==1-tp
		and re:IsActiveType(TYPE_TRAP) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
	  --  and Duel.GetTurnPlayer()~=tp
end
function c98710313.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c98710313.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function c98710313.negcon(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
		and rc:IsSetCard(0x666) and Duel.IsChainNegatable(ev)
end
function c98710313.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return aux.nbcon(tp,re) end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,eg,1,0,0)
	end
end
function c98710313.negop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
	   local ct=Duel.Remove(eg,POS_FACEUP,REASON_EFFECT)
		Duel.Damage(1-tp,ct*1000,REASON_EFFECT)
	end
end
function c98710313.otfilter(c)
	return c:IsAttribute(ATTRIBUTE_WATER)
end
function c98710313.tfilter(c)
	return c:IsSetCard(0x6551)
end
function c98710313.ttcon(e,c,minc)
	if c==nil then return true end
	local mg=Duel.GetMatchingGroup(c98710313.otfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	local mg2=Duel.GetMatchingGroup(c98710313.tfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	return (minc<=2 and Duel.CheckTribute(c,2,2,mg)) or (minc<=1 and Duel.CheckTribute(c,1,1,mg2))
end
function c98710313.ttop(e,tp,eg,ep,ev,re,r,rp,c)
	if not Duel.IsExistingMatchingCard(c98710313.otfilter,c:GetControler(),LOCATION_MZONE,0,2,nil) and Duel.IsExistingMatchingCard(c98710313.tfilter,c:GetControler(),LOCATION_MZONE,0,1,nil) then
	local mg=Duel.GetMatchingGroup(c98710313.tfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	local sg=Duel.SelectTribute(tp,c,1,1,mg)
	c:SetMaterial(sg)
	Duel.Release(sg,REASON_SUMMON+REASON_MATERIAL)
	elseif Duel.IsExistingMatchingCard(c98710313.otfilter,c:GetControler(),LOCATION_MZONE,0,2,nil) and not Duel.IsExistingMatchingCard(c98710313.tfilter,c:GetControler(),LOCATION_MZONE,0,1,nil) then
	local mg=Duel.GetMatchingGroup(c98710313.otfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	local g=Duel.SelectTribute(tp,c,2,2,mg)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
	else
	local opt=Duel.SelectOption(tp,aux.Stringid(98710310,1),aux.Stringid(98710310,2))
	e:SetLabel(opt)
	if opt==0 then 
	local mg=Duel.GetMatchingGroup(c98710313.otfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	local g=Duel.SelectTribute(tp,c,2,2,mg)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
	else
	local mg=Duel.GetMatchingGroup(c98710313.tfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	local sg=Duel.SelectTribute(tp,c,1,1,mg)
	c:SetMaterial(sg)
	Duel.Release(sg,REASON_SUMMON+REASON_MATERIAL)
end
end
end