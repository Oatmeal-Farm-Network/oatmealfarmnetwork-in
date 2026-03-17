<%' Animals
Showwritestatments =False
str1 = SourceDamSire
str2 = "'"
If InStr(str1,str2) > 0 Then
	SourceDamSire= Replace(str1, "'", "''")
End If

str1 = SourcePriceComments
str2 = "'"
If InStr(str1,str2) > 0 Then
	SourcePriceComments= Replace(str1, "'", "''")
End If

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


str1 = SourceDam
str2 = "'"
If InStr(str1,str2) > 0 Then
	SourceDam= Replace(str1, "'", "''")
End If

str1 = SourceDamDam
str2 = "'"
If InStr(str1,str2) > 0 Then
	SourceDamDam= Replace(str1, "'", "''")
End If

str1 = SourceDamDamDam
str2 = "'"
If InStr(str1,str2) > 0 Then
	SourceDamDamDam= Replace(str1, "'", "''")
End If


str1 = SourceDamDamSire
str2 = "'"
If InStr(str1,str2) > 0 Then
	SourceDamDamSire= Replace(str1, "'", "''")
End If


str1 = SourceDamSireDam
str2 = "'"
If InStr(str1,str2) > 0 Then
	SourceDamSireDam= Replace(str1, "'", "''")
End If

str1 = SourceDamSireSire
str2 = "'"
If InStr(str1,str2) > 0 Then
	SourceDamSireSire= Replace(str1, "'", "''")
End If

str1 = SourceSire
str2 = "'"
If InStr(str1,str2) > 0 Then
	SourceSire= Replace(str1, "'", "''")
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
	SourceSireSireSire= Replace(str1, "'", "''")
End If


str1 = SourceSireSire
str2 = "'"
If InStr(str1,str2) > 0 Then
	SourceSireSire= Replace(str1, "'", "''")
End If

If Len(SourceDOBday) > 0 Then
else
	SourceDOBday = 0
End If

If Len(SourceDOBMonth) > 0 Then
else
	SourceDOBMonth = 0
End If

If Len(SourceDOBYear) > 0 Then
else
	SourceDOBYear = 0
End if


if lcase(SourceForSale) = "false" then
SourceForSale = "0"
else
SourceForSale = "1"
end if


if lcase(SourceSalePending) = "false" then
SourceSalePending = "1"
else
SourceSalePending = "0"
end if

'response.write("SourceSold=" & SourceSold )

if lcase(SourceSold) = "false" or lcase(SourceSold) = "no" then
SourceSold = "0"
else
SourceSold = "1"
end if


if lcase(SourceFoundation) = "false" then
SourceFoundation = "1"
else
SourceFoundation = "0"
end if



if SourceSpeciesID = 2 then
sql = "select * from EPDAlpacas where AnimalID = " & AnimalID & ";" 
EPDFound = False
rs.Open sql, connLOA, 3, 3   
If not rs.eof Then
EPDAlpacaFound = True
end if

if EPDAlpacaFound = True then
Query =  " UPDATE EPDAlpacas Set AFD= '" & SourceAFD  & "' ,"
Query =  Query & " AFDAcc = '" & SourceAFDAcc  & "' ,"
if len(AFDRank) > 0 then
Query =  Query & " AFDRank= '" & SourceAFDRank   & "' ,"
end if
if len(AFDRank2) > 0 then
Query =  Query & " AFDRank2= '" & SourceAFDRank2   & "' ,"
end if
Query =  Query & " SDAFD= '" & SourceSDAFD  & "' ,"
Query =  Query & " SDAFDAcc = '" & SourceSDAFDAcc  & "' ,"
if len(SDAFDRank) > 0 then
Query =  Query & " SDAFDRank = '" & SourceSDAFDRank  & "' ,"
end if
if len(SDAFDRank2) > 0 then
Query =  Query & " SDAFDRank2 = '" & SourceSDAFDRank2  & "' ,"
end if
Query =  Query & " SF= '" & SourceSF  & "' ,"
Query =  Query & " SFAcc= '" & SourceSFAcc  & "' ,"
if len(SourceSFRank) > 0 then
Query =  Query & " SFRank= '" & SourceSFRank & "' ,"
end if
if len(SourceSFRank2) > 0 then
Query =  Query & " SFRank2= '" & SourceSFRank2 & "' ,"
end if
Query =  Query & " PercentFGreaterThan30= '" & SourcePercentFGreaterThan30 & "' ,"
Query =  Query & " percentFgreaterThan30Acc = '" & SourcepercentFgreaterThan30Acc  & "' ,"
if len(percentFGreaterThan30Rank) > 0 then
Query =  Query & " percentFGreaterThan30Rank = '" & SourcepercentFGreaterThan30Rank & "' ,"
end if
if len(percentFGreaterThan30Rank2) > 0 then
Query =  Query & " percentFGreaterThan30Rank2 = '" & SourcepercentFGreaterThan30Rank2 & "' ,"
end if
Query =  Query & " MC= '" & SourceMC & "' ,"
Query =  Query & " MCAcc= '" & SourceMCAcc & "' ,"
if len(SourceMCRank) > 0 then
Query =  Query & " MCRank = '" & SourceMCRank & "' ,"
end if
if len(SourceMCRank2) > 0 then
Query =  Query & " MCRank2 = '" & SourceMCRank2 & "' ,"
end if
Query =  Query & " SDMC= '" & SourceSDMC & "' ,"
Query =  Query & " SDMCAcc= '" & SourceSDMCAcc & "' ,"
if len(SourceSDMCRank) > 0 then
Query =  Query & " SDMCRank= '" & SourceSDMCRank & "' ,"
end if
if len(SourceSDMCRank2) > 0 then
Query =  Query & " SDMCRank2= '" & SourceSDMCRank2 & "' ,"
end if
Query =  Query & " PercentM= '" & SourcePercentM & "' ,"
Query =  Query & " PercentMAcc = '" & SourcePercentMAcc & "' ,"
if len(PercentMRank) > 0 then
Query =  Query & " PercentMRank = '" & SourcePercentMRank & "' ,"
end if
if len(PercentMRank2) > 0 then
Query =  Query & " PercentMRank2 = '" & SourcePercentMRank2 & "' ,"
end if
Query =  Query & " MSL= '" & SourceMSL & "' ,"
Query =  Query & " MSLAcc= '" & SourceMSLAcc & "' ,"
if len(SourceMSLRank) > 0 then
Query =  Query & " MSLRank= '" & SourceMSLRank & "' ,"
end if
if len(SourceMSLRank2) > 0 then
Query =  Query & " MSLRank2= '" & SourceMSLRank2 & "' ,"
end if

Query =  Query & " FW= '" & SourceFW & "' ,"
Query =  Query & " FWAcc= '" & SourceFWAcc & "' ,"
if len(SourceFWRank) > 0 then
Query =  Query & " FWRank= '" & SourceFWRank & "' ,"
end if
if len(SourceFWRank2) > 0 then
Query =  Query & " FWRank2= '" & SourceFWRank2 & "' ,"
end if
Query =  Query & " BW= '" & SourceBW & "' ,"
Query =  Query & " BWAcc = '" & SourceBWAcc & "' ,"
Query =  Query & " EPDDate= getdate() "
Query =  Query & " where animalID = " & AnimalID & ";" 
ConnLOA.Execute(Query) 
else
Query =  "INSERT INTO EPDAlpacas( AnimalID, EPDDate)" 
Query =  Query & " Values (" &  AnimalID & " ,"
Query =  Query &   " date(" & formatdatetime(now,2) & ") )" 
'response.write("Query=" & Query)
ConnLOA.Execute(Query) 
end if
end if

Query =  " UPDATE Animals Set FullName = '" & SourceFullName & "' ,"
Query =  Query & " Category = '" & SourceCategory   & "' ,"
Query =  Query & " DOBday = " & SourceDOBday  & ", "
Query =  Query & " DOBMonth = " & SourceDOBMonth  & " ,"
Query =  Query & " DOBYear = " & SourceDOBYear & " ,"
if len(SourceBreedLookupID) > 0 then
else
SourceBreedLookupID = 0
end if
Query =  Query & " BreedID = " & SourceBreedLookupID  & " ,"
if len(SourceBreedID2) > 0 then
else
SourceBreedID2 = 0
end if
Query =  Query & " BreedID2 = " & SourceBreedID2  & " ,"
if len(SourceBreedID3) > 0 then
else
SourceBreedID3 = 0
end if
Query =  Query & " BreedID3 = " & SourceBreedID3  & " ,"
if len(SourceBreedID4) > 0 then
else
SourceBreedID4 = 0
end if
Query =  Query & " BreedID4 = " & SourceBreedID4  & " ,"


Query =  Query & " Weight = '" & SourceWeight  & "' ,"
Query =  Query & " Height = '" & SourceHeight & "' ,"
Query =  Query & " Gaited = '" & SourceGaited  & "' ,"
Query =  Query & " Warmblooded = '" & SourceWarmblooded  & "' ,"

if len(SourceTemperment) > 0 then
else
SourceTemperment = 0
end if
Query =  Query & " Temperment = " & SourceTemperment  & " ,"

'Query =  Query & " ExternalLink = '" & SourceExternalLink  & "' ,"
Query =  Query & " Description = '" & SourceDescription & "' ,"
Query =  Query & " StudDescription = '" & SourceStudDescription & "' ,"
'Query =  Query & " Owner = '" & SourceOwner & "' ,"
Query =  Query & " ShortName= '" & SourceShortName   & "'  "
 Query =  Query & " where ID = " & AnimalID & ";" 
 'response.write("Query=" & Query )
ConnLOA.Execute(Query) 
ConnLOA.Close
set ConnLOA = Nothing %>
<!--#Include virtual="/ConnLOA.asp"--> 
<%' Update Ancestry 
Query =  " UPDATE Ancestors Set Dam = '" & SourceDam & "' ,"
Query =  Query & " DamColor = '" & SourceDamColor & "' ,"
Query =  Query & " DamARI = '" & SourceDamARI  & "' ,"
Query =  Query & " DamCLAA = '" & SourceDamCLAA  & "' ,"
Query =  Query & " DamLink = '" &  SourceDamLink   & "' ,"
Query =  Query & " Damdam = '" & SourceDamdam   & "' ,"
Query =  Query & " DamDamColor = '" & SourceDamDamColor  & "' ,"
Query =  Query & " DamDamARI = '" &  SourceDamDamARI  & "' ,"
Query =  Query & " DamDamCLAA = '" & SourceDamDamCLAA  & "' ,"
Query =  Query & " DamDamLink = '" & SourceDamDamLink   & "' ,"
Query =  Query & " Damsire = '" &  SourceDamsire  & "' ,"
Query =  Query & " DamsireARI = '" &  SourceDamsireARI   & "' ,"
Query =  Query & " DamsireCLAA = '" &  SourceDamsireCLAA   & "' ,"
Query =  Query & " DamsireColor  = '" &  SourceDamsireColor   & "' ,"
Query =  Query & " DamsireLink = '" &  SourceDamsireLink  & "' ,"
Query =  Query & " DamDamDam = '" & SourceDamDamDam  & "' ,"
Query =  Query & " DamDamDamARI = '" & SourceDamDamDamARI   & "' ,"
Query =  Query & " DamDamDamCLAA = '" & SourceDamDamDamCLAA  & "' ,"
Query =  Query & " DamDamDamColor = '" & SourceDamDamDamColor   & "' ,"
Query =  Query & " DamDamDamLink = '" & SourceDamDamDamLink  & "' ,"
Query =  Query & " DamDamSire = '" & SourceDamDamSire  & "' ,"
Query =  Query & " DamDamSireARI = '" & SourceDamDamSireARI  & "' ,"
Query =  Query & " DamDamSireCLAA = '" & SourceDamDamSireCLAA  & "' ,"
Query =  Query & " DamDamSireColor = '" & SourceDamDamSireColor   & "' ,"
Query =  Query & " DamDamSireLink = '" &  SourceDamDamSireLink  & "' ,"
Query =  Query & " DamSireDam = '" & SourceDamSireDam  & "' ,"
Query =  Query & " DamSireDamARI = '" &  SourceDamSireDamARI   & "' ,"
Query =  Query & " DamSireDamCLAA = '" &  SourceDamSireDamCLAA  & "' ,"
Query =  Query & " DamSireDamColor = '" &  SourceDamSireDamColor  & "' ,"
Query =  Query & " DamSireDamLink = '" & SourceDamSireDamLink  & "' ,"
Query =  Query & " DamSireSire = '" &  SourceDamSireSire   & "' ,"
Query =  Query & " DamSireSireARI = '" &  SourceDamSireSireARI   & "' ,"
Query =  Query & " DamSireSireCLAA = '" & SourceDamSireSireCLAA  & "' ,"
Query =  Query & " DamSireSireColor = '" & SourceDamSireSireColor   & "' ,"
Query =  Query & " DamSireSireLink = '" & SourceDamSireSireLink   & "' ,"
Query =  Query & " Sire = '" & SourceSire   & "' ,"
Query =  Query & " SireColor = '" & SourceSireColor  & "' ,"
Query =  Query & " SireARI = '" & SourceSireARI   & "' ,"
Query =  Query & " SireCLAA = '" & SourceSireCLAA   & "' ,"
Query =  Query & " SireLink = '" & SourceSireLink  & "' ,"
Query =  Query & " Siredam = '" &  SourceSiredam   & "' ,"
Query =  Query & " SiredamColor = '" &  SourceSiredamColor  & "' ,"
Query =  Query & " SiredamARI = '" & SourceSiredamARI   & "' ,"
Query =  Query & " SiredamCLAA = '" & SourceSiredamCLAA  & "' ,"
Query =  Query & " SiredamLink = '" & SourceSiredamLink   & "' ,"
Query =  Query & " SireSire = '" &  SourceSireSire   & "' ,"
Query =  Query & " SireSireColor = '" & SourceSireSireColor  & "' ,"
Query =  Query & " SireSireARI = '" & SourceSireSireARI   & "' ,"
Query =  Query & " SireSireCLAA = '" & SourceSireSireCLAA  & "' ,"
Query =  Query & " SireSireLink = '" & SourceSireSireLink   & "' ,"
Query =  Query & " SireDamDam = '" & SourceSireDamDam  & "' ,"
Query =  Query & " SireDamDamColor = '" & SourceSireDamDamColor  & "' ,"
Query =  Query & " SireDamDamARI = '" & SourceSireDamDamARI   & "' ,"
Query =  Query & " SireDamDamCLAA = '" & SourceSireDamDamCLAA   & "' ,"
Query =  Query & " SireDamDamLink = '" & SourceSireDamDamLink  & "' ,"
Query =  Query & " SireDamSire = '" & SourceSireDamSire  & "' ,"
Query =  Query & " SireDamSireColor = '" & SourceSireDamSireColor  & "' ,"
Query =  Query & " SireDamSireARI = '" & SourceSireDamSireARI  & "' ,"
Query =  Query & " SireDamSireCLAA = '" & SourceSireDamSireCLAA  & "' ,"
Query =  Query & " SireDamSireLink = '" & SourceSireDamSireLink  & "' ,"
Query =  Query & " SireSireDam = '" & SourceSireSireDam  & "' ,"
Query =  Query & " SireSireDamColor = '" & SourceSireSireDamColor   & "' ,"
Query =  Query & " SireSireDamARI = '" &  SourceSireSireDamARI   & "' ,"
Query =  Query & " SireSireDamCLAA = '" & SourceSireSireDamCLAA   & "' ,"
Query =  Query & " SireSireDamLink = '" & SourceSireSireDamLink   & "' ,"
Query =  Query & " SireSireSire = '" & SourceSireSireSire   & "' ,"
Query =  Query & " SireSireSireColor = '" & SourceSireSireSireColor   & "' ,"
Query =  Query & " SireSireSireARI = '" & SourceSireSireSireARI   & "' ,"
Query =  Query & " SireSireSireCLAA = '" & SourceSireSireSireCLAA  & "' ,"
Query =  Query & " SireSireSireLink = '" & SourceSireSireSireLink  & "' "
Query =  Query & " where ID = " & AnimalID & ";" 

ConnLOA.Execute(Query) 
ConnLOA.Close
set ConnLOA = Nothing %>
<!--#Include virtual="/ConnLOA.asp"--> 
<%
' Update Photos
Query =  " UPDATE Photos Set Photo1 = '" & SourcePhoto1 & "' ,"
if len(SourceARIPhoto) > 0 then
Query =  Query & " ARI = '" & SourceARIPhoto   & "' ,"
end if
if len(SourceHistogramPhoto) > 0 then
Query =  Query & " Histogram = '" & SourceHistogramPhoto   & "' ,"
end if
if len(SourceFiberAnalysisPhoto) > 0 then
Query =  Query & " FiberAnalysis = '" & SourceFiberAnalysisPhoto   & "' ,"
end if
Query =  Query & " PhotoCaption1 = '" & SourcePhotoCaption1   & "' ,"
Query =  Query & " Photo2 = '" & SourcePhoto2   & "' ,"
Query =  Query & " PhotoCaption2 = '" & SourcePhotoCaption2   & "' ,"
Query =  Query & " Photo3 = '" & SourcePhoto3   & "' ,"
Query =  Query & " PhotoCaption3= '" & SourcePhotoCaption3   & "' ,"
Query =  Query & " Photo4 = '" & SourcePhoto4   & "' ,"
Query =  Query & " PhotoCaption4 = '" & SourcePhotoCaption4   & "' ,"
Query =  Query & " Photo5 = '" & SourcePhotoPhoto5   & "' ,"
Query =  Query & " PhotoCaption5 = '" & SourcePhotoCaption5   & "' ,"
Query =  Query & " Photo6 = '" & SourcePhoto6   & "' ,"
Query =  Query & " PhotoCaption6 = '" & SourcePhotoCaption6   & "' ,"
Query =  Query & " Photo7 = '" & SourcePhoto7   & "' ,"
Query =  Query & " PhotoCaption7 = '" & SourcePhotoCaption7   & "' ,"
Query =  Query & " Photo8 = '" & SourcePhoto8   & "' ,"
Query =  Query & " PhotoCaption8 = '" & SourcePhotoCaption8   & "'" 
Query =  Query & " where ID = " & AnimalID & ";" 
ConnLOA.Execute(Query) 
ConnLOA.Close
set ConnLOA = Nothing %>
<!--#Include virtual="/ConnLOA.asp"--> 
<%
' Update Ancestry Percents
Query =  " UPDATE AncestryPercents Set PercentUnknownOther = '" & SourcePercentUnknownOther & "' ,"
Query =  Query & " PercentAccoyo = '" & SourcePercentAccoyo   & "' ,"
Query =  Query & " PercentChilean = '" & SourcePercentChilean   & "' ,"
Query =  Query & " PercentBolivian = '" & SourcePercentBolivian  & "' ,"
Query =  Query & " PercentPeruvian = '" & SourcePercentPeruvian  & "' "
Query =  Query & " where ID = " & AnimalID & ";" 
%>
<% ConnLOA.Execute(Query) 
ConnLOA.Close
set ConnLOA = Nothing %>
<!--#Include virtual="/ConnLOA.asp"--> 
<%
 ' Colors
Query =  " UPDATE Colors Set Color1 = '" & SourceColor1 & "' ,"
Query =  Query & " Color2= '" & SourceColor2   & "' ,"
Query =  Query & " Color3= '" & SourceColor3 & "' ,"
Query =  Query & " Color4= '" & SourceColor4  & "' ,"
Query =  Query & " Color5 = '" & SourceColor5  & "' "
Query =  Query & " where ID = " & AnimalID & ";" 
ConnLOA.Execute(Query) 
ConnLOA.Close
set ConnLOA = Nothing %>
<!--#Include virtual="/ConnLOA.asp"--> 
<%
If Len(SourceStudFee) > 0 Then
else
SourceStudFee = 0
End if
' Pricing


pricingfound = False
sql = "select ForSale from Pricing where Pricing.ID = " & AnimalID & ";" 
rs.Open sql, ConnLOA, 3, 3   
If Not rs.eof Then
pricingfound = True
End if
rs.close
ConnLOA.Close
set ConnLOA = Nothing



if pricingfound = False then
Query =  "INSERT INTO Pricing(ID, ForSale, StudFee, Price, SalePrice, PriceComments, Foundation, Discount, Sold, SalePending  )" 
Query =  Query & " Values (" &  AnimalID & ", "
Query =  Query &   " " & SourceForSale & " ,"
Query =  Query &   " " & SourceStudFee & " ,"
Query =  Query &   " " & SourcePrice & " ,"
if len(SourceSalePrice)> 0 then
Query =  Query &   " " & SourceSalePrice & " ,"
else
Query =  Query &   " 0 ,"
end if
Query =  Query &   " '" & SourcePriceComments & "' ," 
Query =  Query &   " " & SourceFoundation & " ," 
Query =  Query &   " " & SourceDiscount & " ," 
Query =  Query &   " " & SourceSold & " ," 			
Query =  Query &   " " & SourceSalePending 	&  " )" 



else
Query =  " UPDATE Pricing Set ForSale = " & SourceForSale & " ,"
Query =  Query & " StudFee= " & SourceStudFee   & " ,"
Query =  Query & " Price = " & SourcePrice  & " ,"
if len(SourceSalePrice)> 0 then
Query =  Query & " SalePrice= " & SourceSalePrice & " ,"
else
Query =  Query & " SalePrice= 0,"
end if
Query =  Query & " PriceComments = '" & SourcePriceComments  & "' ,"
Query =  Query & " Foundation= " & SourceFoundation  & " ,"
Query =  Query & " Discount= " & SourceDiscount  & " ,"
Query =  Query & " Sold= " & SourceSold & " ,"
Query =  Query & " SalePending= " & SourceSalePending  & " "
Query =  Query & " where ID = " & AnimalID & ";" 
end if %>

<!--#Include virtual="/ConnLOA.asp"--> 

<% 
'response.write("Query=" & Query )

ConnLOA.Execute(Query) 
ConnLOA.Close
set ConnLOA = Nothing %>
<!--#Include virtual="/ConnLOA.asp"--> 
<%
' Awards 
Query =  "Delete From Awards where ID = " & AnimalID & "" 
ConnLOA.Execute(Query) 
ConnLOA.Close
set ConnLOA = Nothing %>
<!--#Include virtual="/ConnLOA.asp"--> 
<%
For rowcount = 1 To 20
If Len(SourceAwardYear(rowcount) ) > 0 Then
else
SourceAwardYear(rowcount) = 0
End If
If Len(SourcePlacingNumber(rowcount)  ) < 2 Then
SourcePlacingNumber(rowcount)  = "0"
End If	   
If Len(SourceShowLevel(rowcount)  ) < 2 Then
SourceShowLevel(rowcount) = "0"
End if
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
Query =  "INSERT INTO Awards(ID, ShowName, AwardYear, Type, Placing, Class, Judge,  ShowYear, Awardcomments,  ShowLevel)" 
Query =  Query & " Values (" &  AnimalID & ", "
Query =  Query &   " '" & SourceShow(rowcount) & "' ,"
Query =  Query &   " " & SourceAwardYear(rowcount) & " ,"
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
<%
' Fiber
Query =  "Delete From Fiber where ID = " & AnimalID & "" 
ConnLOA.Execute(Query) 
ConnLOA.Close
set ConnLOA = Nothing %>
<!--#Include virtual="/ConnLOA.asp"--> 
<%
For rowcount = 1 To 21
Query =  "INSERT INTO Fiber(ID, SampleDate, SampleAge, Average, StandardDev, COV, GreaterThan30, CF,  Curve, Shearweight,  BlanketWeight, Length, CrimpPerInch, LargeHistogram, SmallHistogram )" 
Query =  Query & " Values (" &  AnimalID & ", "
Query =  Query & " '" & SourceSampleDate(rowcount) & "' ,"
Query =  Query & " '" & SourceSampleAge(rowcount) & "' ,"
Query =  Query & " '" & SourceAverage(rowcount) & "' ,"
Query =  Query & " '" & SourceStandardDev(rowcount) & "' ,"
Query =  Query & " '" & SourceCOV(rowcount) & "' ,"
Query =  Query & " '" & SourceGreaterThan30(rowcount) & "' ,"
Query =  Query & " '" & SourceCF(rowcount) & "' ,"
Query =  Query & " '" & SourceCurve(rowcount) & "' ,"
Query =  Query & " '" & SourceShearweight(rowcount) & "' ,"
Query =  Query & " '" & SourceBlanketWeight(rowcount) & "' ,"
Query =  Query & " '" & SourceLength(rowcount) & "' ,"
Query =  Query & " '" & SourceCrimpPerInch(rowcount) & "' ,"
Query =  Query & " '" & SourceLargeHistogram(rowcount) & "' ,"
Query =  Query & " '" & SourceSmallHistogram(rowcount) & "' )" 
ConnLOA.Execute(Query) 
Next 
regcounter = 0
while regcounter < Totalregcounter
regcounter  = regcounter + 1
Query =  " UPDATE AnimalRegistration Set RegNumber = '" &   sourceRegNumber(regcounter)  & "' "
Query =  Query & " where AnimalID = " & AnimalID & " and RegType = '" & sourceRegType(regcounter) & "';" 
ConnLOA.Execute(Query) 
wend
%>