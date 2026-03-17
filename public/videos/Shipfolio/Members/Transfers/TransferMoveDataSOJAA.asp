	
	<%
str1 = SourceFullName
str2 = "'"
If InStr(str1,str2) > 0 Then
	SourceFullName= Replace(str1, "'", "''")
End If

'response.write("SourceFullName=")
'response.write(SourceFullName)


	Databasepath2 = "../../../../../../dbpro/sojaaorg/sojaaalpacas.com/DB/SOJAA.mdb"
   Found = False
		conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
		"Data Source=" & server.mappath(Databasepath2) & ";" & _
						"User Id=;Password=;" 
			 sql = "select * from Animals where  CustID= " &  session("SOJAAID") & " and (FullName = '" &   SourceFullName  & "' or ARI = '" &   SourceARI  & "') ;" 
			response.write(sql)
			Set rs = Server.CreateObject("ADODB.Recordset")
			rs.Open sql, conn, 3, 3   
			 If Not rs.eof Then
			    AnimalID = rs("ID")
				Found = True
			End if
			 rs.close

If SourceCategory = "Experienced Male" Then SourceCategory = "Male-Proven"
If SourceCategory = "Inexperienced Male" Then SourceCategory = "Male-Unproven"
If SourceCategory = "Experienced Female" Then SourceCategory = "Female-Proven"
If SourceCategory = "Inexperienced Female" Then SourceCategory = "Female-Unproven"


			If Found = True Then %>
				<!--#Include virtual="/Administration/Transfers/TransferFoundAnimal.asp"--> 

			<% Else %>
			
				<!--#Include virtual="/Administration/Transfers/TransferNewAnimal.asp"--> 

			<% End if


			 'conn = Nothing 

			%>



			<%' Ancestry 
		'	SourceDam
		'	SourceDamColor
		'	SourceDamARI
		'	SourceDamCLAA
		'	SourceDamLink
		'	SourceDamdam
		'	SourceDamDamColor
		'	SourceDamDamARI
		'	SourceDamDamCLAA
		'	SourceDamDamLink
		'	SourceDamsire
		'	SourceDamsireARI
		'	SourceDamsireCLAA
		'	SourceDamsireColo
		'	SourceDamsireLink
		'	SourceDamDamDam
		'	SourceDamDamDamARI
		'	SourceDamDamDamCLAA
		'	SourceDamDamDamColor
		'	SourceDamDamDamLink
		'	SourceDamDamSire
		'	SourceDamDamSireARI
		'	SourceDamDamSireCLAA
		'	SourceDamDamSireColor
		'	SourceDamDamSireLink
		'	SourceDamSireDam
		'	SourceDamSireDamARI
		'	SourceDamSireDamCLAA
		'	SourceDamSireDamColor
		'	SourceDamSireDamLink
		'	SourceDamSireSire
		'	SourceDamSireSireARI
		'	SourceDamSireSireCLAA
		'	SourceDamSireSireColor
		'	SourceDamSireSireLink
		'	SourceSire
		'	SourceSireColor
		'	SourceSireARI
		'	SourceSireCLAA
		'	SourceSireLink
		'	SourceSiredam
		'	SourceSiredamColor
		'	SourceSiredamARI
		'	SourceSiredamCLAA
		'	SourceSiredamLink
		'	SourceSireSire
		'	SourceSireSireColor
		'	SourceSireSireARI
		'	SourceSireSireCLAA
		'	SourceSireSireLink
		'	SourceSireDamDam
		'	SourceSireDamDamColor
		'	SourceSireDamDamARI
		'	SourceSireDamDamCLAA
		'	SourceSireDamDamLink
		'	SourceSireDamSire
		'	SourceSireDamSireColor
		'	SourceSireDamSireARI
		'	SourceSireDamSireCLAA
		'	SourceSireDamSireLink
		'	SourceSireSireDam
		'	SourceSireSireDamColor
		'	SourceSireSireDamARI
		'	SourceSireSireDamCLAA
		'	SourceSireSireDamLink
		'	SourceSireSireSire
		'	SourceSireSireSireColor
		'	SourceSireSireSireARI
		'	SourceSireSireSireCLAA
		'	SourceSireSireSireLink



			' AncestryPercents 
			
		'		SourcePercentPeruvian
		'		SourcePercentBolivian
		'		SourcePercentChilean
		'		SourcePercentAccoyo
		'		SourcePercentUnknownOther
			
			 
		' Animals 
			 
			'	SourceFullName
			'	SourceShortName
			'	SourceCategory
			'	SourceARI
			'	SourceCLAA
			'	SourceDOBday
			'	SourceDOBMonth
			'	SourceDOBYear
			'	SourceBreed
			'	SourceExternalLink
			'	SourceDescription
			'	SourceStudDescription
			'	SourceOwner

		 ' Awards 
			
		'		SourceShow
		'		SourceAwardYear
		'		SourceType
		'		SourcePlacingNumber
		'		SourcePlacing
		'		SourceClass
		'		SourceJudge
		'		SourceShowYear
		'		SourceAwardcomments
		'		SourceShowLevel
		

		' Colors 
			'	SourceColor1
			'	SourceColor2
			'	SourceColor3
			'	SourceColor4
			'	SourceColor5
			
'Fiber 

	'				SourceSampleDate
	'				SourceSampleAge
	'				SourceAverage
	'				SourceStandardDev
	'				SourceCOV
	'				SourceGreaterThan30
	'				SourceCF
	'				SourceCurve
	'				SourceShearweight
	'				SourceBlanketWeight
	'				SourceLength
	'				SourceCrimpPerInch
	'				SourceLargeHistogram
	'				SourceSmallHistogram
		
 'Pricing 
	'			SourceForSale
	'			SourceStudFee
	'			SourceShowOnABH
	'			SourceShowOnAC
	'			SourceShowOnASZ
	'			SourceShowOnAP
	'			SourcePrice
	'			SourceSalePrice
	'			SourcePriceComments
	'			SourceFoundation
	'			SourceDiscount
	'			SourceSold
	'			SourceSalePending
	%>