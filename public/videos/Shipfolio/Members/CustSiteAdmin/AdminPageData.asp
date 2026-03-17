<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">

<%  Current3 = "AddaPage"   %> 
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->

<% PagelayoutID =Request.Querystring("PagelayoutID" ) 
If Len(PagelayoutID) = 0 then
	PagelayoutID=Request.Form("PagelayoutID") 
End If

if len(Pagename) > 0 then
else
 Pagename = request.form("Pagename")
End if

if len(Pagename) > 0 then
else
 'Pagename = session("PageName")
end if


Pagelayoutid = request.querystring("Pagelayoutid")

	'response.write("Pagelayoutid=" & Pagelayoutid )

if len(Pagelayoutid) < 2 then
else
PageName = request.querystring("PageName")
end if


if len(PagelayoutID) > 0 then
 sql = "select * from Pagelayout where PagelayoutID = " & PagelayoutID & "" 
else
 sql = "select * from Pagelayout where peopleid=" & PeoplID & " and PageName = '" & PageName & "'"
end if

'response.write("SQL=" & SQL)

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
PagelayoutID= rs("PagelayoutID")   
PageGroupID = rs("PageGroupID")
PageName = rs("PageName")
'response.Write("pagename=" & pagename)
session("PageName") = PageName
PageTitle = rs("PageTitle")
LinkName= rs("LinkName")
ShowPage = rs("ShowPage")
TopImage= rs("TopImage")
str1 = PageTitle
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, " ")
End If 

str1 = PageTitle
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "'")
End If 
rs.close


dim ImageOrientation(100)	
dim PageText(100)
dim Image(100)
dim ImageCaption(100)
dim PageLayout2ID(100)
 sql = "select * from Pagelayout2 where PagelayoutID = " & PagelayoutID & ""	
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
i = 0
while not rs.eof
TotalTextBlocks = rs.recordcount
i = i + 1
PageText(i) = rs("PageText")
Image(i)= rs("Image")
ImageCaption(i)= rs("ImageCaption")
PageLayout2ID(i)=rs("PageLayout2ID")
ImageOrientation(i)=rs("ImageOrientation")
if ImageCaption(i) = "0" then
   ImageCaption(i) = ""
end if
if ((len(PageText(i) ) > 0 or len(Image(i)) > 0) and i = TotalTextBlocks)  then


Query =  "INSERT INTO PageLayout2 ( PageLayoutID,  BlockNum)" 
Query =  Query & " Values (" &  PageLayoutID & " ,"
Query =  Query &  " " & i + 1  & ")" 

response.Write("Query=" & Query )
Conn.Execute(Query) 

response.Redirect("AdminPageData.asp?PageLayoutID=" & PagelayoutID & "#Textblock" & i)

end if


str1 =  ImageCaption(i)
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption(i)= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption(i)
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption(i)= Replace(str1,  str2, "'")
End If 


str1 = PageText(i)
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText(i)= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText(i)
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText(i)= Replace(str1,  str2, " ")
End If 

str1 = PageText(i)
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText(i)= Replace(str1,  str2, "'")
End If 

str1 = PageText(i)
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText(i)= Replace(str1, str2 , vbCrLf)
End If  

rs.movenext
wend

if len(PageGroupID)> 0 then
sqlg = "select * from PageGroups where PageGroupID = " & PageGroupID
Set rsg = Server.CreateObject("ADODB.Recordset")
rsg.Open sqlg, conn, 3, 3 
if not rsg.eof then
PageGroupTitle = rsg("PageGroupTitle")
end if
rsg.close 
end if 


if TotalTextBlocks < 8 then


Query =  "INSERT INTO PageLayout2 ( PageLayoutID,  BlockNum)" 
Query =  Query & " Values (" &  PageLayoutID & " ,"
Query =  Query &  " " & i + 1  & ")" 

response.Write("Query=" & Query )
Conn.Execute(Query) 

response.Redirect("AdminPageData.asp?PageLayoutID=" & PagelayoutID & "#Textblock" & i)

end if
%>

</head>
<body>
<!--#Include virtual="/members/MembersHeader.asp"-->

<!--#Include virtual="/Members/CustSiteAdmin/AdminPagesTabsInclude.asp"-->

<div class ="container roundedtopandbottom" >
<H1><%=PageName %> Page Content</H1>
 

<div class="row d-flex">
    <div class="col-md-6 col-sm-12 order-sm-1 roundedtopandbottomgrey" style="min-height: 600px">
		  <div class="row">
			<div class="col body">
				<H1><div align = "left">Basic Facts</div></H1>
			  </div>
		  </div>


		<% str1 = PageTitle
		str2 = "'"
		If InStr(str1,str2) > 0 Then
			PageTitle= Replace(str1,  str2, "&#39")
		End If 
		'rs.close
		 %>

		<div class="row">
			<div class="col body">
		
				<form action= 'AdminPageDataHandleForm.asp' method = "post">
				<input name="TextBlock"  size = "60" value = "Heading" type = "hidden">
				<input name="PageLayoutID"  value = "<%=PageLayoutID %>" type = "hidden">

				Page Name
			</div>
		</div>
		<div class="row">
			<div class="col">
				<input name="PageName" value= '<%=PageName%>' size = "20" maxsize = "20" class = 'formbox'>
			</div>
		</div>
		<div class="row">
			<div class="col body">
				<b>Menu Title:*</b>
			</div>
			</div>
		<div class="row">
			<div class="col">
				<input name="LinkName" value= '<%=LinkName%>' size = "20" maxsize = "20" class = 'formbox'><br />
			   <font color = "gray">Max. length = 20 charecters</font>
			</div>
		</div>


		<% if MenuDropdowns  = "Yes" or MenuDropdowns = True then %>
		<div class="row">
			<div class="col body">
				<b>Page Group:*</b></div>
			</div>
			</div>
		<div class="row">
			<div class="col body">
				<select size="1" name="PagegroupID">
				<% if len(PageGroupTitle) > 2 then %>
					<option name = "AID1" value="<%=PageGroupID %>">
						<%=PageGroupTitle %>
					</option>
				<% else %>
					<option name = "AID1" value="">--</option>
				<% end if %>
				<% count = 1
					sqlg = "select * from PageGroups order by PageGroupOrder"
					acounter = 1
					Set rsg = Server.CreateObject("ADODB.Recordset")
					rsg.Open sqlg, conn, 3, 3 
					
					while not rsg.eof	%>
						<option name = "AID1" value="<%=rsg("PagegroupID") %>">
							<%=rsg("PageGroupTitle") %>
						</option>
					<% 	rsg.movenext
					wend %>
					</select>
				</div>
			</div>
		<% end if %>
		<div class="row">
			<div class="col body">
				<b>Page Heading:</b>
			</div>
		</div>
		<div class="row">
			<div class="row">
				<div class="col">
					<input name="PageTitle" value= '<%=PageTitle%>' size = "60" class = 'formbox'>
				</div>
		</div>

		<div class="row">
			<div class="col body">
					<b>Display:</b>&nbsp;
			</div>
		</div>
		<div class="row">
			<div class="row">
				<div class="col" >
					<% if ShowPage = "Yes" Or  ShowPage = True Or  ShowPage = 1 Then %>
								Yes<input TYPE="RADIO" name="ShowPage" Value = 1 checked>
								No<input TYPE="RADIO" name="ShowPage" Value = 0 >
							<% Else %>
								Yes<input TYPE="RADIO" name="ShowPage" Value = 1 >
								No<input TYPE="RADIO" name="ShowPage" Value = 0 checked>
						<% End if%>
				</div>
			</div>
		<div class ="col" align = "center" valign = "middle" class = "body2" >
					<input type=submit value = "Update" class = "regsubmit2" >
		<br>
			</div>
		</div>
		</form>

      </div>
 </div>

    <div class="col-md-6 col-sm-12 order-sm-2 roundedtopandbottomgrey" style="min-height: 600px" >
	  <div class="row">
		<div class="col body">
			<H1><div align = "left">Top Photo</div></H1>
		</div>
	  </div>
	  <div class="row">

			<% if len(TopImage) > 0 then %>
			<img style="object-fit: contain; height: 100px;" src = "<%=TopImage%>" />
			<% end if %>


		  <form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminPageDataUploadPageImage.asp?PagelayoutID=<%=PagelayoutID %>&ImageNum=Top" >
			Upload: <input name="attach1" type="file" size=45 ><input  type=submit value="Upload" class="regsubmit2">
		</form>
		  <% if len(TopImage) > 1 then %>
			<form action= 'RemoveTopImage.asp' method = "post">
				<input type = "hidden" name="PagelayoutID" value= "<%= PagelayoutID %>" >
				<br />&nbsp;&nbsp;&nbsp;&nbsp;<input type=submit value="Remove" class="regsubmit2">
			</form>
		<% End If %>


		  </div>
	  </div>
</div>
<%
for x = 1 to TotalTextBlocks
  textblocknum = x
  TempPageText =  PageText(x)
  TempTB = "TB" & x
  TempImageOrientation = ImageOrientation(x)
  tempImageCaption  = ImageCaption(x)
  tempImage = Image(x)
  tempPageLayout2ID = PageLayout2ID(x)
  TempTextBlock = "Textblock" & x
  ReturnPage="AdminPageData.asp?PageLayoutID=" & PageLayoutID & "#Textblock" & x
   %><a name= <%=TempTextBlock %> ></a><iframe src="AdminPageBlocksInclude.asp?PageLayoutID=<%=PageLayoutID %>&textblocknum=<%=textblocknum %>" frameborder="0" scrolling="no" style="width: 100%; height: 60vh;"></iframe>
<% next %>
<div align = "center"><a href = "#Top" class ="body">Click here to go to the top of the page.</a></div>
 
 <br><br />
   <!--#Include virtual ="/Members/MembersFooter.asp"--> 
 </Body>
</HTML>
