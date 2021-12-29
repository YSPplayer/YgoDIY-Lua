--六芒星之龙 黑海霸龙 （ZCG）
function c98710330.initial_effect(c)
	  --summon with 2 tribute or 1 setcard
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98710311,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e1:SetCondition(c98710330.ttcon)
	e1:SetOperation(c98710330.ttop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_PROC)
	c:RegisterEffect(e2)
--cannot target
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetValue(aux.tgoval)
	c:RegisterEffect(e3)
 --summon
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e7)
 --ATK Up
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_BATTLE_DESTROYING)
	e4:SetCondition(aux.bdocon)
	e4:SetTarget(c98710330.drtg)
	e4:SetOperation(c98710330.drop)
	c:RegisterEffect(e4)
end
function c98710330.filter9(c,e)
	return c:IsType(TYPE_MONSTER) and c:IsCanBeEffectTarget(e)
end
function c98710330.drtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	 local g=Duel.GetMatchingGroup(c98710330.filter9,tp,0,LOCATION_ONFIELD+LOCATION_HAND,nil,e)
	 if chkc then return c98710330.filter9(chkc,e) end
	if chk==0 then return g:GetClassCount(Card.GetLinkAttribute)>=5 end
end
function c98710330.costfilter1(c,tp)
	return c:IsType(TYPE_MONSTER) and Duel.IsExistingMatchingCard(c98710330.costfilter2,tp,0,LOCATION_HAND+LOCATION_MZONE,1,c,c:GetOriginalAttribute(),tp)
end
function c98710330.costfilter2(c,att,tp)
	return c:IsType(TYPE_MONSTER) and c:GetOriginalAttribute()~=att
		and Duel.IsExistingMatchingCard(c98710330.costfilter3,tp,0,LOCATION_HAND+LOCATION_MZONE,1,c,c:GetOriginalAttribute(),tp)
end
function c98710330.costfilter3(c,att2,tp)
	return c:IsType(TYPE_MONSTER) and c:GetOriginalAttribute()~=att2 and c:GetOriginalAttribute()~=att
		and Duel.IsExistingMatchingCard(c98710330.costfilter4,tp,0,LOCATION_HAND+LOCATION_MZONE,1,c,c:GetOriginalAttribute(),tp)
end
function c98710330.costfilter4(c,att3,tp)
	return c:IsType(TYPE_MONSTER) and c:GetOriginalAttribute()~=att2 and c:GetOriginalAttribute()~=att and c:GetOriginalAttribute()~=att3
		and Duel.IsExistingMatchingCard(c98710330.costfilter5,tp,0,LOCATION_HAND+LOCATION_MZONE,1,c,c:GetOriginalAttribute(),tp)
end
function c98710330.costfilter5(c,att4,tp)
	return c:IsType(TYPE_MONSTER) and c:GetOriginalAttribute()~=att2 and c:GetOriginalAttribute()~=att and c:GetOriginalAttribute()~=att  and c:GetOriginalAttribute()~=att3 and c:GetOriginalAttribute()~=att4
		
end
function c98710330.drop(e,tp,eg,ep,ev,re,r,rp)
	local hg=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	local g=Duel.GetMatchingGroup(c98710330.costfilter1,tp,0,LOCATION_ONFIELD+LOCATION_HAND,nil,e)
	if g:GetCount()>=5 and Duel.SelectYesNo(tp,aux.Stringid(98710310,3)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local sg=g:Select(tp,5,5,nil)
		Duel.SetTargetCard(sg)
	if sg:GetCount()>0  then
	   if Duel.Destroy(sg,REASON_EFFECT)~=0  and hg>0 then
		 Duel.BreakEffect()
		 Duel.ConfirmCards(tp,hg)
		 Duel.SendtoDeck(hg,nil,2,REASON_EFFECT)
		 Duel.ShuffleDeck(1-tp)
		 Duel.Draw(1-tp,hg:GetCount(),REASON_EFFECT)
	end
end
end
end
function c98710330.otfilter(c)
	return c:IsAttribute(ATTRIBUTE_DARK)
end
function c98710330.tfilter(c)
	return c:IsSetCard(0x6551)
end
function c98710330.ttcon(e,c,minc)
	if c==nil then return true end
	local mg=Duel.GetMatchingGroup(c98710330.otfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	local mg2=Duel.GetMatchingGroup(c98710330.tfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	return (minc<=2 and Duel.CheckTribute(c,2,2,mg)) or (minc<=1 and Duel.CheckTribute(c,1,1,mg2))
end
function c98710330.ttop(e,tp,eg,ep,ev,re,r,rp,c)
	if not Duel.IsExistingMatchingCard(c98710330.otfilter,c:GetControler(),LOCATION_MZONE,0,2,nil) and Duel.IsExistingMatchingCard(c98710330.tfilter,c:GetControler(),LOCATION_MZONE,0,1,nil) then
	local mg=Duel.GetMatchingGroup(c98710330.tfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	local sg=Duel.SelectTribute(tp,c,1,1,mg)
	c:SetMaterial(sg)
	Duel.Release(sg,REASON_SUMMON+REASON_MATERIAL)
	elseif Duel.IsExistingMatchingCard(c98710330.otfilter,c:GetControler(),LOCATION_MZONE,0,2,nil) and not Duel.IsExistingMatchingCard(c98710330.tfilter,c:GetControler(),LOCATION_MZONE,0,1,nil) then
	local mg=Duel.GetMatchingGroup(c98710330.otfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	local g=Duel.SelectTribute(tp,c,2,2,mg)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
	else
	local opt=Duel.SelectOption(tp,aux.Stringid(98710311,1),aux.Stringid(98710311,2))
	e:SetLabel(opt)
	if opt==0 then 
	local mg=Duel.GetMatchingGroup(c98710330.otfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	local g=Duel.SelectTribute(tp,c,2,2,mg)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
	else
	local mg=Duel.GetMatchingGroup(c98710330.tfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	local sg=Duel.SelectTribute(tp,c,1,1,mg)
	c:SetMaterial(sg)
	Duel.Release(sg,REASON_SUMMON+REASON_MATERIAL)
end
end
end