<HTML>
<HEAD>
 <title>Layout Submit</title>
       <link rel="stylesheet" type="text/css" href="/Administration/style.css">
<!--#Include file="AdminGlobalVariables.asp"--> 
</HEAD>
<body >

<%
'rowcount = CInt
rowcount = 1

Dim MenuBackground
Dim MenuFontColor
Dim MenuFontMouseOverColor
Dim TitleFontColor
Dim PageBackgroundColor
Dim PageTextColor
Dim LayoutStyle
Dim ScreenBackgroundColor
Dim PageTextHyperlinkColor

PageName = request.form("PageName") 
response.Write("PageName=" & PageName )

' Pull Stles from SiteDesign TEMP ****************************************
 sql = "select * from SiteDesignTemp where Peopleid= " & PeopleID & ";" 
'response.write(sql)
		
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
Header = rs("Header")
logo = rs("Logo")

LayoutStyle = rs("LayoutStyle")
FooterImage = rs("FooterImage")

Pagewidth = rs("Pagewidth")
PageAlign = rs("PageAlign")

PicturesBorder = rs("PicturesBorder")
PicturesBorderSize = rs("PicturesBorderSize")
PicturesBorderColor = rs("PicturesBorderColor")
PicturesShadow = rs("PicturesShadow")

PageBorder = rs("PageBorder")
PageBorderColor = rs("PageBorderColor")

MenuHyperlinkColor = rs("MenuHyperlinkColor")
Dim str1
Dim str2
str1 = MenuHyperlinkColor
str2 = "'"
If InStr(str1,str2) > 0 Then
	MenuHyperlinkColor= Replace(str1,  str2, "")
End If  
MenuBackgroundColor = rs("MenuBackgroundColor")
str1 = MenuBackgroundColor
str2 = "'"
If InStr(str1,str2) > 0 Then
	MenuBackgroundColor= Replace(str1,  str2, "")
End If 

MenuBackgroundImage = rs("MenuBackgroundImage")
PageBackgroundColor = rs("PageBackgroundColor")
PageBackgroundImage = rs("PageBackgroundImage")

ScreenBackgroundColor = rs("ScreenBackgroundColor")
ScreenBackgroundImage = rs("ScreenBackgroundImage")
NonRepeatingScreenBackgroundImage= rs("NonRepeatingScreenBackgroundImage")
AnimalListbackgroundColor = rs("AnimalListbackgroundColor")
AnimalListbackgroundColor = rs("AnimalListbackgroundImage")

TitleColor = rs("TitleColor")
TitleFont = rs("TitleFont")
TitleSize = rs("TitleSize")
TitleAlign = rs("TitleAlign")
TitleWeight = rs("TitleWeight")
TitleItalics = rs("TitleItalics")

MenuColor = rs("MenuColor")
str1 = MenuColor
str2 = "'"
If InStr(str1,str2) > 0 Then
	MenuColor= Replace(str1,  str2, "")
End If  

MenuDropdownColor  = rs("MenuDropdownColor")
MenuShadow = rs("MenuShadow")
MenuRoundedCorners = rs("MenuRoundedCorners")
FooterShadow = rs("FooterShadow")
FooterRoundedCorners = rs("FooterRoundedCorners")

MenuDropdownColorMouseover = rs("MenuDropdownColorMouseover")
MenuFontMouseOverColor = rs("MenuFontMouseOverColor")
MenuSize = rs("MenuSize")
MenuFont = rs("MenuFont")
MenuAlign = rs("MenuAlign")
MenuWeight = rs("MenuWeight")
MenuItalics = rs("MenuItalics")


PageTextColor = rs("PageTextColor")
PageTextFontsize = rs("PageTextFontSize")
PageTextFont = rs("PageTextFont")
PageTextHyperlinkColor = rs("PageTextHyperlinkColor")
PageTextMouseOverColor = rs("PageTextMouseOverColor")
PageTextAlign = rs("PageTextAlign")
PageTextWeight = rs("PageTextWeight")
PageTextItalics = rs("PageTextItalics")


FooterColor = rs("FooterColor")
FooterTextColor = rs("FooterTextColor")
FooterTextSize = rs("FooterTextSize")
FooterFont = rs("FooterTextFont")
str1 = FooterFont
str2 = "'"
If InStr(str1,str2) > 0 Then
	FooterFont= Replace(str1,  str2, "")
End If  

FooterHyperlinkColor = rs("FooterHyperlinkColor")
str1 = FooterHyperlinkColor
str2 = "'"
If InStr(str1,str2) > 0 Then
	FooterHyperlinkColor= Replace(str1,  str2, "")
End If  

FooterMouseOverColor = rs("FooterMouseOverColor")
FooterAlign = rs("FooterAlign")
FooterWeight = rs("FooterWeight")
FooterItalics = rs("FooterItalics")
FooterImage = rs("FooterImage")


H2Color = rs("H2Color")
H2size = rs("H2Size")
H2Font = rs("H2Font")
H2HyperlinkColor = rs("H2HyperlinkColor")
H2MouseOverColor = rs("H2MouseOverColor")
H2Align = rs("H2Align")
H2Weight = rs("H2Weight")
H2Italics = rs("H2Italics")


H3Color = rs("H3Color")
H3size = rs("H3Size")
H3Font = rs("H3Font")
H3HyperlinkColor = rs("H3HyperlinkColor")
H3MouseOverColor = rs("H3MouseOverColor")
H3Align = rs("H3Align")
H3Weight = rs("H3Weight")
H3Italics = rs("H3Italics")


H4Color = rs("H4Color")
H4size = rs("H4Size")
H4Font = rs("H4Font")
H4HyperlinkColor = rs("H4HyperlinkColor")
H4MouseOverColor = rs("H4MouseOverColor")
H4Align = rs("H4Align")
H4Weight = rs("H4Weight")
H4Italics = rs("H4Italics")



If Not Len(ScreenBackgroundColor) > 1 Then
	ScreenBackgroundColor = "White"
End If 

If Not Len(MenuBackgroundColor) > 1 Then
	MenuBackground = "White"
End If 

If Not Len(MenuFontColor) > 1 Then
	MenuFontColor = "Black"
End If 

If Not Len(MenuFontMouseOverColor) > 1 Then
	MenuFontMouseOverColor = "Red"
End If 
If Not Len(TitleFontColor) > 1 Then
	TitleFontColor = "Black"
End If 
If Not Len(PageBackgroundColor) > 1 Then
	PageBackgroundColor = "White"
End If 
If Not Len(AnimalListbackground) > 1 Then
	AnimalListbackground = "White"
End If 


If Not Len(FooterColor) > 1 Then
	PageTextColor = "Black"
End If 



If Not Len(PageTextColor) > 1 Then
	PageTextColor = "White"
End If 

If Not Len(H2Color) > 1 Then
	H2Color = "Black"
End If 

If Not Len(H3Color) > 1 Then
	H3Color = "Black"
End If 

If Not Len(H4Color) > 1 Then
	H4Color = "Black"
End If 


If Not Len(LayoutStyle) > 1 Then
	LayoutStyle = "Portrait"
End If 

If Not Len(PageTextHyperlinkColor) > 1 Then
	PageTextHyperlinkColor = "blue"
End If 

If Not Len(PageTextMouseOverColor) > 1 Then
	PageTextMouseOverColor = "black"
End If 


If Not Len(TitleAlign) > 1 Then
	TitleAlign = "Center"
End If 

If Not Len(MenuAlign) > 1 Then
	MenuAlign = "Center"
End If 

If Not Len(PageTextAlign) > 1 Then
	PageTextAlign = "Left"
End If 

If Not Len(H2Align) > 1 Then
	H2Align = "Center"
End If 

If Not Len(H3Align) > 1 Then
	H3Align = "Center"
End If 

If Not Len(H4Align) > 1 Then
	H4Align = "Center"
End If 

  
  

 str1 = Header
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		Header= Replace(str1,  str2, "''")
	End If  



if len(PicturesBorder) < 1 then
  PicturesBorder = "Yes"
end if

if len(PicturesShadow) < 1 then
  PicturesShadow= "Yes"
end if

if len(PicturesBorderSize) < 1 then
  PicturesBorderSize= "0"
end if
if len(MenuShadow) < 1 then
MenuShadow = 0
end if

if len(FooterShadow) < 1 then
FooterShadow = 0
end if

if len(PicturesShadow) < 1 then
PicturesShadow = 0
end if


if len(FooterRoundedCorners) < 1 then
FooterRoundedCorners = 0
end if

if len(PicturesBorder) < 1 then
PicturesBorder = 0
end if





' Put Styles into SiteDesign ACTUAL ****************************************

	Query =  " UPDATE SiteDesign Set MenuBackgroundColor= '" & MenuBackgroundColor & "' ,"
	Query =  Query & "  MenuBackgroundImage = '" & MenuBackgroundImage & "' ,"
	Query =  Query & " PageBackgroundColor = '" & PageBackgroundColor & "' ,"
	
	Query =  Query & " PageBorder = '" & PageBorder & "' ,"
	Query =  Query & " PageBorderColor = '" & PageBorderColor & "' ,"
	Query =  Query & " Header = '" & Header & "' ,"
	
	Query =  Query & " PageBackgroundImage = '" & PageBackgroundImage & "' ,"
	Query =  Query & " ScreenBackgroundColor = '" & ScreenBackgroundColor & "' ,"
	Query =  Query & " ScreenBackgroundImage = '" & ScreenBackgroundImage & "' ,"
	Query =  Query & " NonRepeatingScreenBackgroundImage = '" & NonRepeatingScreenBackgroundImage & "' ,"
	
	Query =  Query & " AnimalListBackgroundColor = '" & AnimalListBackgroundColor & "' ,"
	Query =  Query & " AnimalListBackgroundImage = '" & AnimalListBackgroundImage & "' ,"
	Query =  Query & " TitleColor = '" & TitleColor  & "' ,"
	Query =  Query & " TitleFont = '" & TitleFont  & "' ,"
	Query =  Query & " TitleSize = '" & TitleSize & "' ,"
	Query =  Query & " TitleAlign = '" & TitleAlign & "' ,"
	Query =  Query & " TitleWeight = '" & TitleWeight & "' ,"
	Query =  Query & " TitleItalics = '" & TitleItalics & "' ,"

	Query =  Query & "  MenuColor= '" & MenuColor & "' ,"
	Query =  Query & "  MenuDropdownColor= '" & MenuDropdownColor & "' ,"
	Query =  Query & "  MenuShadow = " & MenuShadow & " ,"
	Query =  Query & "  MenuRoundedCorners= " & MenuRoundedCorners & " ,"
	
	Query =  Query & " MenuFontMouseOverColor = '" & MenuFontMouseOverColor & "' ,"
	Query =  Query & "  MenuSize= '" & MenuSize & "' ,"
	Query =  Query & "  MenuFont= '" & MenuFont & "' ,"
	Query =  Query & "  MenuAlign= '" & MenuAlign & "' ,"
	Query =  Query & " MenuWeight = '" & MenuWeight & "' ,"
	Query =  Query & " MenuItalics = '" & MenuItalics & "' ,"
	Query =  Query & " MenuHyperlinkColor = '" & MenuHyperlinkColor & "' ,"
	Query =  Query & " MenuDropdownColorMouseover = '" & MenuDropdownColorMouseover & "' ,"
		
	Query =  Query & " PageTextColor = '" & PageTextColor & "' ,"
	Query =  Query & " PageTextFont = '" & PageTextFont & "' ,"
	Query =  Query & " PageTextFontSize = '" & PageTextFontSize & "' ,"
	Query =  Query & " PageTextHyperlinkColor = '" & PageTextHyperlinkColor & "' ,"
	Query =  Query & " PageTextMouseOverColor = '" & PageTextMouseOverColor & "' ,"
	Query =  Query & " PageTextAlign = '" & PageTextAlign & "' ,"
	Query =  Query & " PageTextWeight = '" & PageTextWeight & "' ,"
	Query =  Query & " PageTextItalics = '" & PageTextItalics & "' ,"

	Query =  Query & " FooterColor = '" & FooterColor & "' ,"
	Query =  Query & " FooterTextColor = '" & FooterTextColor & "' ,"
	Query =  Query & " FooterTextFont = '" & FooterFont & "' ,"
	Query =  Query & " FooterHyperlinkColor = '" & FooterHyperlinkColor & "' ,"
	Query =  Query & " FooterMouseOverColor = '" & FooterMouseOverColor & "' ,"
	Query =  Query & " FooterTextSize = '" & FooterTextSize & "' ,"
	Query =  Query & " FooterAlign = '" & FooterAlign & "' ,"
	Query =  Query & " FooterWeight = '" & FooterWeight & "' ,"
	Query =  Query & " FooterItalics = '" & FooterItalics & "' ,"
	Query =  Query & " FooterImage = '" & FooterImage & "' ,"
	Query =  Query & " FooterShadow = " & FooterShadow & " ,"
	Query =  Query & " FooterRoundedCorners= " & FooterRoundedCorners & " ,"

	
	Query =  Query & " PicturesBorder = " & PicturesBorder & " ,"
	Query =  Query & " PicturesBorderSize = '" & PicturesBorderSize & "' ,"
	Query =  Query & " PicturesBorderColor = '" & PicturesBorderColor & "' ,"
	Query =  Query & " PicturesShadow = " & PicturesShadow & " ,"

	Query =  Query & " H2Color = '" & H2Color & "' ,"
	Query =  Query & " H2Font = '" & H2Font & "' ,"
	Query =  Query & " H2HyperlinkColor = '" & H2HyperlinkColor & "' ,"
	Query =  Query & " H2MouseOverColor = '" & H2MouseOverColor & "' ,"
	Query =  Query & " H2Size = '" & H2Size & "' ,"
	Query =  Query & " H2Align = '" & H2Align & "' ,"
	Query =  Query & " H2Weight = '" & H2Weight & "' ,"
	Query =  Query & " H2Italics = '" & H2Italics & "' ,"

	Query =  Query & " H3Color = '" & H3Color & "' ,"
	Query =  Query & " H3Font = '" & H3Font & "' ,"
	Query =  Query & " H3HyperlinkColor = '" & H3HyperlinkColor & "' ,"
	Query =  Query & " H3MouseOverColor = '" & H3MouseOverColor & "' ,"
	Query =  Query & " H3Size = '" & H3Size & "' ,"
	Query =  Query & " H3Align = '" & H3Align & "' ,"
	Query =  Query & " H3Weight = '" & H3Weight & "' ,"
	Query =  Query & " H3Italics = '" & H3Italics & "' ,"


	Query =  Query & " H4Color = '" & H4Color & "' ,"
	Query =  Query & " H4Font = '" & H4Font & "' ,"
	Query =  Query & " H4HyperlinkColor = '" & H4HyperlinkColor & "' ,"
	Query =  Query & " H4MouseOverColor = '" & H4MouseOverColor & "' ,"
	Query =  Query & " H4Size = '" & H4Size & "' ,"
	Query =  Query & " H4Align = '" & H4Align & "' ,"		
	Query =  Query & " H4Weight = '" & H4Weight & "' ,"
	Query =  Query & " H4Italics = '" & H4Italics & "' ,"
	Query =  Query & " LayoutStyle = '" & LayoutStyle & "' "
    Query =  Query & " where PeopleID = " & PeopleID & ";" 
	response.write("<br/><br/>Query=" & Query)	

Conn.Execute(Query) 



if PageName = "layout" then
Response.Redirect("AdminStandardStylesMaster.asp")
else
Response.Redirect("AdminLayoutEdit.asp")
end if %>


</Body>
</HTML>
