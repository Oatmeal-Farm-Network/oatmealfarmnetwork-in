<%' Animals
str1 = SourceStudDescription
str2 = "'"
If InStr(str1,str2) > 0 Then
SourceStudDescription= Replace(str1, "'", "''")
End If
str1 = SourceDescription
str2 = "'"
If InStr(str1,str2) > 0 Then
SourceDescription= Replace(str1, "'", "''")
End If
str1 = SourcePriceComments
str2 = "'"
If InStr(str1,str2) > 0 Then
SourcePriceComments= Replace(str1, "'", "''")
End If
If Len(SourceDOBday)> 0 Then
else
SourceDOBday = 0
End If 
If Len(SourceDOBMonth)> 0 Then
else
SourceDOBMonth = 0
End If 
If Len(SourceDOBYear)> 0 Then
else
SourceDOBYear = 0
End If
if SourceSpeciesID = 2 then
end if
sql = "select AnimalRegistrationID from Animalregistration Order by AnimalRegistrationID DESC  ;" 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, ConnLOA, 3, 3   
If Not rs.eof Then
AnimalRegistrationID = rs("AnimalRegistrationID")
End if
rs.close
ConnLOA.Close
set ConnLOA = Nothing %>
<!--#Include virtual="/ConnLOA.asp"--> 
<% 
if SourceForSale = "False" then
SourceForSale = 1 
else
SourceForSale = 0
end if

Query =  "INSERT INTO Animals(peopleID, PublishForsale, Publishstud, SpeciesID, FullName, ShortName, Category, CLAA, DOBday,  DOBMonth, DOBYear, Weight, Height, Gaited, Warmblooded, "

if len(SourceTemperment) > 0 then
Query = Query & " Temperment,"
end if

if len(SourceBreedLookupID) > 0 then
Query = Query & " BreedID,"
end if

if len(SourceBreedID2) > 0 then
Query = Query & " BreedID2,"
end if

if len(SourceBreedID3) > 0 then
Query = Query & " BreedID3,"
end if

if len(SourceBreedID4) > 0 then
Query = Query & " BreedID4,"
end if

Query = Query & " ExternalLink, Description, StudDescription, Owner )" 

Query =  Query & " Values ('" &  Session("AIID") & "' ,"
Query =  Query &   " " & SourceForSale & " ,"
if len(SourceStudFee) > 1 then
Query =  Query &   " 1 ,"
else
Query =  Query &   " 0 ,"
end if
Query =  Query &   " " & SourceSpeciesID & " ,"
Query =  Query &   " '" & SourceFullName & "' ,"
Query =  Query &   " '" & SourceShortName & "' ,"
Query =  Query &   " '" & SourceCategory & "' ,"
Query =  Query &   " '" & SourceCLAA & "' ,"
Query =  Query &   " " & SourceDOBday & " ,"
Query =  Query &   " " & SourceDOBMonth & " ,"
Query =  Query &   " " & SourceDOBYear & " ,"

Query =  Query &   " '" & SourceWeight & "' ,"
Query =  Query &   " '" & SourceHeight & "' ,"
Query =  Query &   " '" & SourceGaited & "' ,"
Query =  Query &   " '" & SourceWarmblooded & "' ,"

if len(SourceTemperment) > 0 then
Query =  Query &   " " & SourceTemperment & " ,"
end if

if len(SourceBreedLookupID) > 0 then
Query =  Query &   " " & SourceBreedLookupID & " ,"
end if

if len(SourceBreedID2) > 0 then
Query =  Query &   " " & SourceBreedID2 & " ,"
end if
if len(SourceBreedID3) > 0 then
Query =  Query &   " " & SourceBreedID3 & " ,"
end if
if len(SourceBreedID4) > 0 then
Query =  Query &   " " & SourceBreedID4 & " ,"
end if


Query =  Query &   " '" & SourceExternalLink & "' ,"
Query =  Query &   " '" & SourceDescription & "' ,"
Query =  Query &   " '" & SourceStudDescription & "' ,"
Query =  Query &   " '" & SourceOwner  & "' )" 
'response.write("Query=" & Query )
ConnLOA.Execute(Query) 
'ConnLOA.Close
'set ConnLOA = Nothing %>
 
<% Found = False
sql = "select ID from Animals where  peopleID= " &  session("AIID") & " order by ID Desc;" 
rs.Open sql, ConnLOA, 3, 3  
AnimalID = rs("ID") 
If rs.eof Then
else
AnimalID = rs("ID")
Found = True
End if
rs.close

str1 = SourceDam
str2 = "'"
If InStr(str1,str2) > 0 Then
	SourceDam = Replace(str1, "'", "''")
End If
str1 = SourceDamDam
str2 = "'"
If InStr(str1,str2) > 0 Then
	SourceDamDam = Replace(str1, "'", "''")
End If
str1 = SourceDamDamDam
str2 = "'"
If InStr(str1,str2) > 0 Then
	SourceDamDamDam = Replace(str1, "'", "''")
End If
str1 = SourceDamDamSire
str2 = "'"
If InStr(str1,str2) > 0 Then
	SourceDamDamSire = Replace(str1, "'", "''")
End If
str1 = SourceDamSire
str2 = "'"
If InStr(str1,str2) > 0 Then
	SourceDamSire = Replace(str1, "'", "''")
End If
str1 = SourceDamSireDam
str2 = "'"
If InStr(str1,str2) > 0 Then
	SourceDamSireDam = Replace(str1, "'", "''")
End If

str1 = SourceDamSireSire
str2 = "'"
If InStr(str1,str2) > 0 Then
	SourceDamSireSire= Replace(str1, "'", "''")
End If
str1 = SourceSireDam
str2 = "'"
If InStr(str1,str2) > 0 Then
	SourceSireDam= Replace(str1, "'", "''")
End If

str1 = SourceSireDamDam
str2 = "'"
If InStr(str1,str2) > 0 Then
	SourceSireDamDam= Replace(str1, "'", "''")
End If
str1 = SourceSiresire
str2 = "'"
If InStr(str1,str2) > 0 Then
	SourceSiresire= Replace(str1, "'", "''")
End If
str1 = SourceSireDamSire
str2 = "'"
If InStr(str1,str2) > 0 Then
	SourceSireDamSire= Replace(str1, "'", "''")
End If
str1 = SourceSireSireDam
str2 = "'"
If InStr(str1,str2) > 0 Then
SourceSireSireDam= Replace(str1, "'", "''")
End If
str1 = SourceSireSireSire
str2 = "'"
If InStr(str1,str2) > 0 Then
SourceSireSireDam= Replace(str1, "'", "''")
End If

noancestors = False
sql = "select * from Ancestors where ID = " &  ID & ";" 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, ConnLOA, 3, 3   
If rs.eof Then
noancestors = True 
End If 
rs.close

if	noancestors = True then
str1 = SourceSire
str2 = "'"
If InStr(str1,str2) > 0 Then
	SourceSire= Replace(str1, "'", "''")
End If

Query =  "INSERT INTO Ancestors(ID, Dam, DamColor, DamARI , DamCLAA, DamLink, Damdam,  DamDamColor, DamDamARI , DamDamCLAA, DamDamLink, Damsire, DamsireARI , DamsireCLAA, DamsireColor, DamsireLink, DamDamDam, DamDamDamARI, DamDamDamCLAA, DamDamDamColor, DamDamDamLink, DamDamSire, DamDamSireARI , DamDamSireCLAA, DamDamSireColor, DamDamSireLink, DamSireDam, DamSireDamARI, DamSireDamCLAA, DamSireDamColor, DamSireDamLink, DamSireSire, DamSireSireARI, DamSireSireCLAA, DamSireSireColor, DamSireSireLink, Sire,  SireColor, SireARI , SireCLAA, SireLink, Siredam,  SireDamColor, SireDamARI , SireDamCLAA, SireDamLink, Siresire, SiresireARI , SiresireCLAA, SiresireColor, SiresireLink, SireDamDam, SireDamDamARI, SireDamDamCLAA, SireDamDamColor, SireDamDamLink, SireDamSire, SireDamSireARI , SireDamSireCLAA, SireDamSireColor, SireDamSireLink, SireSireDam, SireSireDamARI, SireSireDamCLAA, SireSireDamColor, SireSireDamLink, SireSireSire, SireSireSireARI, SireSireSireCLAA, SireSireSireColor, SireSireSireLink)" 
Query =  Query & " Values (" &  AnimalID & ", "
Query =  Query &   " '" & SourceDam & "' ,"
Query =  Query &   " '" & SourceDamColor & "' ,"
Query =  Query &   " '" & SourceDamARI  & "' ,"
Query =  Query &   " '" & SourceDamCLAA & "' ,"
Query =  Query &   " '" & SourceDamLink & "' ,"
Query =  Query &   " '" & SourceDamdam & "' ,"
Query =  Query &   " '" & SourceDamDamColor & "' ,"
Query =  Query &   " '" & SourceDamDamARI  & "' ,"
Query =  Query &   " '" & SourceDamDamCLAA & "' ,"
Query =  Query &   " '" & SourceDamDamLink & "' ,"
Query =  Query &   " '" & SourceDamsire & "' ,"
Query =  Query &   " '" & SourceDamsireARI & "' ,"
Query =  Query &   " '" & SourceDamsireCLAA  & "' ,"
Query =  Query &   " '" & SourceDamsireColor  & "' ,"		
Query =  Query &   " '" & SourceDamsireLink  & "' ,"		
Query =  Query &   " '" & SourceDamDamDam  & "' ,"		
Query =  Query &   " '" & SourceDamDamDamARI  & "' ,"		
Query =  Query &   " '" & SourceDamDamDamCLAA  & "' ,"		
Query =  Query &   " '" & SourceDamDamDamColor  & "' ,"						
Query =  Query &   " '" & SourceDamDamDamLink  & "' ,"						
Query =  Query &   " '" & SourceDamDamSire  & "' ,"			
Query =  Query &   " '" & SourceDamDamSireARI   & "' ,"						
Query =  Query &   " '" & SourceDamDamSireCLAA  & "' ,"	
Query =  Query &   " '" & SourceDamDamSireColor  & "' ,"			
Query =  Query &   " '" & SourceDamDamSireLink  & "' ,"	
Query =  Query &   " '" & SourceDamSireDam  & "' ,"	
Query =  Query &   " '" & SourceDamSireDamARI  & "' ,"	
Query =  Query &   " '" & SourceDamSireDamCLAA  & "' ,"	
Query =  Query &   " '" & SourceDamSireDamColor  & "' ,"	
Query =  Query &   " '" & SourceDamSireDamLink   & "' ,"	
Query =  Query &   " '" & SourceDamSireSire  & "' ,"	
Query =  Query &   " '" & SourceDamSireSireARI  & "' ,"	
Query =  Query &   " '" & SourceDamSireSireCLAA   & "' ,"	
Query =  Query &   " '" & SourceDamSireSireColor  & "' ,"	
Query =  Query &   " '" & SourceDamSireSireLink  & "' ,"	
Query =  Query &   " '" & SourceSire & "' ,"
Query =  Query &   " '" & SourceSireColor & "' ,"
Query =  Query &   " '" & SourceSireARI  & "' ,"
Query =  Query &   " '" & SourceSireCLAA & "' ,"
Query =  Query &   " '" & SourceSireLink & "' ,"
Query =  Query &   " '" & SourceSiredam & "' ,"
Query =  Query &   " '" & SourceSireDamColor & "' ,"
Query =  Query &   " '" & SourceSireDamARI  & "' ,"
Query =  Query &   " '" & SourceSireDamCLAA & "' ,"
Query =  Query &   " '" & SourceSireDamLink & "' ,"
Query =  Query &   " '" & SourceSiresire & "' ,"
Query =  Query &   " '" & SourceSiresireARI & "' ,"
Query =  Query &   " '" & SourceSiresireCLAA  & "' ,"
Query =  Query &   " '" & SourceSiresireColor  & "' ,"		
Query =  Query &   " '" & SourceSiresireLink  & "' ,"		
Query =  Query &   " '" & SourceSireDamDam  & "' ,"		
Query =  Query &   " '" & SourceSireDamDamARI  & "' ,"		
Query =  Query &   " '" & SourceSireDamDamCLAA  & "' ,"		
Query =  Query &   " '" & SourceSireDamDamColor  & "' ,"						
Query =  Query &   " '" & SourceSireDamDamLink  & "' ,"						
Query =  Query &   " '" & SourceSireDamSire  & "' ,"			
Query =  Query &   " '" & SourceSireDamSireARI   & "' ,"						
Query =  Query &   " '" & SourceSireDamSireCLAA  & "' ,"	
Query =  Query &   " '" & SourceSireDamSireColor  & "' ,"			
Query =  Query &   " '" & SourceSireDamSireLink  & "' ,"	
Query =  Query &   " '" & SourceSireSireDam  & "' ,"	
Query =  Query &   " '" & SourceSireSireDamARI  & "' ,"	
Query =  Query &   " '" & SourceSireSireDamCLAA  & "' ,"	
Query =  Query &   " '" & SourceSireSireDamColor  & "' ,"	
Query =  Query &   " '" & SourceSireSireDamLink   & "' ,"	
Query =  Query &   " '" & SourceSireSireSire  & "' ,"	
Query =  Query &   " '" & SourceSireSireSireARI  & "' ,"	
Query =  Query &   " '" & SourceSireSireSireCLAA   & "' ,"	
Query =  Query &   " '" & SourceSireSireSireColor  & "' ,"	
Query =  Query &   " '" & SourceSireSireSireLink  & "' )" 
ConnLOA.Execute(Query) 
ConnLOA.Close
set ConnLOA = Nothing %>
<!--#Include virtual="/ConnLOA.asp"--> 
<% 
End if
' Update Ancestry Percents
Query =  "INSERT INTO AncestryPercents(ID, PercentUnknownOther, PercentAccoyo, PercentChilean, PercentBolivian, PercentPeruvian )" 
Query =  Query & " Values (" &  AnimalID & ", "
Query =  Query &   " '" & SourcePercentUnknownOther & "' ,"
Query =  Query &   " '" & SourcePercentAccoyo & "' ,"
Query =  Query &   " '" & SourcePercentChilean & "' ,"
Query =  Query &   " '" & SourcePercentBolivian & "' ,"
Query =  Query &   " '" & SourcePercentPeruvian &  "' )" 
Conn.Execute(Query) 
Conn.Close
set Conn = Nothing %>
<!--#Include virtual="/ConnLOA.asp"--> 
<% Query =  " UPDATE Photos Set Photo1 = '" & SourcePhoto1 & "' ,"
if len(SourceARIPhoto) > 0 then
Query =  Query & " ARI = '" & SourceARIPhoto   & "' ,"
end if
if len(SourceHistogramPhoto) > 0 then
Query =  Query & " Histogram = '" & SourceHistogramPhoto   & "' ,"
end if
if len(SourceFiberAnalysisPhoto) > 0 then
Query =  Query & " FiberAnalysis = '" & SourceFiberAnalysisPhoto   & "' ,"
end if
Query =  Query & " Caption1 = '" & SourceCaption1   & "' ,"
Query =  Query & " Photo2 = '" & SourcePhoto2   & "' ,"
Query =  Query & " Caption2 = '" & SourceCaption2   & "' ,"
Query =  Query & " Photo3 = '" & SourcePhoto3   & "' ,"
Query =  Query & " Caption3= '" & SourceCaption3   & "' ,"
Query =  Query & " Photo4 = '" & SourcePhoto4   & "' ,"
Query =  Query & " Caption4 = '" & SourceCaption4   & "' ,"
Query =  Query & " Photo5 = '" & SourcePhoto5   & "' ,"
Query =  Query & " Caption5 = '" & SourceCaption5   & "' ,"
Query =  Query & " Photo6 = '" & SourcePhoto6   & "' ,"
Query =  Query & " Caption6 = '" & SourceCaption6   & "' ,"
Query =  Query & " Photo7 = '" & SourcePhoto7   & "' ,"
Query =  Query & " Caption7 = '" & SourceCaption7   & "' ,"
Query =  Query & " Photo8 = '" & SourcePhoto8   & "' ,"
Query =  Query & " Caption8 = '" & SourceCaption8   & ";" 
' Photos
Query =  "INSERT INTO Photos(ID, Photo1, PhotoCaption1, Photo2, PhotoCaption2, Photo3, PhotoCaption3, Photo4, PhotoCaption4, Photo5, PhotoCaption5, Photo6, PhotoCaption6, Photo7, PhotoCaption7, Photo8, PhotoCaption8)" 
Query =  Query & " Values (" &  AnimalID & ", "
Query =  Query &   " '" & SourcePhoto1 & "' ,"
Query =  Query &   " '" & SourceCaption1 & "' ,"
Query =  Query &   " '" & SourcePhoto2 & "' ,"
Query =  Query &   " '" & SourceCaption2 & "' ,"
Query =  Query &   " '" & SourcePhoto3 & "' ,"
Query =  Query &   " '" & SourceCaption3 & "' ,"
Query =  Query &   " '" & SourcePhoto4 & "' ,"
Query =  Query &   " '" & SourceCaption4 & "' ,"
Query =  Query &   " '" & SourcePhoto5 & "' ,"
Query =  Query &   " '" & SourceCaption5 & "' ,"
Query =  Query &   " '" & SourcePhoto6 & "' ,"
Query =  Query &   " '" & SourceCaption6 & "' ,"
Query =  Query &   " '" & SourcePhoto7 & "' ,"
Query =  Query &   " '" & SourceCaption7 & "' ,"
Query =  Query &   " '" & SourcePhoto8 & "' ,"
Query =  Query &   " '" & SourceCaption8 &   "' )" 
ConnLOA.Execute(Query) 
ConnLOA.Close
set ConnLOA = Nothing %>
<!--#Include virtual="/ConnLOA.asp"--> 
<%  ' Colors
Query =  "INSERT INTO Colors(ID, Color1, Color2, Color3, Color4, Color5 )" 
Query =  Query & " Values (" &  AnimalID & ", "
Query =  Query &   " '" & SourceColor1 & "' ,"
Query =  Query &   " '" & SourceColor2 & "' ,"
Query =  Query &   " '" & SourceColor3 & "' ,"
Query =  Query &   " '" & SourceColor4 & "' ,"
Query =  Query &   " '" & SourceColor5 &  "' )" 
ConnLOA.Execute(Query) 
ConnLOA.Close
set ConnLOA = Nothing %>
<!--#Include virtual="/ConnLOA.asp"--> 
<% 

If Len(SourceStudFee) > 0 Then
Else
  SourceStudFee = 0
 End If 

ConnLOA.Close
set ConnLOA = Nothing %>
<!--#Include virtual="/ConnLOA.asp"--> 

<% 
If SourceFoundation = False then
SourceFoundation = "0"
else
SourceFoundation = "1"
end if

If SourceSold = False then
SourceSold = "0"
else
SourceSold = "1"
end if

If SourceSalePending = False then
SourceSalePending = "0"
else
SourceSalePending = "1"
end if


' Pricing
Query =  "INSERT INTO Pricing(ID, ForSale, StudFee, Price,"
if len(SourceSalePrice) > 0 then
Query =  Query & " SalePrice, "
end if
Query =  Query & "  PriceComments, Foundation, Discount, Sold, SalePending  )" 
Query =  Query & " Values (" &  AnimalID & ", "
Query =  Query &   " " & SourceForSale & " ,"
Query =  Query &   " " & SourceStudFee & " ,"
Query =  Query &   " " & SourcePrice & " ,"
if len(SourceSalePrice) > 0 then
Query =  Query &   " '" & SourceSalePrice & "' ,"
end if
Query =  Query &   " '" & SourcePriceComments & "' ," 
Query =  Query &   " " & SourceFoundation & " ," 
Query =  Query &   " " & SourceDiscount & " ," 
Query =  Query &   " " & SourceSold & " ," 			
Query =  Query &   " " & SourceSalePending 	&  " )" 
'response.write("Query=" & Query )
ConnLOA.Execute(Query) 
ConnLOA.Close
set ConnLOA = Nothing %>
<!--#Include virtual="/ConnLOA.asp"--> 
<% ' Awards 
For rowcount = 1 To 20
If Len(SourceAwardYear(rowcount) ) < 1 Then
SourceAwardYear(rowcount) = "0"
End If
If Len(SourcePlacingNumber(rowcount)  ) < 2 Then
SourcePlacingNumber(rowcount)  = "0"
End If
If Len(SourceShowLevel(rowcount)  ) < 2 Then
SourceShowLevel(rowcount) = "0"
End If
str1 = SourceShow(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
SourceShow(rowcount)= Replace(str1, "'", "''")
End If
 str1 = SourceAwardcomments(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
SourceAwardcomments(rowcount)= Replace(str1, "'", "''")
End If
Query =  "INSERT INTO Awards(ID, ShowName, "
if len(SourceAwardYear(rowcount)) > 0 then
Query = Query & " AwardYear, "
end if
Query = Query & " Type, Placing, Class, Judge,  ShowYear, Awardcomments,  ShowLevel)" 
Query =  Query & " Values (" &  AnimalID & ", "
Query =  Query &   " '" & SourceShow(rowcount) & "' ,"
if len(SourceAwardYear(rowcount)) > 0 then
Query =  Query &   " " & SourceAwardYear(rowcount) & " ,"
end if
Query =  Query &   " '" & SourceType(rowcount) & "' ,"
Query =  Query &   " '" & SourcePlacing(rowcount) & "' ,"
Query =  Query &   " '" & SourceClass(rowcount) & "' ,"
Query =  Query &   " '" & SourceJudge(rowcount) & "' ,"
Query =  Query &   " '" & SourceShowYear(rowcount) & "' ,"
Query =  Query &   " '" & SourceAwardcomments(rowcount) & "' ,"
Query =  Query &   " " & SourceShowLevel(rowcount) & " )" 

ConnLOA.Execute(Query) 
Next
ConnLOA.Close
set ConnLOA = Nothing %>
<!--#Include virtual="/ConnLOA.asp"--> 
<%' Fiber
For rowcount = 1 To 21
				Query =  "INSERT INTO Fiber(ID, SampleDate, SampleAge, Average, StandardDev, COV, GreaterThan30, CF,  Curve, Shearweight,  BlanketWeight, Length, CrimpPerInch, LargeHistogram, SmallHistogram )" 
				Query =  Query & " Values (" &  AnimalID & ", "
				Query =  Query &   " '" & SourceSampleDate(rowcount) & "' ,"
				Query =  Query &   " '" & SourceSampleAge(rowcount) & "' ,"
				Query =  Query &   " '" & SourceAverage(rowcount) & "' ,"
				Query =  Query &   " '" & SourceStandardDev(rowcount) & "' ,"
				Query =  Query &   " '" & SourceCOV(rowcount) & "' ,"
				Query =  Query &   " '" & SourceGreaterThan30(rowcount) & "' ,"
				Query =  Query &   " '" & SourceCF(rowcount) & "' ,"
				Query =  Query &   " '" & SourceCurve(rowcount) & "' ,"
				Query =  Query &   " '" & SourceShearweight(rowcount) & "' ,"
				Query =  Query &   " '" & SourceBlanketWeight(rowcount) & "' ,"
				Query =  Query &   " '" & SourceLength(rowcount) & "' ,"
				Query =  Query &   " '" & SourceCrimpPerInch(rowcount) & "' ,"
				Query =  Query &   " '" & SourceLargeHistogram(rowcount) & "' ,"
				Query =  Query &   " '" & SourceSmallHistogram(rowcount) & "' )" 

ConnLOA.Execute(Query) 
Next
ConnLOA.Close
set ConnLOA = Nothing
%>
<!--#Include virtual="/ConnLOA.asp"--> 
<% Query =  "INSERT INTO EPDAlpacas( AnimalID, SDAFD, SDAFDAcc, "
if len(SourceSDAFDRank) > 0 then
Query = Query &  " SDAFDRank, "
end if
if len(SourceSDAFDRank2) > 0 then
Query = Query & " SDAFDRank2, "
end if
Query = Query &  " SF, SFAcc, "

if len(SourceSFRank) > 0 then
Query = Query &  " SFRank, "
end if
if len(SourceSFRank2) > 0 then
Query = Query &  " SFRank2, "
end if

Query = Query & " PercentFGreaterThan30,   percentFgreaterThan30Acc, "

if len(SourcepercentFGreaterThan30Rank) > 0 then
Query = Query &  " percentFGreaterThan30Rank, "
end if
if len(SourcepercentFGreaterThan30Rank2) > 0 then
Query = Query &  " percentFGreaterThan30Rank2, "
end if

Query = Query & " MC, MCAcc, "

if len(SourceMCRank) > 0 then
Query = Query &  " MCRank, "
end if
if len(SourceMCRank2) > 0 then
Query = Query & " MCRank2, "
end if

Query = Query & " SDMC, SDMCAcc, "

if len(SourceMCRank) > 0 then
Query = Query & " SDMCRank, "
end if
if len(SourceMCRank2) > 0 then
Query = Query & " SDMCRank2, "
end if

Query = Query &  " PercentM, PercentMAcc, "

if len(SourcePercentMRank) > 0 then
Query = Query & " PercentMRank, "
end if
if len(SourcePercentMRank2) > 0 then
Query = Query & " PercentMRank2, "
end if

Query = Query & "  MSL, MSLAcc, "

if len(SourceMSLRank) > 0 then
Query = Query & " MSLRank, "
end if
if len(SourceMSLRank2) > 0 then
Query = Query & " MSLRank2, "
end if

Query = Query & "  FW,  FWAcc, "

if len(SourceFWRank) > 0 then
Query = Query & " FWRank, "
end if
if len(SourceFWRank2) > 0 then
Query = Query & " FWRank2, "
end if

Query = Query & "  BW, BWAcc, EPDDate)" 
Query =  Query & " Values (" &  AnimalID & " ,"
Query =  Query &   " '" & SourceSDAFD & "' ,"
Query =  Query &   " '" & SourceSDAFDAcc & "' ,"
if len(SourceSDAFDRank) > 0 then
Query =  Query &   " '" & SourceSDAFDRank & "' ,"
end if
if len(SourceSDAFDRank2) > 0 then
Query =  Query &   " '" & SourceSDAFDRank2 & "' ,"
end if
Query =  Query &   " '" & SourceSF & "' ,"
Query =  Query &   " '" & SourceSFAcc & "' ,"
if len(SourceSFRank) > 0 then
Query =  Query &   " '" & SourceSFRank & "' ,"
end if
if len(SourceSFRank2) > 0 then
Query =  Query &   " '" & SourceSFRank2 & "' ,"
end if
Query =  Query &   " '" & SourcePercentFGreaterThan30 & "' ,"
Query =  Query &   " '" & SourcepercentFgreaterThan30Acc & "' ,"
if len(SourcepercentFGreaterThan30Rank) > 0 then
Query =  Query &   " '" & SourcepercentFGreaterThan30Rank & "' ,"
end if
if len(SourcepercentFGreaterThan30Rank2) > 0 then
Query =  Query &   " '" & SourcepercentFGreaterThan30Rank2 & "' ,"
end if
Query =  Query &   " '" & SourceMC & "' ,"
Query =  Query &   " '" & SourceMCAcc & "' ,"
if len(SourceMCRank) > 0 then
Query =  Query &   " '" & SourceMCRank  & "' ,"
end if
if len(SourceMCRank2) > 0 then
Query =  Query &   " '" & SourceMCRank2  & "' ,"
end if
Query =  Query &   " '" & SourceSDMC & "' ,"
Query =  Query &   " '" & SourceSDMCAcc & "' ,"
if len(SourceSDMCRank) > 0 then
Query =  Query &   " '" & SourceSDMCRank & "' ,"
end if
if len(SourceSDMCRank2) > 0 then
Query =  Query &   " '" & SourceSDMCRank2 & "' ,"
end if
Query =  Query &   " '" & SourcePercentM & "' ,"
Query =  Query &   " '" & SourcePercentMAcc  & "' ,"
if len(SourcePercentMRank) > 0 then
Query =  Query &   " '" & SourcePercentMRank & "' ,"
end if
if len(SourcePercentMRank2) > 0 then
Query =  Query &   " '" & SourcePercentMRank2 & "' ,"
end if
Query =  Query &   " '" & SourceMSL & "' ,"
Query =  Query &   " '" & SourceMSLAcc & "' ,"
if len(SourceMSLRank) > 0 then
Query =  Query &   " '" & SourceMSLRank & "' ,"
end if
if len(SourceMSLRank2) > 0 then
Query =  Query &   " '" & SourceMSLRank2 & "' ,"
end if
Query =  Query &   " '" & SourceFW & "' ,"
Query =  Query &   " '" & SourceFWAcc & "' ,"
if len(SourceFWRank) > 0 then
Query =  Query &   " '" & SourceFWRank & "' ,"
end if
if len(SourceFWRank2) > 0 then
Query =  Query &   " '" & SourceFWRank2 & "' ,"
end if
Query =  Query &   " '" & SourceBW & "' ,"
Query =  Query &   " '" & SourceBWAcc  & "' ,"
Query =  Query &   " " & formatdatetime(now,2) & " )" 
'response.write("Query=" & Query )
ConnLOA.Execute(Query) 
ConnLOA.Close
set ConnLOA = Nothing %>
<!--#Include virtual="/ConnLOA.asp"--> 
<%
regcounter = 0
 while regcounter < Totalregcounter
regcounter  = regcounter + 1
Query =  "INSERT INTO AnimalRegistration(Regtype, AnimalID, RegNumber)" 
Query =  Query & " Values ('" & sourceRegType(regcounter) & "' ,"
Query =  Query &   " " & AnimalID & ","
Query =  Query &   " '" & sourceRegNumber(regcounter) & "' )" 
ConnLOA.Execute(Query) 
wend
ConnLOA.Close
set ConnLOA = Nothing %>


<!--#Include virtual="/Conn.asp"--> 
<%
Query =  " UPDATE Animals Set LOAID = " &   AnimalID  & " "
Query =  Query & " where ID = " & SourceID & " ;" 
Conn.Execute(Query) 
Conn.Close
set Conn = Nothing 
%>