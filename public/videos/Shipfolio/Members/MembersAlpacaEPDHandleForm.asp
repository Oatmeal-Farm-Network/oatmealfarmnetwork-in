<%@ LANGUAGE="VBSCRIPT" %><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
 <base target="_self" />
 <!--#Include virtual="/Conn.asp"--> 
</head>
<BODY >
<% 
Function RemoveChars(temprank)
if len(temprank) > 1 then
For loopi=1 to Len(temprank)
    spec = Mid(temprank, loopi, 1)
    if len(spec)> 0 then
    specchar = ASC(spec)
    if (specchar < 48 or specchar > 57) and not specchar=45 and not specchar=46 then
    	temprank= Replace(temprank,  spec, "")
        loopi = loopi - 1
   end if
   end if
 Next
end if
RemoveChars = temprank
end function

AnimalID=   Request.Form("AnimalID")
AFD =   Request.Form("AFD")
AFDAcc =   Request.Form("AFDAcc")
AFDRank =   Request.Form("AFDRank")
AFDRank2 =   Request.Form("AFDRank2")
SDAFD =   Request.Form("SDAFD")
SDAFDAcc =   Request.Form("SDAFDAcc")
SDAFDRank =   Request.Form("SDAFDRank")
SDAFDRank2 =   Request.Form("SDAFDRank2")
SF =   Request.Form("SF")
SFAcc =   Request.Form("SFAcc")
SFRank =   Request.Form("SFRank")
SFRank2 =   Request.Form("SFRank2")
PercentFGreaterThan30 =   Request.Form("PercentFGreaterThan30")
percentFgreaterThan30Acc =   Request.Form("percentFgreaterThan30Acc")
percentFGreaterThan30Rank =   Request.Form("percentFGreaterThan30Rank")
percentFGreaterThan30Rank2 =   Request.Form("percentFGreaterThan30Rank2")
MC =   Request.Form("MC")
MCAcc =   Request.Form("MCAcc")
MCRank =   Request.Form("MCRank")
MCRank2 =   Request.Form("MCRank2")
SDMC =   Request.Form("SDMC")
SDMCAcc =   Request.Form("SDMCAcc")
SDMCRank =   Request.Form("SDMCRank")
SDMCRank2 =   Request.Form("SDMCRank2")
PercentM =   Request.Form("PercentM")
PercentMAcc =   Request.Form("PercentMAcc")
PercentMRank =   Request.Form("PercentMRank")
PercentMRank2 =   Request.Form("PercentMRank2")
MSL =   Request.Form("MSL")
MSLAcc =   Request.Form("MSLAcc")
MSLRank =   Request.Form("MSLRank")
MSLRank2 =   Request.Form("MSLRank2")
FW =   Request.Form("FW")
FWAcc =   Request.Form("FWAcc")
FWRank =   Request.Form("FWRank")
FWRank2 =   Request.Form("FWRank2")
BW =   Request.Form("BW")
BWAcc =   Request.Form("BWAcc")
EPDDate = Request.Form("EPDDate")

PercentMRankPercent = request.form("PercentMRankPercent")
MSLRankpercent = request.form("MSLRankpercent")
SFRankPercent = request.Form("SFRankPercent")
SDAFDPercent =  Request.Form("SDAFDPercent")
AFDPercent = Request.Form("AFDPercent")
response.write("AFDPercent1=" & AFDPercent )


percentFGreaterThan30Percent =  Request.Form("percentFGreaterThan30Percent")
MCRankPercent = Request.Form("MCRankPercent")
SDMCRankPercent =  Request.Form("SDMCRankPercent")
MCRankPercent =  Request.Form("MCRankPercent")
FWRankPercent = Request.Form("FWRankPercent")
BWAccPercent = Request.Form("BWAccPercent")



PercentMRankPercent = removeChars(PercentMRankPercent)
SFRankPercent = removeChars(SFRankPercent)
AFDRank = RemoveChars(AFDRank)
AFDRank2 = RemoveChars(AFDRank2)

SDAFDRank = RemoveChars(SDAFDRank)
SDAFDRank2 = RemoveChars(SDAFDRank2)

percentFGreaterThan30Rank = RemoveChars(percentFGreaterThan30Rank)
percentFGreaterThan30Rank2 = RemoveChars(percentFGreaterThan30Rank2)

MCRank = RemoveChars(MCRank)
MCRank2 = RemoveChars(MCRank2)

PercentMRank = RemoveChars(PercentMRank)
PercentMRank2 = RemoveChars(PercentMRank2)

MSLRank = RemoveChars(MSLRank)
MSLRank2 = RemoveChars(MSLRank2)

FWRank = RemoveChars(FWRank)
FWRank2 = RemoveChars(FWRank2)

SDMCRank = RemoveChars(SDMCRank)
SDMCRank2 = RemoveChars(SDMCRank2)

MSLRankpercent= RemoveChars(MSLRankpercent)
SDAFDPercent =  RemoveChars(SDAFDPercent)
AFDPercent = RemoveChars(AFDPercent)
response.write("AFDPercent=" & AFDPercent )

percentFGreaterThan30Percent = RemoveChars(percentFGreaterThan30Percent)
MCRankPercent = RemoveChars(MCRankPercent)
SDMCRankPercent = RemoveChars(SDMCRankPercent)
MCRankPercent =  RemoveChars(MCRankPercent)
FWRankPercent = RemoveChars(FWRankPercent)
BWAccPercent = RemoveChars(BWAccPercent)


Query =  " UPDATE EPDAlpacas Set AFD = '" &  AFD & "', " 
Query =  Query & "AFDAcc = '" &  AFDAcc & "', " 

if len(PercentMRankPercent) > 0 then
Query =  Query & "PercentMRankPercent = " &  PercentMRankPercent & ", " 
else
Query =  Query & "PercentMRankPercent = NULL , " 
end if

if len(MSLRankpercent) > 0 then
Query =  Query & "MSLRankpercent = " &  MSLRankpercent & ", " 
else
Query =  Query & "MSLRankpercent = NULL , " 
end if


if len(SFRankPercent) > 0 then
Query =  Query & "SFRankPercent = " &  SFRankPercent & ", " 
else
Query =  Query & "SFRankPercent = NULL , " 
end if

if len(SDAFDPercent) > 0 then
Query =  Query & "SDAFDPercent = " &  SDAFDPercent & ", " 
else
Query =  Query & "SDAFDPercent = NULL , " 
end if

if len(AFDPercent) > 0 then
Query =  Query & "AFDPercent = " &  AFDPercent & ", " 
else
Query =  Query & "AFDPercent = NULL , " 
end if

if len(percentFGreaterThan30Percent) > 0 then
Query =  Query & "percentFGreaterThan30Percent = " &  percentFGreaterThan30Percent & ", " 
else
Query =  Query & "percentFGreaterThan30Percent = NULL , " 
end if

if len(MCRankPercent) > 0 then
Query =  Query & "MCRankPercent = " &  MCRankPercent & ", " 
else
Query =  Query & "MCRankPercent = NULL , " 
end if

if len(SDMCRankPercent) > 0 then
Query =  Query & "SDMCRankPercent = " &  SDMCRankPercent & ", " 
else
Query =  Query & "SDMCRankPercent = NULL , " 
end if


if len(FWRankPercent) > 0 then
Query =  Query & "FWRankPercent = " & FWRankPercent & ", " 
else
Query =  Query & "FWRankPercent = NULL , " 
end if

if len(BWAccPercent) > 0 then
Query =  Query & "BWAccPercent = " & BWAccPercent & ", " 
else
Query =  Query & "BWAccPercent = NULL , " 
end if

if len(AFDRank) > 0 then
Query =  Query & "AFDRank = " & AFDRank & ", " 
else
Query =  Query & "AFDRank = NULL , " 
end if

if len(AFDRank2) > 0 then
Query =  Query & "AFDRank2 = " & AFDRank2 & ", " 
else
Query =  Query & "AFDRank2 = NULL , " 
end if

if len(SDAFD) > 0 then
Query =  Query & "SDAFD = " & SDAFD & ", " 
else
Query =  Query & "SDAFD = NULL , " 
end if

if len(SDAFDAcc) > 0 then
Query =  Query & "SDAFDAcc = " & SDAFDAcc & ", " 
else
Query =  Query & "SDAFDAcc = NULL , " 
end if

if len(SDAFDRank) > 0 then
Query =  Query & "SDAFDRank = " & SDAFDRank & ", " 
else
Query =  Query & "SDAFDRank = NULL , " 
end if

if len(SDAFDRank2) > 0 then
Query =  Query & "SDAFDRank2 = " & SDAFDRank2 & ", " 
else
Query =  Query & "SDAFDRank2 = NULL , " 
end if


Query =  Query & "SF = '" &  SF & "', " 
Query =  Query & "SFAcc = '" &  SFAcc & "', " 

if len(SFRank) > 0 then
Query =  Query & "SFRank = " & SFRank & ", " 
else
Query =  Query & "SFRank = NULL , " 
end if

if len(SFRank2) > 0 then
Query =  Query & "SFRank2 = " & SFRank2 & ", " 
else
Query =  Query & "SFRank2 = NULL , " 
end if

Query =  Query & "PercentFGreaterThan30 = '" &  PercentFGreaterThan30 & "', " 
Query =  Query & "percentFgreaterThan30Acc = '" &  percentFgreaterThan30Acc & "', " 

if len(percentFGreaterThan30Rank) > 0 then
Query =  Query & "percentFGreaterThan30Rank = " & percentFGreaterThan30Rank & ", " 
else
Query =  Query & "percentFGreaterThan30Rank = NULL , " 
end if

if len(percentFGreaterThan30Rank2) > 0 then
Query =  Query & "percentFGreaterThan30Rank2 = " & percentFGreaterThan30Rank2 & ", " 
else
Query =  Query & "percentFGreaterThan30Rank2 = NULL , " 
end if

Query =  Query & "MC= '" &  MC & "', " 
Query =  Query & "MCAcc = '" &  MCAcc & "', " 
if len(MCRank) > 0 then
Query =  Query & "MCRank = " & MCRank & ", " 
else
Query =  Query & "MCRank = NULL , " 
end if

if len(MCRank2) > 0 then
Query =  Query & "MCRank2 = " & MCRank2 & ", " 
else
Query =  Query & "MCRank2 = NULL , " 
end if

Query =  Query & "SDMC = '" &  SDMC & "', " 
Query =  Query & "SDMCAcc = '" &  SDMCAcc & "', " 

if len(SDMCRank) > 0 then
Query =  Query & "SDMCRank = " & SDMCRank & ", " 
else
Query =  Query & "SDMCRank = NULL , " 
end if

if len(SDMCRank2) > 0 then
Query =  Query & "SDMCRank2 = " & SDMCRank2 & ", " 
else
Query =  Query & "SDMCRank2 = NULL , " 
end if

Query =  Query & "PercentM = '" &  PercentM & "', " 
Query =  Query & "PercentMAcc = '" &  PercentMAcc & "', " 

if len(PercentMRank) > 0 then
Query =  Query & "PercentMRank = " & PercentMRank & ", " 
else
Query =  Query & "PercentMRank = NULL , " 
end if

if len(PercentMRank2) > 0 then
Query =  Query & "PercentMRank2 = " & PercentMRank2 & ", " 
else
Query =  Query & "PercentMRank2 = NULL , " 
end if


Query =  Query & "MSL = '" &  MSL  & "', " 
Query =  Query & "MSLAcc= '" &  MSLAcc  & "', " 

if len(MSLRank) > 0 then
Query =  Query & "MSLRank = " & MSLRank & ", " 
else
Query =  Query & "MSLRank = NULL , " 
end if

if len(MSLRank2) > 0 then
Query =  Query & "MSLRank2 = " & MSLRank2 & ", " 
else
Query =  Query & "MSLRank2 = NULL , " 
end if

Query =  Query & "FW = '" &  FW  & "', " 
Query =  Query & "FWAcc = '" & FWAcc  & "', " 

if len(FWRank) > 0 then
Query =  Query & "FWRank = " & FWRank & ", " 
else
Query =  Query & "FWRank = NULL , " 
end if

if len(FWRank2) > 0 then
Query =  Query & "FWRank2 = " & FWRank2 & " " 
else
Query =  Query & "FWRank2 = NULL  " 
end if
Query =  Query & " where AnimalID = " & AnimalID & ";" 
'response.Write("Query2=" & Query)
conn.Execute(Query) 

Query =  " UPDATE Animals Set Lastupdated = getdate() " 
Query =  Query & " where ID = " & AnimalID & ";" 


Conn.Execute(Query) 
Conn.close
set Conn = nothing 
response.redirect("MembersAlpacaEPDFrame.asp?ID=" & AnimalID & "&changesmade=True")
%>




 </Body>
</HTML>
