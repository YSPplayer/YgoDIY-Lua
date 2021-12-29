--六芒星之龙 长翼凤龙 （ZCG）
function c98710312.initial_effect(c)
	  --summon with 2 tribute or 1 setcard
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98710303,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e1:SetCondition(c98710312.ttcon)
	e1:SetOperation(c98710312.ttop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_PROC)
	c:RegisterEffect(e2)
  --destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(98710303,3))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCost(c98710312.descost)
	e3:SetTarget(c98710312.destg)
	e3:SetOperation(c98710312.desop)
	c:RegisterEffect(e3)
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
	e11:SetCondition(c98710312.negcon)
	e11:SetTarget(c98710312.negtg)
	e11:SetOperation(c98710312.negop)
	c:RegisterEffect(e11)
end
function c98710312.negcon(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
		and rc:IsSetCard(0x666) and Duel.IsChainNegatable(ev)
end
function c98710312.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return aux.nbcon(tp,re) end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,eg,1,0,0)
	end
end
function c98710312.negop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
	   local ct=Duel.Remove(eg,POS_FACEUP,REASON_EFFECT)
		Duel.Damage(1-tp,ct*1000,REASON_EFFECT)
	end
end
function c98710312.otfilter(c)
	return c:IsAttribute(ATTRIBUTE_WIND)
end
function c98710312.tfilter(c)
	return c:IsSetCard(0x6551)
end
function c98710312.ttcon(e,c,minc)
	if c==nil then return true end
	local mg=Duel.GetMatchingGroup(c98710312.otfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	local mg2=Duel.GetMatchingGroup(c98710312.tfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	return (minc<=2 and Duel.CheckTribute(c,2,2,mg)) or (minc<=1 and Duel.CheckTribute(c,1,1,mg2))
end
function c98710312.ttop(e,tp,eg,ep,ev,re,r,rp,c)
	if not Duel.IsExistingMatchingCard(c98710312.otfilter,c:GetControler(),LOCATION_MZONE,0,2,nil) and Duel.IsExistingMatchingCard(c98710312.tfilter,c:GetControler(),LOCATION_MZONE,0,1,nil) then
	local mg=Duel.GetMatchingGroup(c98710312.tfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	local sg=Duel.SelectTribute(tp,c,1,1,mg)
	c:SetMaterial(sg)
	Duel.Release(sg,REASON_SUMMON+REASON_MATERIAL)
	elseif Duel.IsExistingMatchingCard(c98710312.otfilter,c:GetControler(),LOCATION_MZONE,0,2,nil) and not Duel.IsExistingMatchingCard(c98710312.tfilter,c:GetControler(),LOCATION_MZONE,0,1,nil) then
	local mg=Duel.GetMatchingGroup(c98710312.otfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	local g=Duel.SelectTribute(tp,c,2,2,mg)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
	else
	local opt=Duel.SelectOption(tp,aux.Stringid(98710310,1),aux.Stringid(98710310,2))
	e:SetLabel(opt)
	if opt==0 then 
	local mg=Duel.GetMatchingGroup(c98710312.otfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	local g=Duel.SelectTribute(tp,c,2,2,mg)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
	else
	local mg=Duel.GetMatchingGroup(c98710312.tfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	local sg=Duel.SelectTribute(tp,c,1,1,mg)
	c:SetMaterial(sg)
	Duel.Release(sg,REASON_SUMMON+REASON_MATERIAL)
end
end
end
function c98710312.filter(c)
return c:IsDiscardable()
end
function c98710312.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98710312.filter,tp,LOCATION_HAND,0,1,nil) end
	local sg=Duel.GetTargetCount(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	local ct=Duel.DiscardHand(tp,c98710312.filter,1,sg,REASON_COST+REASON_DISCARD)
	e:SetLabel(ct) 
end
function c98710312.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local number=e:GetLabel()
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,number,number,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c98710312.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local dg=g:Filter(Card.IsRelateToEffect,nil,e)
	Duel.Destroy(dg,REASON_EFFECT)
	--local tc=Duel.GetFirstTarget()
   -- if tc:IsRelateToEffect(e) then
	  --  Duel.Destroy(tc,REASON_EFFECT)
  --  end
end