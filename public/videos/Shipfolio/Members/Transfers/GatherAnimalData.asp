<% administration = True%>
<!--#Include virtual="/Conn.asp"--> 
<%
sql = "select * from Ancestors where ID = " &  ID & ";" 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
SourceDam = rs("Dam")
SourceDamColor= rs("DamColor")
SourceDamARI= rs("DamARI")
SourceDamCLAA= rs("DamCLAA")
SourceDamLink= rs("DamLink")
SourceDamdam= rs("Damdam")
SourceDamDamColor= rs("DamDamColor")
SourceDamDamARI= rs("DamDamARI")
SourceDamDamCLAA= rs("DamDamCLAA")
SourceDamDamLink= rs("DamDamLink")
SourceDamsire= rs("Damsire")
SourceDamsireARI= rs("DamsireARI")
SourceDamsireCLAA= rs("DamsireCLAA")
SourceDamsireColor= rs("DamsireColor")
SourceDamsireLink= rs("DamsireLink")
SourceDamDamDam= rs("DamDamDam")
SourceDamDamDamARI= rs("DamDamDamARI")
SourceDamDamDamCLAA= rs("DamDamDamCLAA")
SourceDamDamDamColor= rs("DamDamDamColor")
SourceDamDamDamLink= rs("DamDamDamLink")
SourceDamDamSire= rs("DamDamSire")
SourceDamDamSireARI= rs("DamDamSireARI")
SourceDamDamSireCLAA= rs("DamDamSireCLAA")
SourceDamDamSireColor= rs("DamDamSireColor")
SourceDamDamSireLink= rs("DamDamSireLink")
SourceDamSireDam= rs("DamSireDam")
SourceDamSireDamARI= rs("DamSireDamARI")
SourceDamSireDamCLAA= rs("DamSireDamCLAA")
SourceDamSireDamColor= rs("DamSireDamColor")
SourceDamSireDamLink= rs("DamSireDamLink")
SourceDamSireSire= rs("DamSireSire")
SourceDamSireSireARI= rs("DamSireSireARI")
SourceDamSireSireCLAA= rs("DamSireSireCLAA")
SourceDamSireSireColor= rs("DamSireSireColor")
SourceDamSireSireLink= rs("DamSireSireLink")
SourceSire= rs("Sire")
SourceSireColor= rs("SireColor")
SourceSireARI= rs("SireARI")
SourceSireCLAA= rs("SireCLAA")
SourceSireLink= rs("SireLink")
SourceSiredam= rs("Siredam")
SourceSiredamColor= rs("SiredamColor")
SourceSiredamARI= rs("SiredamARI")
SourceSiredamCLAA= rs("SiredamCLAA")
SourceSiredamLink= rs("SiredamLink")
SourceSireSire= rs("SireSire")
SourceSireSireColor= rs("SireSireColor")
SourceSireSireARI= rs("SireSireARI")
SourceSireSireCLAA= rs("SireSireCLAA")
SourceSireSireLink= rs("SireSireLink")
SourceSireDamDam= rs("SireDamDam")
SourceSireDamDamColor= rs("SireDamDamColor")
SourceSireDamDamARI= rs("SireDamDamARI")
SourceSireDamDamCLAA= rs("SireDamDamCLAA")
SourceSireDamDamLink= rs("SireDamDamLink")
SourceSireDamSire= rs("SireDamSire")
SourceSireDamSireColor= rs("SireDamSireColor")
SourceSireDamSireARI= rs("SireDamSireARI")
SourceSireDamSireCLAA= rs("SireDamSireCLAA")
SourceSireDamSireLink= rs("SireDamSireLink")
SourceSireSireDam= rs("SireSireDam")
SourceSireSireDamColor= rs("SireSireDamColor")
SourceSireSireDamARI= rs("SireSireDamARI")
SourceSireSireDamCLAA= rs("SireSireDamCLAA")
SourceSireSireDamLink= rs("SireSireDamLink")
SourceSireSireSire= rs("SireSireSire")
SourceSireSireSireColor= rs("SireSireSireColor")
SourceSireSireSireARI= rs("SireSireSireARI")
SourceSireSireSireCLAA= rs("SireSireSireCLAA")
SourceSireSireSireLink= rs("SireSireSireLink")
End If 
sql = "select * from AncestryPercents where ID = " &  ID & ";" 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
SourcePercentPeruvian= rs("PercentPeruvian")
SourcePercentBolivian= rs("PercentBolivian")
SourcePercentChilean= rs("PercentChilean")
SourcePercentAccoyo= rs("PercentAccoyo")
SourcePercentUnknownOther= rs("PercentUnknownOther")
End If 
rs.close
sql = "select * from Animals where  ID = " &  ID & ";" 
response.write("sql=" & sql )

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
SourceSpeciesID= rs("SpeciesID")
SourceFullName= rs("FullName")
SourceCategory= rs("Category")
SourceDOBday= rs("DOBday")
SourceDOBMonth= rs("DOBMonth")
SourceDOBYear= rs("DOBYear")
SourceBreedLookupID= rs("BreedID")
SourceExternalLink= rs("ExternalLink")
SourceDescription= rs("Description") 
SourceOwner= rs("Owner")
End If 
rs.close 

dim sourceRegType(99)
dim sourceRegNumber(99)
regcounter = 0
sql = "select * from AnimalRegistration where AnimalID = " &  ID & ";" 
rs.Open sql, conn, 3, 3   
while not rs.eof
regcounter = regcounter +1
sourceRegType(regcounter)  = rs("regType")
sourceRegNumber(regcounter)= rs("RegNumber")
rs.movenext
wend
Totalregcounter = regcounter
rs.close 
sql = "select * from SpeciesBreedlookupTable where SpeciesID = "  & SourceBreedLookupID  & ";"
response.write("sql=" & sql )
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
SourceBreed = rs("Breed")	 
SourceSpeciesID = rs("SpeciesID")	 
end if
rs.close
if SourceSpeciesID = 2 then
sql = "select * from EPDAlpacas where AnimalID = " &  ID & ";" 
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
SourceAFD = rs("AFD")	 
SourceAFDAcc = rs("AFDAcc")	 
SourceAFDRank = rs("AFDRank")	 
SourceSDAFD= rs("SDAFD")	 
SourceSDAFDAcc= rs("SDAFDAcc")	 
SourceSDAFDRank= rs("SDAFDRank")	 
SourceSF= rs("SF")	 
SourceSFAcc= rs("SFAcc")	 
SourceSFRank= rs("SFRank")	 
SourcePercentFGreaterThan30= rs("PercentFGreaterThan30")	 
SourcepercentFgreaterThan30Acc= rs("percentFgreaterThan30Acc")	 
SourcepercentFGreaterThan30Rank= rs("percentFGreaterThan30Rank")	 
SourceMC= rs("MC")	 
SourceMCAcc= rs("MCAcc")	 
SourceMCRank= rs("MCRank")	 
SourceSDMC= rs("SDMC")	 
SourceSDMCAcc= rs("SDMCAcc")	 
SourceSDMCRank= rs("SDMCRank")	 
SourcePercentM= rs("PercentM")	 
SourcePercentMAcc= rs("PercentMAcc")	 
SourcePercentMRank= rs("PercentMRank")	 
SourceMSL= rs("MSL")	 
SourceMSLAcc= rs("MSLAcc")	 
SourceMSLRank= rs("MSLRank")	 
SourceFW= rs("FW")	 
SourceFWAcc= rs("FWAcc")	 
SourceFWRank= rs("FWRank")	 
BW= rs("BW")	 
BWAcc= rs("BWAcc")	 
EPDDate= rs("EPDDate")	 
end if
end if

If SourceCategory = "Experienced Male" Or SourceCategory = "Inexperienced Male" then
sql = "select * from MaleData where ID = " &  ID & ";" 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
'SourceStudDescription= rs("StudDescription1") & rs("StudDescription2")
End If 
rs.close
End If 
sql = "select * from Photos where ID = " &  ID & ";" 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
SourceARIPhoto=  rs("ARI")
SourceHistogramPhoto=  rs("Histogram")
SourceFiberAnalysisPhoto=  rs("FiberAnalysis")
str1 =SourceARIPhoto
str2 = "'"
If InStr(str1,str2) > 0 Then
SourceARIPhoto= Replace(str1,  str2, "''")
End If  	 
str1 =SourceHistogramPhoto
str2 = "'"
If InStr(str1,str2) > 0 Then
SourceHistogramPhoto= Replace(str1,  str2, "''")
End If  
str1 =SourceFiberAnalysisPhoto
str2 = "'"
If InStr(str1,str2) > 0 Then
SourceFiberAnalysisPhoto= Replace(str1,  str2, "''")
End If  
SourcePhoto1=  rs("Photo1")
str1 =SourcePhoto1
str2 = "'"
If InStr(str1,str2) > 0 Then
SourcePhoto1= Replace(str1,  str2, "''")
End If  	 
SourcePhotoCaption1= rs("PhotoCaption1")
str1 =SourcePhotoCaption1
str2 = "'"
If InStr(str1,str2) > 0 Then
SourcePhotoCaption1= Replace(str1,  str2, "''")
End If  	 
SourcePhoto2=  rs("Photo2")
str1 =SourcePhoto2
str2 = "'"
If InStr(str1,str2) > 0 Then
SourcePhoto2= Replace(str1,  str2, "''")
End If  	 
SourcePhotoCaption2= rs("PhotoCaption2")
str1 =SourcePhotoCaption2
str2 = "'"
If InStr(str1,str2) > 0 Then
SourcePhotoCaption2= Replace(str1,  str2, "''")
End If  	 
SourcePhoto3=  rs("Photo3")
	
str1 =SourcePhoto3
str2 = "'"
If InStr(str1,str2) > 0 Then
SourcePhoto3= Replace(str1,  str2, "''")
End If  	 
SourcePhotoCaption3= rs("PhotoCaption3")
str1 =SourcePhotoCaption3
str2 = "'"
If InStr(str1,str2) > 0 Then
SourcePhotoCaption3= Replace(str1,  str2, "''")
End If  	 
SourcePhoto4=  rs("Photo4")
str1 =SourcePhoto4
str2 = "'"
If InStr(str1,str2) > 0 Then
SourcePhoto4= Replace(str1,  str2, "''")
End If  	 
SourcePhotoCaption4= rs("PhotoCaption4")
str1 =SourcePhotoCaption4
str2 = "'"
If InStr(str1,str2) > 0 Then
SourcePhotoCaption4= Replace(str1,  str2, "''")
End If  	 
SourcePhoto5=  rs("Photo5")
str1 =SourcePhoto5
str2 = "'"
If InStr(str1,str2) > 0 Then
SourcePhoto5= Replace(str1,  str2, "''")
End If  	 
SourcePhotoCaption5= rs("PhotoCaption5")
str1 =SourcePhotoCaption5
str2 = "'"
If InStr(str1,str2) > 0 Then
SourcePhotoCaption5= Replace(str1,  str2, "''")
End If  	 
SourcePhoto6=  rs("Photo6")
str1 =SourcePhoto6
str2 = "'"
If InStr(str1,str2) > 0 Then
SourcePhoto6= Replace(str1,  str2, "''")
End If  	 
SourcePhotoCaption6= rs("PhotoCaption6")
str1 =SourcePhotoCaption6
str2 = "'"
If InStr(str1,str2) > 0 Then
SourcePhotoCaption6= Replace(str1,  str2, "''")
End If  	 
SourcePhoto7=  rs("Photo7")
str1 =SourcePhoto7
str2 = "'"
If InStr(str1,str2) > 0 Then
SourcePhoto7= Replace(str1,  str2, "''")
End If  	 
SourcePhotoCaption7= rs("PhotoCaption7")
str1 =SourcePhotoCaption7
str2 = "'"
If InStr(str1,str2) > 0 Then
SourcePhotoCaption7= Replace(str1,  str2, "''")
End If  	 
SourcePhoto8=  rs("Photo8")
str1 =SourcePhoto8
str2 = "'"
If InStr(str1,str2) > 0 Then
SourcePhoto8= Replace(str1,  str2, "''")
End If  	 
SourcePhotoCaption8= rs("PhotoCaption8")
str1 =SourcePhotoCaption8
str2 = "'"
If InStr(str1,str2) > 0 Then
SourcePhotoCaption8= Replace(str1,  str2, "''")
End If  	 
End If 
rs.close
sql = "select * from Colors where ID = " &  ID & ";" 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
SourceColor1= rs("Color1")
SourceColor2= rs("Color2")
SourceColor3= rs("Color3")
SourceColor4= rs("Color4")
SourceColor5= rs("Color5")
End If 
rs.close
sql = "select * from Pricing where ID = " &  ID & ";" 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
SourceForSale= rs("ForSale")	
SourceStudFee= rs("StudFee")
SourcePrice= rs("Price")
SourceSalePrice= rs("SalePrice")
SourcePriceComments= rs("PriceComments")
SourceFoundation= rs("Foundation")
SourceDiscount= rs("Discount")
SourceSold= rs("Sold")
SourceSalePending= rs("SalePending")
End If 
rs.close
'conn=nothing
Dim SourceShow(100)
Dim SourceAwardYear(100)
Dim SourceType(100)
Dim SourcePlacingNumber(100)
Dim SourcePlacing(100)
Dim SourceClass(100)
Dim SourceJudge(100)
Dim SourceShowYear(100)
Dim SourceAwardcomments(100)
Dim SourceShowLevel(100)
sql = "select * from Awards where ID = " &  ID & ";" 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
count = 0
While Not rs.eof 
count = count +1
SourceShow(count)= rs("Showname")
SourceAwardYear(count)= rs("AwardYear")
SourceType(count)= rs("Type")
SourcePlacing(count)= rs("Placing")
SourceClass(count)= rs("Class")
SourceJudge(count)= rs("Judge")
str1 =SourceJudge(count)
str2 = "'"
If InStr(str1,str2) > 0 Then
SourceJudge(count)= Replace(str1,  str2, "''")
End If  	 
SourceAwardcomments(count)= rs("Awardcomments")
'	SourceShowLevel(count)= rs("ShowLevel")
rs.movenext
wend
rs.close
Dim SourceSampleDate(100)
Dim SourceSampleAge(100)
Dim SourceAverage(100)
Dim SourceStandardDev(100)
Dim SourceCOV(100)
Dim SourceGreaterThan30(100)
Dim SourceCF(100)
Dim SourceCurve(100)
Dim SourceShearweight(100)
Dim SourceBlanketWeight(100)
Dim SourceLength(100)
Dim SourceCrimpPerInch(100)
Dim SourceLargeHistogram(100)
Dim SourceSmallHistogram(100)
dim SourceSampleDateday(1000)
dim SourceSampleDateMonth(1000)
dim SourceSampleDateYear(1000)
sql = "select * from Fiber where ID = " &  ID & ";" 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
count = 0
While Not rs.eof 
count = count +1
SourceSampleDateday(count)= rs("SampleDateday")
SourceSampleDateMonth(count)= rs("SampleDateMonth")
SourceSampleDateYear(count)= rs("SampleDateYear")
SourceSampleAge(count)= rs("SampleAge")
SourceAverage(count)= rs("Average")
SourceStandardDev(count)= rs("StandardDev")
SourceCOV(count)= rs("COV")
SourceGreaterThan30(count)= rs("GreaterThan30")
SourceCF(count)= rs("CF")
SourceCurve(count)= rs("Curve")
SourceShearweight(count)= rs("Shearweight")
SourceBlanketWeight(count)= rs("BlanketWeight")
SourceLength(count)= rs("Length")
SourceCrimpPerInch(count)= rs("CrimpPerInch")
rs.movenext
wend
rs.close
%>