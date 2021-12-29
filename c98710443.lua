--奥利哈刚第层四结界控神阵 （ZCG）
function c98710443.initial_effect(c)
				--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(aux.Stringid(98710443,0))
	e0:SetType(EFFECT_TYPE_IGNITION)
	e0:SetRange(LOCATION_HAND)
	e0:SetTarget(c98710443.cotg)
	e0:SetOperation(c98710443.coop)
	c:RegisterEffect(e0)
			--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98710443,1))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c98710443.condition)
	e1:SetOperation(c98710443.moop)
	c:RegisterEffect(e1)
		--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98710443,2))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c98710443.condition)
	e2:SetTarget(c98710443.motg)
	e2:SetOperation(c98710443.moop2)
	c:RegisterEffect(e2)
	--selfdes
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_ADJUST)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCondition(c98710443.sdcon2)
	e4:SetOperation(c98710443.sdop)
	c:RegisterEffect(e4)
		--Activate
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(98710443,3))
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_ONFIELD)
	e5:SetTarget(c98710443.sptg3)
	e5:SetOperation(c98710443.spop3)
	c:RegisterEffect(e5)
		--Activate
	local e9=Effect.CreateEffect(c)
	e9:SetDescription(aux.Stringid(98710443,4))
	e9:SetType(EFFECT_TYPE_IGNITION)
	e9:SetRange(LOCATION_ONFIELD)
	e9:SetCost(c98710443.descost2)
	e9:SetTarget(c98710443.sptg4)
	e9:SetOperation(c98710443.spop4)
	c:RegisterEffect(e9)
	--indes
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetRange(LOCATION_ONFIELD)
	e6:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e6:SetValue(1)
	c:RegisterEffect(e6)
	local e7=e6:Clone()
	e7:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e7)
end
function c98710443.spfilter2(c,e,tp)
return c:IsSetCard(0x666) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c98710443.descost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,Duel.GetLP(tp)-1) end
	Duel.PayLPCost(tp,Duel.GetLP(tp)-1)
end
function c98710443.sptg4(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98710443.spfilter2,tp,LOCATION_DECK+LOCATION_EXTRA+LOCATION_GRAVE+LOCATION_HAND+LOCATION_REMOVED,LOCATION_DECK+LOCATION_EXTRA+LOCATION_GRAVE+LOCATION_HAND+LOCATION_REMOVED,1,nil,e,tp) and Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_MZONE,0)>0 end 
end
function c98710443.spop4(e,tp,eg,ep,ev,re,r,rp) 
	local g=Duel.GetMatchingGroup(c98710443.spfilter2,tp,LOCATION_DECK+LOCATION_EXTRA+LOCATION_GRAVE+LOCATION_HAND+LOCATION_REMOVED,LOCATION_DECK+LOCATION_EXTRA+LOCATION_GRAVE+LOCATION_HAND+LOCATION_REMOVED,nil,e,tp)
	Duel.ConfirmCards(tp,g)   
	local hg=Duel.SelectMatchingCard(tp,c98710443.spfilter2,tp,LOCATION_DECK+LOCATION_EXTRA+LOCATION_GRAVE+LOCATION_HAND+LOCATION_REMOVED,LOCATION_DECK+LOCATION_EXTRA+LOCATION_GRAVE+LOCATION_HAND+LOCATION_REMOVED,1,1,nil,e,tp)
	if #hg>0 then
	Duel.SpecialSummon(hg,0,tp,tp,false,false,POS_FACEUP)
end
end
function c98710443.spfilter(c,e,tp)
return c:IsSetCard(0x666) and c:IsType(TYPE_MONSTER) and c:IsLevelAbove(5) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c98710443.cosfilter(c)
return c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c98710443.sptg3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98710443.spfilter,tp,LOCATION_DECK+LOCATION_EXTRA+LOCATION_GRAVE+LOCATION_HAND+LOCATION_REMOVED,LOCATION_DECK+LOCATION_EXTRA+LOCATION_GRAVE+LOCATION_HAND+LOCATION_REMOVED,1,nil,e,tp) and Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_MZONE,0)>0 end 
end
function c98710443.spop3(e,tp,eg,ep,ev,re,r,rp) 
	local g=Duel.GetMatchingGroup(c98710443.spfilter,tp,LOCATION_DECK+LOCATION_EXTRA+LOCATION_GRAVE+LOCATION_HAND+LOCATION_REMOVED,LOCATION_DECK+LOCATION_EXTRA+LOCATION_GRAVE+LOCATION_HAND+LOCATION_REMOVED,nil,e,tp)
	Duel.ConfirmCards(tp,g)   
	local hg=Duel.SelectMatchingCard(tp,c98710443.spfilter,tp,LOCATION_DECK+LOCATION_EXTRA+LOCATION_GRAVE+LOCATION_HAND+LOCATION_REMOVED,LOCATION_DECK+LOCATION_EXTRA+LOCATION_GRAVE+LOCATION_HAND+LOCATION_REMOVED,1,1,nil,e,tp)
	local tc=hg:GetFirst()
			if tc:IsLevelAbove(5) and tc:IsLevelBelow(7) then
				local cg=Duel.GetMatchingGroup(c98710443.cosfilter,tp,LOCATION_DECK+LOCATION_ONFIELD+LOCATION_HAND,LOCATION_DECK+LOCATION_ONFIELD+LOCATION_HAND,nil)
				if #cg==0 then return end
				Duel.ConfirmCards(tp,cg)
				local hg=Duel.SelectMatchingCard(tp,c98710443.cosfilter,tp,LOCATION_DECK+LOCATION_ONFIELD+LOCATION_HAND,LOCATION_DECK+LOCATION_ONFIELD+LOCATION_HAND,1,1,nil) 
				if Duel.SendtoGrave(hg,REASON_COST)~=0 and Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_MZONE,0)>0 then
				Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
			end
			elseif tc:IsLevelAbove(8) and tc:IsLevelBelow(10) then
				local cg=Duel.GetMatchingGroup(c98710443.cosfilter,tp,LOCATION_DECK+LOCATION_ONFIELD+LOCATION_HAND,LOCATION_DECK+LOCATION_ONFIELD+LOCATION_HAND,nil)
				if #cg<=1 then return end
				Duel.ConfirmCards(tp,cg)
				local hg=Duel.SelectMatchingCard(tp,c98710443.cosfilter,tp,LOCATION_DECK+LOCATION_ONFIELD+LOCATION_HAND,LOCATION_DECK+LOCATION_ONFIELD+LOCATION_HAND,2,2,nil) 
				if Duel.SendtoGrave(hg,REASON_COST)>1 and Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_MZONE,0)>0 then
				Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
			end
			elseif tc:IsLevelAbove(11) then
				local cg=Duel.GetMatchingGroup(c98710443.cosfilter,tp,LOCATION_DECK+LOCATION_ONFIELD+LOCATION_HAND,LOCATION_DECK+LOCATION_ONFIELD+LOCATION_HAND,nil)
				if #cg<=2 then return end
				Duel.ConfirmCards(tp,cg)
				local hg=Duel.SelectMatchingCard(tp,c98710443.cosfilter,tp,LOCATION_DECK+LOCATION_ONFIELD+LOCATION_HAND,LOCATION_DECK+LOCATION_ONFIELD+LOCATION_HAND,3,3,nil) 
				if Duel.SendtoGrave(hg,REASON_COST)>2 and Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_MZONE,0)>0 then
				Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
function c98710443.sdcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(98710443)==0
end
function c98710443.sdop(e,tp,eg,ep,ev,re,r,rp) 
	e:GetHandler():CopyEffect(98710442,RESET_EVENT+0x1fe0000)
	e:GetHandler():RegisterFlagEffect(98710443,RESET_EVENT+0x1fe0000,0,1)
end
function c98710443.cfilter1(c)
return c:IsFaceup() and c:IsCode(98710440)
end
function c98710443.cfilter2(c)
return c:IsFaceup() and c:IsCode(98710441)
end
function c98710443.cfilter3(c)
return c:IsFaceup() and c:IsCode(98710442)
end
function c98710443.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c98710443.cfilter1,tp,LOCATION_ONFIELD,0,1,nil) and Duel.IsExistingMatchingCard(c98710443.cfilter2,tp,LOCATION_ONFIELD,0,1,nil) and Duel.IsExistingMatchingCard(c98710443.cfilter3,tp,LOCATION_ONFIELD,0,1,nil)
end
function c98710443.motg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return (Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_SZONE,0)>0 and Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)~=nil) or (Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_SZONE,0)>1 and Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)==nil) end
end
function c98710443.moop(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	Duel.MoveToField(c,tp,tp,LOCATION_FZONE,POS_FACEUP,true)
end
function c98710443.moop2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if (Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_SZONE,0)>0 and Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)~=nil) or (Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_SZONE,0)>1 and Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)==nil) then
	Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
end
end
function c98710443.filter1(c,e,tp)
return c:IsCode(98710440) and Duel.IsExistingMatchingCard(c98710443.filter2,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp)
end
function c98710443.filter2(c,e,tp)
return c:IsCode(98710441) and Duel.IsExistingMatchingCard(c98710443.filter3,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp)
end
function c98710443.filter3(c,e,tp)
return c:IsCode(98710442)
end
function c98710443.cotg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return (Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_SZONE,0)>=2 and Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)~=nil) or (Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_SZONE,0)>=3 and Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)==nil) and Duel.IsExistingMatchingCard(c98710443.filter1,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
end
function c98710443.coop(e,tp,eg,ep,ev,re,r,rp,chk)
	if (Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_SZONE,0)>=2 and Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)~=nil) or (Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_SZONE,0)>=3 and Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)==nil) then
	local g1=Duel.GetMatchingGroup(c98710443.filter1,e:GetHandler():GetControler(),LOCATION_DECK+LOCATION_HAND,0,nil)
	local g2=Duel.GetMatchingGroup(c98710443.filter2,e:GetHandler():GetControler(),LOCATION_DECK+LOCATION_HAND,0,nil)
	local g3=Duel.GetMatchingGroup(c98710443.filter3,e:GetHandler():GetControler(),LOCATION_DECK+LOCATION_HAND,0,nil)
	Duel.MoveToField(g1:GetFirst(),tp,tp,LOCATION_FZONE,POS_FACEUP,true)
	Duel.MoveToField(g2:GetFirst(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Duel.MoveToField(g3:GetFirst(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
end
end