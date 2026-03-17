<% 'Global Variables
Dim DatabasePath
Dim AdministrationPath
Dim WebSiteName
Dim Slogan
Dim Breed
Dim PhysicalPath
Dim BorderColor
Dim BackgroundColor
Dim style
Dim ScreenBackgroundColor


'**************************************************************
 ' Hard Coded Variables
'**************************************************************
DatabasePath = "/DB/AGCMSDB.mdb"
style = "Style.css"


'**************************************************************
 ' Define Conn Object
'**************************************************************
	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
	"Data Source=" & server.mappath(DatabasePath) & ";" & _
	"User Id=;Password=;" '& _ 
			Set rs = Server.CreateObject("ADODB.Recordset")


'**************************************************************
 ' Open RecordSet For Page Info
'**************************************************************
sql = "select * from Sitedesign "
'response.write(sql)
rs.Open sql, conn, 3, 3
If Not rs.eof then
'**************************************************************
 ' Gather List of Pages
'**************************************************************


OwnerPeopleID = 667

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(databasepath) & ";" & _
"User Id=;Password=;" 
 sql = "select * from People where Peopleid=" & OwnerPeopleID
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

	BusinessID = rs("BusinessID")

rs.close

 sql = "select * from Business where BusinessID=" & BusinessID
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

	BusinessName = rs("BusinessName")

rs.close


  sql = "select * from SiteDesignTemp where Peopleid=" & OwnerPeopleID
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
Header = rs("Header")
logo = rs("Logo")

LayoutStyle = rs("LayoutStyle")
Pagewidth = rs("Pagewidth")
MenuBackgroundColor = rs("MenuBackgroundColor")
MenuBackgroundImage = rs("MenuBackgroundImage")
PageBackgroundColor = rs("PageBackgroundColor")
PageBackgroundImage = rs("PageBackgroundImage")
ScreenBackgroundColor = rs("ScreenBackgroundColor")
ScreenBackgroundImage = rs("ScreenBackgroundImage")
AnimalListbackgroundColor = rs("AnimalListbackgroundColor")
AnimalListbackgroundColor = rs("AnimalListbackgroundImage")
MenuColor = rs("MenuColor")
FooterColor = rs("FooterColor")
FooterImage = rs("FooterImage")
PageAlign = rs("PageAlign")
PageBorder = rs("PageBorder")
PageBorderColor = rs("PageBorderColor")
PageWidth = rs("PageWidth")

rColor = DBPageBorderColor	

if LayoutStyle = "Landscape" then
	PageWidth = PageWidth/2
	TextWidth = PageWidth - 10 
End if 

if LayoutStyle = "Portrait" or LayoutStyle = "Portrait2" then
	PageWidth = PageWidth/2
	TextWidth = PageWidth -210 
End if 

tempfont = FooterTextFont %>
   <!--#Include file="AdminConvertFontInclude.asp"--> 

<% tempfont = TitleFont %>
     <!--#Include file="AdminConvertFontInclude.asp"--> 
   
<% TitleFont = tempfont	
					
tempfont = MenuFont %>
   <!--#Include file="AdminConvertFontInclude.asp"--> 
   
<% MenuFont = tempfont	

tempfont = PageTextFont %>
   <!--#Include file="AdminConvertFontInclude.asp"-->  
   
<% PageTextFont = tempfont	

					
'**************************************************************
 ' Style
'**************************************************************
%>

<style>
	
		.footer {font: <%=FooterTextSize%>pt <%=FooterTextFont %>; font-weight:  <%=FooterWeight %> ;  <% if FooterItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=FooterTextColor%> ; text-align: <%=FooterAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize +2 %>px; PADDING-TOP: 0px; }
		A.footer {font: <%=FooterTextSize%>pt <%=FooterTextFont%>; font-weight:  <%=FooterWeight %> ;  <% if FooterItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=FooterHyperlinkColor %>; text-decoration :none; text-align: <%=FooterAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=FooterTextSize +2 %>px; PADDING-TOP: 0px; }
		A.footer:hover {font: <%=FooterTextSize%>pt <%=FooterTextFont%>; color: <%=FooterMouseOverColor%> ; text-decoration :none; font-weight:  <%=FooterWeight %> ;  <% if FooterItalics = "Yes" then %> font-style: italic;<% end if %>  text-align: <%=FooterAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=FooterTextSize +2 %>px; PADDING-TOP: 0px; }

		H1 {font: <%=TitleSize - 20 %>pt <%=TitleFont %>; font-weight:  <%=TitleWeight %> ;  <% if TitleItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=TitleColor %>; text-align: <%=TitleAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize + 36 %>px; PADDING-TOP: 0px; }
		H2 {font: <%=H2Size %>pt <%=H2Font %>;  font-weight:  <%=TitleWeight %> ;  <% if TitleItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=H2Color %>; text-align: <%=H2Align %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize + 26 %>px; PADDING-TOP: 0px; }
		H3 {font: <%=H3Size %>pt <%=H3Font %>;  font-weight:  <%=TitleWeight %> ;  <% if TitleItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=H3Color %>; text-align: <%=H3Align %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize + 6 %>px; PADDING-TOP: 0px; }

		LI UL {font: <%=PageTextFontSize%>pt <%=PageTextFont%>; color: <%=PageTextHyperlinkColor %>; text-decoration :none;}
		.Body {font: <%=PageTextFontSize%>pt <%=PageTextFont%>;  font-weight:  <%=PageTextWeight %> ;  <% if PageTextItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=PageTextColor %>; text-align: <%=PageTextAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize +2 %>px; PADDING-TOP: 0px; }
		A.Body {font: <%=PageTextFontSize%>pt <%=PageTextFont%>; font-weight:  <%=PageTextWeight %> ;  <% if PageTextItalics = "Yes" then %> font-style: italic;<% end if %>  color: <%=PageTextHyperlinkColor %>; text-decoration :none; text-align: <%=PageTextAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize +2 %>px; PADDING-TOP: 0px; }
		A.Body:hover {font: <%=PageTextFontSize%>pt <%=PageTextFont%>; font-weight:  <%=PageTextWeight %> ;  <% if PageTextItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=PageTextMouseOverColor %> ; text-decoration :none; text-align: <%=PageTextAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize +2 %>px; PADDING-TOP: 0px; }
		
		
		.Menu {font: <%=MenuSize%>pt <%=MenuFont%>; font-weight:  <%=MenuWeight %> ;  <% if MenuItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=MenuColor %>; text-align: center; text-align: <%=MenuAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize +2 %>px; PADDING-TOP: 0px; }
		A.Menu {font: <%=MenuSize%>pt <%=MenuFont%>; font-weight:  <%=MenuWeight %> ;  <% if MenuItalics = "Yes" then %> font-style: italic;<% end if %>  color: <%=MenuColor %> ; text-decoration :none; text-align: <%=MenuAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize +2 %>px; PADDING-TOP: 0px; }
		A.Menu:Hover { font: <%=MenuSize%>pt <%=MenuFont%>; font-weight:  <%=MenuWeight %> ;  <% if MenuItalics = "Yes" then %> font-style: italic;<% end if %>  color: <%=MenuFontMouseOverColor %> ; text-align: <%=MenuAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize +2 %>px; PADDING-TOP: 0px; }
		
	
</style>


<%
End If 
'**************************************************************
 ' Close RecordSet
'**************************************************************
Rs.close


'**************************************************************
 ' Get Links
'**************************************************************
dim PageNameArray(100)
dim FileNameArray(100)

sql = "select Linkname, FileName from PageLayout where PageAvailable = True order by LinkOrder" 
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
x=1
while not rs.eof	
	PageNameArray(x) = rs("Linkname")
	FileNameArray(x) = rs("FileName")
	x = x + 1
	rs.movenext
wend
totalpages = x -1
				

'**************************************************************
 ' Close RecordSet
'**************************************************************
Rs.close


'**************************************************************
 ' Open RecordSet For Page Info
'**************************************************************
sql = "select * from pageLayout where PageName = '" & PageName & "';"
'response.write(sql)
rs.Open sql, conn, 3, 3
If Not rs.eof then
'**************************************************************
 ' Gather List of Pages
'**************************************************************

PageText = rs("PageText")
PageTitle = rs("PageTitle")

PageHeading1= rs("PageHeading1")
PageHeading2= rs("PageHeading2")
PageHeading3= rs("PageHeading3")
PageHeading4= rs("PageHeading4")
								
PageText1 = rs("PageText1")
PageText2 = rs("PageText2")
PageText3 = rs("PageText3")
PageText4 = rs("PageText4")
					
Image1= rs("Image1")
Image2= rs("Image2")
Image3= rs("Image3")
Image4= rs("Image4")

ImageCaption1= rs("ImageCaption1")
ImageCaption2= rs("ImageCaption2")
ImageCaption3= rs("ImageCaption3")
ImageCaption4= rs("ImageCaption4")

ImageOrientation1= rs("ImageOrientation1")
ImageOrientation2= rs("ImageOrientation2")
ImageOrientation3= rs("ImageOrientation3")
ImageOrientation4= rs("ImageOrientation4")

End If 
'**************************************************************
 ' Close RecordSet
'**************************************************************
Rs.close

'**************************************************************
 ' Open RecordSet For SEO
'**************************************************************
			sql = "select * from PageSEO where Pagename = '" & PageName & "';"
			'response.write(sql)
			rs.Open sql, conn, 3, 3
If Not rs.eof then
'**************************************************************
 ' Gather List of Pages
'*****************************************************
SEOTitle = rs("Title")
SEODescription = rs("Description")
SEOKeyword1 = rs("Keyword1")
SEOKeyword2 = rs("Keyword2")
SEOKeyword3 = rs("Keyword3")
SEOKeyword4 = rs("Keyword4")
SEOKeyword5 = rs("Keyword5")
SEOKeyword6 = rs("Keyword6")
SEOKeyword7 = rs("Keyword7")
SEOKeyword8 = rs("Keyword8")
SEOKeyword9 = rs("Keyword9")
SEOKeyword10 = rs("Keyword10")
SEOKeyword11 = rs("Keyword11")
SEOKeyword12 = rs("Keyword12")
SEOKeyword13 = rs("Keyword13")
SEOKeyword14 = rs("Keyword14")
SEOKeyword15 = rs("Keyword15")
SEOKeyword16 = rs("Keyword16")
SEOKeyword17 = rs("Keyword17")
SEOKeyword18 = rs("Keyword18")
SEOKeyword19 = rs("Keyword19")
SEOKeyword20 = rs("Keyword20")
End if
'**************************************************************
 ' Close RecordSet
'**************************************************************
Rs.close


'**************************************************************
 ' Open RecordSet From sfCustomer
'**************************************************************
sql = "select * from People where PeopleID = " & OwnerPeopleID
'response.write(sql)
rs.Open sql, conn, 3, 3
If Not rs.eof then
FavIcon= rs("FavIcon")
FavIconShortcut=  rs("FavIcon")
end if 

'**************************************************************
 ' Close RecordSet
'**************************************************************
Rs.close

%>

