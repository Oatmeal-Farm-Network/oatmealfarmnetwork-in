<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
 <base target="_self" />
<link rel="stylesheet" type="text/css" href="/style.css">
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
<!--#Include file="Membersglobalvariables.asp"-->
<%
Dim FiberID(1000)
Dim FullName(1000)
Dim SampleDate(1000)
Dim SampleDateMonth(1000)
Dim SampleDateDay(1000)
Dim SampleDateYear(1000)
Dim Average(1000)
Dim StandardDev(1000) 
Dim COV(1000) 
Dim GreaterThan30(1000) 
Dim CF(1000)
Dim Curve(1000) 
Dim ShearWeight(1000)
Dim BlanketWeight(1000)
Dim Length(1000) 
Dim CrimpPerInch(1000)
	
ID = Request.Form("ID")
TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
rowcount = 1

while (rowcount < TotalCount)
	IDArraycount = "IDArray(" & rowcount & ")"	
	FiberIDcount = "FiberID(" & rowcount & ")"	
	FullNamecount = "FullName(" & rowcount & ")"
	SampleDateDaycount = "SampleDateDay(" & rowcount & ")"
		SampleDateMonthcount = "SampleDateMonth(" & rowcount & ")"
			SampleDateYearcount = "SampleDateYear(" & rowcount & ")"

	Averagecount = "Average(" & rowcount & ")"
	StandardDevcount = "StandardDev(" & rowcount & ")"
	COVcount = "COV(" & rowcount & ")"
	GreaterThan30count = "GreaterThan30(" & rowcount & ")"
	CFcount = "CF(" & rowcount & ")"
	Curvecount = "Curve(" & rowcount & ")"
	ShearWeightcount = "ShearWeight(" & rowcount & ")"
	BlanketWeightcount = "BlanketWeight(" & rowcount & ")"
	Lengthcount = "Length(" & rowcount & ")"
	Curvecount = "Curve(" & rowcount & ")"
	CrimpPerInchcount = "CrimpPerInch(" & rowcount & ")"

	IDArray(rowcount)=Request.Form(IDArraycount)
	FiberID(rowcount)=Request.Form(FiberIDcount) 
	FullName(rowcount)=Request.Form(FullNamecount) 
	SampleDateDay(rowcount)=Request.Form(SampleDateDaycount )
	SampleDateMonth(rowcount)=Request.Form(SampleDateMonthcount )
	SampleDateYear(rowcount)=Request.Form(SampleDateYearcount )
	Average(rowcount)=Request.Form(Averagecount) 
	StandardDev(rowcount)=Request.Form(StandardDevcount) 
	COV(rowcount)=Request.Form(COVcount) 
	GreaterThan30(rowcount)=Request.Form(GreaterThan30count) 
	CF(rowcount)=Request.Form(CFcount) 
	Curve(rowcount)=Request.Form(Curvecount) 
	ShearWeight(rowcount)=Request.Form(ShearWeightcount) 
	BlanketWeight(rowcount)=Request.Form(BlanketWeightcount) 
	Length(rowcount)=Request.Form(Lengthcount) 
	CrimpPerInch(rowcount)=Request.Form(CrimpPerInchcount) 

	rowcount = rowcount +1
Wend

 rowcount =1

while (rowcount < TotalCount)


	Query =  " UPDATE Fiber Set Average = '" &  Average(rowcount) & "'," 
	if len(SampleDateDay(rowcount)) > 1 then
	Query =  Query & "SampleDateDay = " &  SampleDateDay(rowcount) & ", " 
	end if
	if len(SampleDateMonth(rowcount) ) > 1 then
	Query =  Query & "SampleDateMonth = " &  SampleDateMonth(rowcount) & ", "
	end if
	if len(SampleDateYear(rowcount)) > 1 then 
	Query =  Query & "SampleDateYear = " &  SampleDateYear(rowcount) & ", " 
    else
    Query =  Query & "SampleDateYear = 0, " 
	end if
    Query =  Query & " StandardDev = '" &   StandardDev(rowcount) & "'," 
    Query =  Query & " COV = '" &  COV(rowcount) & "'," 
    Query =  Query & " GreaterThan30 = '"  &  GreaterThan30(rowcount) & "'," 
	Query =  Query & " CF = '" &  CF(rowcount) & "'," 
    Query =  Query & " Curve = '"  &  Curve(rowcount) & "'," 
	 Query =  Query & " ShearWeight = '"  &  ShearWeight(rowcount) & "'," 
    Query =  Query & " BlanketWeight = '"  &  BlanketWeight(rowcount) & "'," 
	Query =  Query & " Length = '"  &  Length(rowcount) & "'," 
	Query =  Query & " CrimpPerInch = '"  &  CrimpPerInch(rowcount) & "'," 
    Query =  Query & "  ID = " & IDArray(rowcount) & " " 
	Query =  Query & " where FiberID = " & FiberID(rowcount) & ";" 

connLOA.Execute(Query) 
rowcount= rowcount +1
Wend

Query =  " UPDATE Animals  Set Lastupdated = getdate() " 
Query =  Query & " where ID = " & ID & ";" 
'response.write(Query)	
connLOA.Execute(Query) 

connLOA.Close
Set connLOA = Nothing 
response.redirect("MembersFiberFrame.asp?ID=" & ID & "&changesmade=True")
%>
 </Body>
</HTML>
