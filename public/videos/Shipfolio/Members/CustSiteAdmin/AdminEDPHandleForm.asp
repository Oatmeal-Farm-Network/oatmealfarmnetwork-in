<%@ LANGUAGE="VBSCRIPT" %><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
 <base target="_self" />
 <!--#Include file="AdminGlobalVariables.asp"--> 
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
%>

<%
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
response.write("SFAcc=" & SFAcc & "<br>")
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
EPDDate =   Request.Form("EPDDate")


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



if len(trim(AFDRank2)) > 0 then
else
AFDRank2 = 0
end if

if len(SDAFDRank) > 0 then
else
SDAFDRank = 0
end if

if len(SDAFDRank2) > 0 then
else
SDAFDRank2 = 0
end if

if len(percentFGreaterThan30Rank) > 0 then
else
percentFGreaterThan30Rank = 0
end if

if len(percentFGreaterThan30Rank2) > 0 then
else
percentFGreaterThan30Rank2 = 0
end if

if len(MCRank) > 0 then
else
MCRank = 0
end if

if len(MCRank2) > 0 then
else
MCRank2 = 0
end if



if len(PercentMRank) > 0 then
else
PercentMRank = 0
end if
if len(PercentMRank2) > 0 then
else
PercentMRank2 = 0
end if


if len(MSLRank) > 0 then
else
MSLRank = 0
end if
if len(MSLRank2) > 0 then
else
MSLRank2 = 0
end if


if len(FWRank) > 0 then
else
FWRank = 0
end if
if len(FWRank2) > 0 then
else
FWRank2 = 0
end if

if len(SDMCRank) > 0 then
else
SDMCRank = 0
end if
if len(SDMCRank2) > 0 then
else
SDMCRank2 = 0
end if

if len(SFRank) > 0 then
else
SFRank = 0
end if
if len(SFRank2) > 0 then
else
SFRank2 = 0
end if

Query =  " UPDATE EPDAlpacas Set AFD = '" &  AFD & "', " 
Query =  Query & "AFDAcc = '" &  AFDAcc & "', " 
if len(AFDRank) > 0 then
    if AFDRank > 0 then
    Query =  Query & "AFDRank = " &  AFDRank & ", " 
    else
    Query =  Query & "AFDRank = 0, " 
    end if
else
Query =  Query & "AFDRank = 0, " 
end if

if len(AFDRank2) > 0 then
    if AFDRank2 > 0 then
    Query =  Query & "AFDRank2 = " &  AFDRank2 & ", " 
    else
    Query =  Query & "AFDRank2 = 0, " 
    end if
else
Query =  Query & "AFDRank2 = 0, " 
end if



Query =  Query & "SDAFD = '" &  SDAFD & "', " 
Query =  Query & "SDAFDAcc = '" &  SDAFDAcc & "', " 

if len(SDAFDRank) > 0 then
    if SDAFDRank > 0 then
    Query =  Query & "SDAFDRank = " &  SDAFDRank & ", " 
    else
    Query =  Query & "SDAFDRank = 0, " 
    end if
else
Query =  Query & "SDAFDRank = 0, " 
end if

if len(SDAFDRank2) > 0 then
    if SDAFDRank2 > 0 then
    Query =  Query & "SDAFDRank2 = " &  SDAFDRank2 & ", " 
    else
    Query =  Query & "SDAFDRank2 = 0, " 
    end if
else
Query =  Query & "SDAFDRank2 = 0, " 
end if

Query =  Query & "SF = '" &  SF & "', " 
Query =  Query & "SFAcc = '" &  SFAcc & "', " 

if len(SFRank) > 0 then
    if SFRank > 0 then
    Query =  Query & "SFRank = " &  SFRank & ", " 
    else
    Query =  Query & "SFRank = 0, " 
    end if
else
Query =  Query & "SFRank = 0, " 
end if

if len(SFRank2) > 0 then
    if SFRank2 > 0 then
    Query =  Query & "SFRank2 = " &  SFRank2 & ", " 
    else
    Query =  Query & "SFRank2 = 0, " 
    end if
else
Query =  Query & "SFRank2 = 0, " 
end if


Query =  Query & "PercentFGreaterThan30 = '" &  PercentFGreaterThan30 & "', " 
Query =  Query & "percentFgreaterThan30Acc = '" &  percentFgreaterThan30Acc & "', " 

if len(percentFGreaterThan30Rank) > 0 then
    if percentFGreaterThan30Rank > 0 then
    Query =  Query & "percentFGreaterThan30Rank = " &  percentFGreaterThan30Rank & ", " 
    else
    Query =  Query & "percentFGreaterThan30Rank = 0, " 
    end if
else
Query =  Query & "percentFGreaterThan30Rank = 0, " 
end if

if len(percentFGreaterThan30Rank2) > 0 then
    if percentFGreaterThan30Rank2 > 0 then
    Query =  Query & "percentFGreaterThan30Rank2 = " &  percentFGreaterThan30Rank2 & ", " 
    else
    Query =  Query & "percentFGreaterThan30Rank2 = 0, " 
    end if
else
Query =  Query & "percentFGreaterThan30Rank2 = 0, " 
end if


Query =  Query & "MC= '" &  MC & "', " 
Query =  Query & "MCAcc = '" &  MCAcc & "', " 

if len(MCRank) > 0 then
    if MCRank > 0 then
    Query =  Query & "MCRank = " &  MCRank & ", " 
    else
    Query =  Query & "MCRank = 0, " 
    end if
else
Query =  Query & "MCRank = 0, " 
end if

if len(MCRank2) > 0 then
    if MCRank2 > 0 then
    Query =  Query & "MCRank2 = " &  MCRank2 & ", " 
    else
    Query =  Query & " MCRank2 = 0, " 
    end if
else
Query =  Query & " MCRank2 = 0, " 
end if


Query =  Query & "SDMC = '" &  SDMC & "', " 
Query =  Query & "SDMCAcc = '" &  SDMCAcc & "', " 

if len(SDMCRank) > 0 then
    if SDMCRank > 0 then
    Query =  Query & " SDMCRank = " &  SDMCRank & ", " 
    else
    Query =  Query & " SDMCRank = 0, " 
    end if
else
Query =  Query & " SDMCRank = 0, " 
end if

if len(SDMCRank2) > 0 then
    if SDMCRank2 > 0 then
    Query =  Query & " SDMCRank2 = " &  SDMCRank2 & ", " 
    else
    Query =  Query & " SDMCRank2 = 0, " 
    end if
else
Query =  Query & " SDMCRank2 = 0, " 
end if



Query =  Query & "PercentM = '" &  PercentM & "', " 
Query =  Query & "PercentMAcc = '" &  PercentMAcc & "', " 

if len(PercentMRank) > 0 then
    if PercentMRank > 0 then
    Query =  Query & " PercentMRank = " &  PercentMRank & ", " 
    else
    Query =  Query & " PercentMRank = 0, " 
    end if
else
Query =  Query & " PercentMRank = 0, " 
end if

if len(PercentMRank2) > 0 then
    if PercentMRank2 > 0 then
    Query =  Query & " PercentMRank2 = " &  PercentMRank2 & ", " 
    else
    Query =  Query & " PercentMRank2 = 0, " 
    end if
else
Query =  Query & " PercentMRank2 = 0, " 
end if



Query =  Query & "MSL = '" &  MSL  & "', " 
Query =  Query & "MSLAcc= '" &  MSLAcc  & "', " 

if len(MSLRank) > 0 then
    if MSLRank > 0 then
    Query =  Query & " MSLRank = " &  MSLRank & ", " 
    else
    Query =  Query & " MSLRank = 0, " 
    end if
else
Query =  Query & " MSLRank = 0, " 
end if

if len(MSLRank2) > 0 then
    if MSLRank2 > 0 then
    Query =  Query & " MSLRank2 = " &  MSLRank2 & ", " 
    else
    Query =  Query & " MSLRank2 = 0, " 
    end if
else
Query =  Query & " MSLRank2 = 0, " 
end if


Query =  Query & "FW = '" &  FW  & "', " 
Query =  Query & "FWAcc = '" & FWAcc  & "', " 

if len(FWRank) > 0 then
    if FWRank > 0 then
    Query =  Query & " FWRank = " &  FWRank & ", " 
    else
    Query =  Query & " FWRank = 0, " 
    end if
else
Query =  Query & " FWRank = 0, " 
end if

if len(FWRank2) > 0 then
    if FWRank2 > 0 then
    Query =  Query & " FWRank2 = " &  FWRank2 & " " 
    else
    Query =  Query & " FWRank2 = 0 " 
    end if
else
Query =  Query & " FWRank2 = 0, " 
end if


Query =  Query & " where AnimalID = " & AnimalID & ";" 
response.Write("Query=" & Query)
conn.Execute(Query) 
Conn.close
set Conn = nothing 
response.redirect("AdminAlpacaEPDFrame.asp?ID=" & AnimalID & "&changesmade=True")
%>
 </Body>
</HTML>
