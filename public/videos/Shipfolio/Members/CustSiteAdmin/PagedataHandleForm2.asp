<html>
<HEAD>

       <link rel="stylesheet" type="text/css" href="style.css">

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
<!--#Include file="Globalvariables.asp"-->


<%

'rowcount = CInt
rowcount = 1
PageName=request.querystring("PageName")
Dim TextBlock
Dim Heading
Dim Text
Return = Request.querystring("Return")
response.write("return=" & Return)
TextBlock= Request.Form("TextBlock")
PageLayout2ID = Request.Form("TempPageLayout2ID")

Heading = Request.Form("Heading")
ImageID=Request.Form("ImageID")

Text1= Request.Form("Text") 
Text2= Request.Form("Text2") 
Text3= Request.Form("Text3") 
Text4= Request.Form("Text4") 
Text5= Request.Form("Text5") 
Text6= Request.Form("Text6") 
Text7= Request.Form("Text7") 
Text8= Request.Form("Text8") 
Text9= Request.Form("Text9") 
Text10= Request.Form("Text10") 
Text11= Request.Form("Text11") 
Text12= Request.Form("Text12") 
Text13= Request.Form("Text13") 
Text14= Request.Form("Text14") 
Text15= Request.Form("Text15") 
Text16= Request.Form("Text16") 


text = Text1 & Text2 & Text3  & Text4  & Text5  & Text6  & Text7  & Text8  & Text9  & Text10  & Text11  & Text12  & Text13  & Text14  & Text15  & Text16
response.write("text = " & text )
	str1 = text
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "''")
	End If  

	str1 = text
	str2 = "¡"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If  


	str1 = text
	str2 = "¢"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If  


	str1 = text
	str2 = "£"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If  

	str1 = text
	str2 = "¤"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
	
	str1 = text
	str2 = "¥"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "")
	End If 



		str1 = text
	str2 = "¦"
If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 


		str1 = text
	str2 = "§"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 

		str1 = text
	str2 = "¨"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
	



	str1 = text
	str2 = "©"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "&copy;")
	End If 

	str1 = text
	str2 = "ª"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 

	str1 = text
	str2 = "«"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 

	str1 = text
	str2 = "¬"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 


	str1 = text
	str2 = "¯"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 


	str1 = text
	str2 = "°"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 


	str1 = text
	str2 = "±"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 


	str1 = text
	str2 = "²"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "2")
	End If 


	str1 = text
	str2 = "¹"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "1")
	End If 


	str1 = text
	str2 = "³"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "3")
	End If 


	str1 = text
	str2 = "µ"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 





str1 = text
	str2 = "º"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "»"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "¾"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "¼"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "¿"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "À"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "Á"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "Â"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 

str1 = text
	str2 = "Ã"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 


str1 = text
	str2 = "|"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 

str1 = text
	str2 = "Ä"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 


str1 = text
	str2 = "Å"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 


str1 = text
	str2 = "Æ"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 


str1 = text
	str2 = "Ç"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 


str1 = text
	str2 = "È"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 


str1 = text
	str2 = "Ê"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 


str1 = text
	str2 = "Ë"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 


str1 = text
	str2 = "Ì"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 


str1 = text
	str2 = "Í"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 


str1 = text
	str2 = "Î"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 

str1 = text
	str2 = "Ï"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 

str1 = text
	str2 = "Ð"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 

str1 = text
	str2 = "Ñ"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 

str1 = text
	str2 = "Ò"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "Ó"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 

str1 = text
	str2 = "Ô"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 

str1 = text
	str2 = "Õ"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 

str1 = text
	str2 = "Ö"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 

str1 = text
	str2 = "Ø"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 

str1 = text
	str2 = "Ù"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 



str1 = text
	str2 = "Ü"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "Ý"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "Þ"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "ß"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "à"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "á"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "â"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "ã"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "ä"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "å"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "æ"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "ç"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "è"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "é"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "ê"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "ë"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 

str1 = text
	str2 = "ì"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 

str1 = text
	str2 = "í"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 

str1 = text
	str2 = "î"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 

str1 = text
	str2 = "ï"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 

str1 = text
	str2 = "ð"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 

str1 = text
	str2 = "ñ"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 

str1 = text
	str2 = "ò"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "ó"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "ô"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 

str1 = text
	str2 = "õ"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "ö"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "ø"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "ù"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "ú"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "û"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "ü"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "ý"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 
str1 = text
	str2 = "þ"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 

str1 = text
	str2 = "ÿ"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "BLARG")
	End If 

	


str1 = text
	str2 = "BLARG"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "")
	End If  





	str1 = text
	str2 = vbCrLf
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "</br>")
	End If  

	str1 = text
	str2 = vbtab
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
	End If 

	str1 = text
	str2 = vbVerticalTab
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
	End If 

	str1 = text
	str2 = vbLf 
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "&nbsp;")
	End If 

	str1 = text
	str2 = vbCr
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "</br>")
	End If  

	str1 = text
	str2 =vbFormFeed
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "</br>")
	End If  

	str1 = text
	str2 = vbNullChar
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "&nbsp;")
	End If 

	str1 = text
	str2 =vbNewline
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "</br>")
	End If  




response.write("text2=" & text)

str1 = heading
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "''")
	End If  



	str1 = heading
	str2 = "¡"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If  


	str1 = heading
	str2 = "¢"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If  


	str1 = heading
	str2 = "£"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If  

	str1 = heading
	str2 = "¤"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 
	
	str1 = heading
	str2 = "¥"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "")
	End If 



		str1 = heading
	str2 = "¦"
If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 


		str1 = heading
	str2 = "§"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 

		str1 = heading
	str2 = "¨"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 
	
	str1 = heading
	str2 = "©"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG4©")
	End If 

	str1 = heading
	str2 = "ª"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 

	str1 = heading
	str2 = "«"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 

	str1 = heading
	str2 = "¬"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 


	str1 = heading
	str2 = "¯"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 


	str1 = heading
	str2 = "°"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 


	str1 = heading
	str2 = "±"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 


	str1 = heading
	str2 = "²"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "2")
	End If 


	str1 = heading
	str2 = "¹"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "1")
	End If 


	str1 = heading
	str2 = "³"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "3")
	End If 


	str1 = heading
	str2 = "µ"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 





str1 = heading
	str2 = "º"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 
str1 = heading
	str2 = "»"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 
str1 = heading
	str2 = "¾"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 
str1 = heading
	str2 = "¼"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 
str1 = heading
	str2 = "¿"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 
str1 = heading
	str2 = "À"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 
str1 = heading
	str2 = "Á"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 
str1 = heading
	str2 = "Â"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 

str1 = heading
	str2 = "Ã"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 


str1 = heading
	str2 = "|"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 

str1 = heading
	str2 = "Ä"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 


str1 = heading
	str2 = "Å"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 


str1 = heading
	str2 = "Æ"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 


str1 = heading
	str2 = "Ç"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 


str1 = heading
	str2 = "È"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 


str1 = heading
	str2 = "Ê"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 


str1 = heading
	str2 = "Ë"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 


str1 = heading
	str2 = "Ì"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 


str1 = heading
	str2 = "Í"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 


str1 = heading
	str2 = "Î"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 

str1 = heading
	str2 = "Ï"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 

str1 = heading
	str2 = "Ð"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 

str1 = heading
	str2 = "Ñ"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 

str1 = heading
	str2 = "Ò"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 
str1 = heading
	str2 = "Ó"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 

str1 = heading
	str2 = "Ô"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 

str1 = heading
	str2 = "Õ"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 

str1 = heading
	str2 = "Ö"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 

str1 = heading
	str2 = "Ø"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 

str1 = heading
	str2 = "Ù"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 



str1 = heading
	str2 = "Ü"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 
str1 = heading
	str2 = "Ý"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 
str1 = heading
	str2 = "Þ"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 
str1 = heading
	str2 = "ß"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 
str1 = heading
	str2 = "à"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 
str1 = heading
	str2 = "á"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 
str1 = heading
	str2 = "â"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 
str1 = heading
	str2 = "ã"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 
str1 = heading
	str2 = "ä"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 
str1 = heading
	str2 = "å"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 
str1 = heading
	str2 = "æ"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 
str1 = heading
	str2 = "ç"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 
str1 = heading
	str2 = "è"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 
str1 = heading
	str2 = "é"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 
str1 = heading
	str2 = "ê"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 
str1 = heading
	str2 = "ë"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 


str1 = Heading	
str2 = "ì"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 


str1 = Heading	
str2 = "í"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 


str1 = Heading	
str2 = "î"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 


str1 = Heading	
str2 = "ï"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 


str1 = Heading	
str2 = "ð"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 


str1 = Heading	
str2 = "ñ"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 


str1 = Heading	
str2 = "ò"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 

str1 = Heading	
str2 = "ó"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 
str1 = Heading
	str2 = "ô"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 

str1 = Heading	
str2 = "õ"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 

str1 = Heading	
str2 = "ö"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 

str1 = Heading	
str2 = "ø"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 

str1 = Heading	
str2 = "ù"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 

	str1 = Heading
str2 = "ú"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 

str1 = Heading	
str2 = "û"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 

str1 = Heading	
str2 = "ü"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 

str1 = Heading	
str2 = "ý"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 

str1 = Heading	
str2 = "þ"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 

str1 = Heading
	str2 = "ÿ"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "BLARG")
	End If 

	


str1 = heading
	str2 = "BLARG"
	If InStr(str1,str2) > 0 Then
		heading= Replace(str1,  str2, "")
	End If  




	str1 = Heading
	str2 = vbCrLf
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "</br>")
	End If  

	str1 = Heading
	str2 = vbtab
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
	End If 

	str1 =Heading
	str2 = vbVerticalTab
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
	End If 

	str1 = Heading
	str2 = vbLf 
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "&nbsp;")
	End If 

	str1 = Heading
	str2 = vbCr
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "</br>")
	End If  

	str1 = Heading
	str2 =vbFormFeed
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "</br>")
	End If  

	str1 = Heading
	str2 = vbNullChar
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "&nbsp;")
	End If 

	str1 =Heading
	str2 =vbNewline
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "</br>")
	End If  





	Query =  " UPDATE PageLayout Set PageHeading2 = '" & Heading & "', "
	Query =  Query & " PageText2 = '" & Text & "'" 
    Query =  Query & " where PageName = '" & PageName & "';"  
	response.write(Query)	

	Set DataConnection = Server.CreateObject("ADODB.Connection")
	DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
	DataConnection.Execute(Query) 




IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 End If

	DataConnection.Close
	Set DataConnection = Nothing 
response.write("text3=" & text)

%>

<% 

 Response.Redirect("PageData.asp?PageName=" & PageName)
 %>
</Body>
</HTML>

