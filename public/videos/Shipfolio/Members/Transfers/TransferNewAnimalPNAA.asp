
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



Query =  "INSERT INTO Animals(CustID, FullName, ShortName, Category, ARI, CLAA, DOBday,  DOBMonth, DOBYear,   Breed, ExternalLink, Description, StudDescription, Owner )" 
				Query =  Query & " Values ('" &   session("PNAAID") & "' ,"
				Query =  Query &   " '" & SourceFullName & "' ,"
				Query =  Query &   " '" & SourceShortName & "' ,"
				Query =  Query &   " '" & SourceCategory & "' ,"
				Query =  Query &   " '" & SourceARI & "' ,"
				Query =  Query &   " '" & SourceCLAA & "' ,"
				Query =  Query &   " " & SourceDOBday & " ,"
				Query =  Query &   " " & SourceDOBMonth & " ,"
				Query =  Query &   " " & SourceDOBYear & " ,"
				Query =  Query &   " '" & SourceBreed & "' ,"
				Query =  Query &   " '" & SourceExternalLink & "' ,"
				Query =  Query &   " '" & SourceDescription & "' ,"
				Query =  Query &   " '" & SourceStudDescription & "' ,"
				Query =  Query &   " '" & SourceOwner  & "' )" 



'response.write(Query)	

Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(Databasepath2) 	& ";" 


DataConnection.Execute(Query) 

DataConnection.Close


Set conn = Nothing

	Databasepath2 = "../../../../../../Internet-host/pnaaalpacas/pnaa.org/DB/PNAA.mdb"
   Found = False
		conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
		"Data Source=" & server.mappath(Databasepath2) & ";" & _
						"User Id=;Password=;" 
			 sql = "select * from Animals where  CustID= " &   session("PNAAID")  & " and (FullName = '" &   SourceFullName  & "' or ARI = '" &   SourceARI  & "') ;" 
			'response.write(sql)
			Set rs = Server.CreateObject("ADODB.Recordset")
			rs.Open sql, conn, 3, 3   
			 If Not rs.eof Then
			    AnimalID = rs("ID")
				Found = True
			End if
			 rs.close
'response.write("animalID=")
'response.write(animalID)
' Update Ancestry 



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

str1 = SourceSireSire
str2 = "'"
If InStr(str1,str2) > 0 Then
	SourceSireSire= Replace(str1, "'", "''")
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

	

'response.write("Query=")	
'response.write(Query)	

Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(Databasepath2) 	& ";" 


 DataConnection.Execute(Query) 

DataConnection.Close


' Update Ancestry Percents

Query =  "INSERT INTO AncestryPercents(ID, PercentUnknownOther, PercentAccoyo, PercentChilean, PercentBolivian, PercentPeruvian )" 
				Query =  Query & " Values (" &  AnimalID & ", "
				Query =  Query &   " '" & SourcePercentUnknownOther & "' ,"
				Query =  Query &   " '" & SourcePercentAccoyo & "' ,"
				Query =  Query &   " '" & SourcePercentChilean & "' ,"
				Query =  Query &   " '" & SourcePercentBolivian & "' ,"
				Query =  Query &   " '" & SourcePercentPeruvian &  "' )" 


'response.write(Query)	


Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(Databasepath2) 	& ";" 


 DataConnection.Execute(Query) 

DataConnection.Close


Query =  " UPDATE Photos Set Photo1 = '" & SourcePhoto1 & "' ,"
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

'response.write(Query)	

Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(Databasepath2) 	& ";" 


 DataConnection.Execute(Query) 

DataConnection.Close


 ' Colors
Query =  "INSERT INTO Colors(ID, Color1, Color2, Color3, Color4, Color5 )" 
				Query =  Query & " Values (" &  AnimalID & ", "
				Query =  Query &   " '" & SourceColor1 & "' ,"
				Query =  Query &   " '" & SourceColor2 & "' ,"
				Query =  Query &   " '" & SourceColor3 & "' ,"
				Query =  Query &   " '" & SourceColor4 & "' ,"
				Query =  Query &   " '" & SourceColor5 &  "' )" 

'response.write(Query)	

Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(Databasepath2) 	& ";" 


 DataConnection.Execute(Query) 

DataConnection.Close




' Pricing

If Len(SourceStudFee) > 0 Then
Else
	SourceStudFee = 0
End If 






Query =  "INSERT INTO Pricing(ID, ForSale, StudFee, Price, SalePrice, PriceComments, Foundation, Discount, Sold, SalePending  )" 
				Query =  Query & " Values (" &  AnimalID & ", "
				Query =  Query &   " " & SourceForSale & " ,"
				Query =  Query &   " " & SourceStudFee & " ,"
				Query =  Query &   " " & SourcePrice & " ,"
				Query =  Query &   " '" & SourceSalePrice & "' ,"
				Query =  Query &   " '" & SourcePriceComments & "' ," 
				Query =  Query &   " " & SourceFoundation & " ," 
				Query =  Query &   " " & SourceDiscount & " ," 
				Query =  Query &   " " & SourceSold & " ," 			
				Query =  Query &   " " & SourceSalePending &  " )" 

response.write(Query)	


Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(Databasepath2) 	& ";" 


 DataConnection.Execute(Query) 

DataConnection.Close
 
 
 
 ' Awards 



			For rowcount = 1 To 20
				
       If Len(SourceAwardYear(rowcount) ) < 2 Then
				SourceAwardYear(rowcount) = "0"
	   End If
	   'response.write("SourcePlacingNumber(rowcount) =")
'response.write(SourcePlacingNumber(rowcount) )
	   
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
'response.write("querywww=")
'response.write(query)

				Set DataConnection = Server.CreateObject("ADODB.Connection")

				DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(Databasepath2) 	& ";" 

				 DataConnection.Execute(Query) 

				DataConnection.Close

           Next


' Fiber


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


			
		
		 
		