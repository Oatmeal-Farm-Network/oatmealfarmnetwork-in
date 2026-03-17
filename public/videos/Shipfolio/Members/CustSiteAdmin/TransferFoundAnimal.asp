
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
	SourceDamSireDam= Replace(str1, "'", "''")
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
	SourceSireSireDam= Replace(str1, "'", "''")
End If


Query =  " UPDATE Animals Set FullName = '" & SourceFullName & "' ,"
			Query =  Query & " ShortName= '" & SourceShortName   & "' ,"
			Query =  Query & " Category = '" & SourceCategory   & "' ,"
			Query =  Query & " ARI = '" & SourceARI  & "' ,"
			Query =  Query & " CLAA = '" & SourceCLAA  & "' ,"
			Query =  Query & " DOBday = " & SourceDOBday  & ", "
			Query =  Query & " DOBMonth = " & SourceDOBMonth  & " ,"
			Query =  Query & " DOBYear = " & SourceDOBYear & " ,"
			Query =  Query & " Breed = '" & SourceBreed  & "' ,"
			Query =  Query & " ExternalLink = '" & SourceExternalLink  & "' ,"
			Query =  Query & " Description = '" & SourceDescription & "' ,"
			Query =  Query & " StudDescription = '" & SourceStudDescription & "' ,"
			Query =  Query & " Owner = '" & SourceOwner & "' "
  		    Query =  Query & " where ID = " & AnimalID & ";" 
'response.write(Query)	

Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(Databasepath2) 	& ";" 


DataConnection.Execute(Query) 

DataConnection.Close




' Update Ancestry 

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

'response.write("Databasepath2=")	
'response.write(Databasepath2)	

Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(Databasepath2) 	& ";" 


DataConnection.Execute(Query) 

DataConnection.Close


' Update Photos

			Query =  " UPDATE Photos Set Photo1 = '" & SourcePhoto1 & "' ,"
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
'response.write(Query)	


Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(Databasepath2) 	& ";" 


DataConnection.Execute(Query) 

DataConnection.Close




' Update Ancestry Percents

			Query =  " UPDATE AncestryPercents Set PercentUnknownOther = '" & SourcePercentUnknownOther & "' ,"
			Query =  Query & " PercentAccoyo = '" & SourcePercentAccoyo   & "' ,"
			Query =  Query & " PercentChilean = '" & SourcePercentChilean   & "' ,"
			Query =  Query & " PercentBolivian = '" & SourcePercentBolivian  & "' ,"
			Query =  Query & " PercentPeruvian = '" & SourcePercentPeruvian  & "' "
  		    Query =  Query & " where ID = " & AnimalID & ";" 
'response.write(Query)	


Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(Databasepath2) 	& ";" 


DataConnection.Execute(Query) 

DataConnection.Close



 ' Colors

Query =  " UPDATE Colors Set Color1 = '" & SourceColor1 & "' ,"
			Query =  Query & " Color2= '" & SourceColor2   & "' ,"
			Query =  Query & " Color3= '" & SourceColor3 & "' ,"
			Query =  Query & " Color4= '" & SourceColor4  & "' ,"
			Query =  Query & " Color5 = '" & SourceColor5  & "' "
  		    Query =  Query & " where ID = " & AnimalID & ";" 
'response.write(Query)	

Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(Databasepath2) 	& ";" 


DataConnection.Execute(Query) 

DataConnection.Close




' Pricing

Query =  " UPDATE Pricing Set ForSale = " & SourceForSale & " ,"
			Query =  Query & " StudFee= " & SourceStudFee   & " ,"
			Query =  Query & " Price = " & SourcePrice  & " ,"
			Query =  Query & " SalePrice= '" & SourceSalePrice & "' ,"
			Query =  Query & " PriceComments = '" & SourcePriceComments  & "' ,"
			Query =  Query & " Foundation= " & SourceFoundation  & " ,"
			Query =  Query & " Discount= " & SourceDiscount  & " ,"
			Query =  Query & " Sold= " & SourceSold & " ,"
			Query =  Query & " SalePending= " & SourceSalePending  & " "
  		    Query =  Query & " where ID = " & AnimalID & ";" 



Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(Databasepath2) 	& ";" 


DataConnection.Execute(Query) 

DataConnection.Close
 
 
 
 ' Awards 

Query =  "Delete * From Awards where ID = " & AnimalID & "" 
    
	Set DataConnection = Server.CreateObject("ADODB.Connection")

	DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(Databasepath2) & ";" 

	DataConnection.Execute(Query) 







			For rowcount = 1 To 20
				
       If Len(SourceAwardYear(rowcount) ) < 2 Or SourceAwardYear(rowcount) = Null Then
				SourceAwardYear(rowcount) = 0
	   End If
	   'response.write("SourcePlacingNumber(rowcount) =")
'response.write(SourcePlacingNumber(rowcount) )
	   
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
				Query =  "INSERT INTO Awards(ID, Show, AwardYear, Type, Placing, Class, Judge,  ShowYear, Awardcomments,  ShowLevel)" 
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
'response.write("query=")
'response.write(query)

				Set DataConnection = Server.CreateObject("ADODB.Connection")

				DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(Databasepath2) 	& ";" 

				DataConnection.Execute(Query) 

				DataConnection.Close

           Next


' Fiber
Query =  "Delete * From Fiber where ID = " & AnimalID & "" 
    
	Set DataConnection = Server.CreateObject("ADODB.Connection")

	DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(Databasepath2) & ";" 

	DataConnection.Execute(Query) 



'response.write(Query)	

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

    'response.write("rowcount=")	
	 '   response.write(rowcount)	
	'		    response.write(Query)	

				Set DataConnection = Server.CreateObject("ADODB.Connection")

				DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(Databasepath2) 	& ";" 

				DataConnection.Execute(Query) 

				DataConnection.Close

           Next
%>


			
		
		 
		