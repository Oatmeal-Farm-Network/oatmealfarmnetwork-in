<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

<!--#Include file="MembersGlobalVariables.asp"-->

 </head>
<body >

<% Current1="Products"
Current3 = "Photos" %> 
<!--#Include file="MembersHeader.asp"-->
<!--#Include file="MembersProductJumpLinks2.asp"-->
	<div class =" container roundedtopandbottom">
<H1>Product Photos</H1>

	

<% 
	dim prodNameArray(999999)
sql2 = "select ProdID, ProdName from sfProducts  where PeopleID = " & session("PeopleID") & " order by Prodname"
	acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
Set rs = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		IDArray(acounter) = rs2("ProdID")
		prodNameArray(acounter) = rs2("ProdName")
		'response.write (SSName(studcounter))
		acounter = acounter +1
		rs2.movenext
Wend		
	
rs2.close
set rs2=nothing%>
<!--#Include virtual="/members/Conn.asp"-->
<%
redirect = false
			
sql = "select * from ProductsPhotos where id = " & prodID
'response.write("sql=" & sql )
rs.Open sql, conn, 3, 3

If rs.eof Then
	redirect =true
	Query =  "INSERT INTO ProductsPhotos (ID)" 
	Query =  Query & " Values (" &  prodID & ")"

conn.Execute(Query) 
conn.close
set conn=nothing 
%>
<!--#Include virtual="/members/Conn.asp"-->
<%
			
End If 
if rs.state = 0 then
else
rs.close
end if 

sql = "select * from sfProducts where prodid = " & prodID & ""
rs.Open sql, conn, 3, 3
If rs.eof Then
	redirect =true
	Query =  "INSERT INTO sfProducts (prodID)" 
	Query =  Query & " Values (" &  prodID & ")"

Conn.Execute(Query) 
Conn.close
set conn=nothing 
%>
<!--#Include virtual="/members/Conn.asp"-->
<%
			
End If 
rs.close

If  redirect =True then
	response.redirect("membersProductPhotos.asp?prodid="&prodID)
End if
sql = "select * from sfProducts, ProductsPhotos where sfProducts.prodid = ProductsPhotos.ID and ProductsPhotos.ID = " & prodID
rs.Open sql, conn, 3, 3
If Not rs.eof Then
ProdName2 = rs("prodName")
End If

If Len(rs("ProductImage1")) > 2 Then
File1= rs("ProductImage1")
'response.write(sql)
else
File1 = "https://www.globallivestocksolutions.com/images/ImageNotAvailable.jpg"
End If

If Len(rs("ProductImage2")) > 2 Then
File2= rs("ProductImage2")
else
File2 = "https://www.globallivestocksolutions.com/images/ImageNotAvailable.jpg"
End If

If Len(rs("ProductImage3")) > 2 Then
File3= rs("ProductImage3")

else
File3 = "https://www.globallivestocksolutions.com/images/ImageNotAvailable.jpg"
End If

If Len(rs("ProductImage4")) > 2 Then
File4= rs("ProductImage4")

else
File4 = "https://www.globallivestocksolutions.com/images/ImageNotAvailable.jpg"
End If

If Len(rs("ProductImage5")) > 2 Then
File5= rs("ProductImage5")

else
File5 = "https://www.globallivestocksolutions.com/images/ImageNotAvailable.jpg"
End If


If Len(rs("ProductImage6")) > 2 Then
File6= rs("ProductImage6")

else
File6 = "https://www.globallivestocksolutions.com/images/ImageNotAvailable.jpg"
End If

	If Len(rs("ProductImage7")) > 2 Then
File7= rs("ProductImage7")

else
File7 = "https://www.globallivestocksolutions.com/images/ImageNotAvailable.jpg"
End If

If Len(rs("ProductImage8")) > 2 Then
File8= rs("ProductImage8")
	
else
File8 = "https://www.globallivestocksolutions.com/images/ImageNotAvailable.jpg"
End If

	   

'response.write(File5)
			str1 = File1
			str2 = "''"
			If InStr(str1,str2) > 0 Then
File1= Replace(str1,  str2, "'")
			End If  	 

			str1 = File2
			str2 = "''"
			If InStr(str1,str2) > 0 Then
File2= Replace(str1,  str2, "'")
			End If  	
			
			
			str1 = File3
			str2 = "''"
			If InStr(str1,str2) > 0 Then
File3= Replace(str1,  str2, "'")
			End If  	 
			
			str1 = File4
			str2 = "''"
			If InStr(str1,str2) > 0 Then
File4= Replace(str1,  str2, "'")
			End If  	 
			
			str1 = File5
			str2 = "''"
			If InStr(str1,str2) > 0 Then
File5= Replace(str1,  str2, "'")
			End If  	 
			
			str1 = File6
			str2 = "''"
			If InStr(str1,str2) > 0 Then
File6= Replace(str1,  str2, "'")
			End If  	
			
			str1 = File7
			str2 = "''"
			If InStr(str1,str2) > 0 Then
File7= Replace(str1,  str2, "'")
			End If  
			
			str1 = File8
			str2 = "''"
			If InStr(str1,str2) > 0 Then
File8= Replace(str1,  str2, "'")
			End If  
rs.close
%>
<div class="container">
<div>
  <div>
     <%  sql2 = "select ProdID, ProdName from sfProducts where PeopleID = " & session("peopleID") & "  order by Prodname"
	    acounter = 1
	    Set rs2 = Server.CreateObject("ADODB.Recordset")
	    rs2.Open sql2, conn, 3, 3 
	
	    While Not rs2.eof  
		    IDArray(acounter) = rs2("prodID")
		    prodNameArray(acounter) = rs2("prodName")
    		acounter = acounter +1
	    	rs2.movenext
	    Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing
%>
    </div>
</div>
		

<div class = "row">
  <div class = "col-12">
     <a name="1"></a>
		<H2>Main Image</H2>
  </div>
</div>
	<div>
	<div class = "col-12"  style="background-color: #abacab; min-height: 1px"></div>
</div>
<div class = "row">
  <div class = "col-3" align = right>
      <img src = "<%=File1%>" height = "100">
      <b><%=PhotoCaption1%></b>
  </div>
  <div class = "col-9">
    <form name="frmSend" method="POST" enctype="multipart/form-data" action="membersProductUploadPhoto.asp?ProdID=<%=ProdID %>&ImageNum=1" >
    <b>Upload Photo</b><br />
    <input name="attach1" type="file" size=55 class = "roundedtopandbottom">
    <input  type=submit value="Upload" class = "roundedtopandbottomyellow">
    </form>
    <% if len(File1) > 4 and not File1="https://www.globallivestocksolutions.com/images/ImageNotAvailable.jpg" then%>
    <br>
    <form action= 'membersProductsRemoveImage.asp' method = "post">
		<input type = "hidden" name="ImageID" value= "1" />
		<input type = "hidden" name="ProdID" value= "<%= ProdID %>" />
		<input type=submit value="Remove This Image" class = "regsubmit2">
    </form>
    <% end if %>
  </div>
</div>



<div class = "row">
  <div class = "col-12">
     <a name="2"></a>
		<H2>Image 2</H2>
  </div>
</div>
<div>
	<div class = "col-12"  style="background-color: #abacab; min-height: 1px"></div>
</div>
<div class = "row">
  <div class = "col-3" align = right>
      <img src = "<%=File2%>" height = "100">
      <b><%=PhotoCaption2%></b>
  </div>
  <div class = "col-9">
    <form name="frmSend" method="POST" enctype="multipart/form-data" action="membersProductUploadPhoto.asp?ProdID=<%=ProdID %>&ImageNum=2" >
    <b>Upload Photo</b><br />
    <input name="attach2" type="file" size=55 class = "roundedtopandbottom">
    <input  type=submit value="Upload" class = "regsubmit2">
    </form>
    <% if len(File2) > 4 and not File2="https://www.globallivestocksolutions.com/images/ImageNotAvailable.jpg" then%>
    <center><br>
    <form action= 'membersProductsRemoveImage.asp' method = "post">
	<input type = "hidden" name="ImageID" value= "2" >
	<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
	<input type=submit value="Remove This Image" class = "regsubmit2"></center>
    </form>
    <% end if %>
  </div>
</div>

<div class = "row">
  <div class = "col-12">
     <a name="3"></a>
		<H2>Image 3</H2>
  </div>
</div>
	<div>
	<div class = "col-12"  style="background-color: #abacab; min-height: 1px"></div>
</div>
<div class = "row">
  <div class = "col-3" align = right>
      <img src = "<%=File3%>" height = "100">
      <b><%=PhotoCaption3%></b>
  </div>
  <div class = "col-9">
    <form name="frmSend" method="POST" enctype="multipart/form-data" action="membersProductUploadPhoto.asp?ProdID=<%=ProdID %>&ImageNum=3" >
    <b>Upload Photo</b><br />
    <input name="attach3" type="file" size=55 class = "roundedtopandbottom">
    <input  type=submit value="Upload" class = "regsubmit2">
    </form>
    <% if len(File3) > 4 and not File3="https://www.globallivestocksolutions.com/images/ImageNotAvailable.jpg" then%>
    <center><br>
    <form action= 'membersProductsRemoveImage.asp' method = "post">
	<input type = "hidden" name="ImageID" value= "3" >
	<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
	<input type=submit value="Remove This Image" class = "regsubmit2"></center>
    </form>
    <% end if %>
  </div>
</div>

<div class = "row">
  <div class = "col-12">
     <a name="4"></a>
		<H2>Image 4</H2>
  </div>
</div>
	<div>
	<div class = "col-12"  style="background-color: #abacab; min-height: 1px"></div>
</div>
<div class = "row">
  <div class = "col-3" align = right>
      <img src = "<%=File4%>" height = "100">
      <b><%=PhotoCaption4%></b>
  </div>
  <div class = "col-9">
    <form name="frmSend" method="POST" enctype="multipart/form-data" action="membersProductUploadPhoto.asp?ProdID=<%=ProdID %>&ImageNum=4" >
    <b>Upload Photo</b><br />
    <input name="attach4" type="file" size=55 class = "roundedtopandbottom">
    <input  type=submit value="Upload" class = "regsubmit2">
    </form>
    <% if len(File4) > 4 and not File4="https://www.globallivestocksolutions.com/images/ImageNotAvailable.jpg" then%>
    <center><br>
    <form action= 'membersProductsRemoveImage.asp' method = "post">
	<input type = "hidden" name="ImageID" value= "4" >
	<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
	<input type=submit value="Remove This Image" class = "regsubmit2"></center>
    </form>
    <% end if %>
  </div>
</div>

<div class = "row">
  <div class = "col-12">
     <a name="5"></a>
		<H2>Image 5</H2>
  </div>
</div>
	<div>
	<div class = "col-12"  style="background-color: #abacab; min-height: 1px"></div>
</div>
<div class = "row">
  <div class = "col-3" align = right>
      <img src = "<%=File5%>" height = "100">
      <b><%=PhotoCaption5%></b>
  </div>
  <div class = "col-9">
    <form name="frmSend" method="POST" enctype="multipart/form-data" action="membersProductUploadPhoto.asp?ProdID=<%=ProdID %>&ImageNum=5" >
    <b>Upload Photo</b><br />
    <input name="attach5" type="file" size=55 class = "roundedtopandbottom">
    <input  type=submit value="Upload" class = "regsubmit2">
    </form>
    <% if len(File5) > 4 and not File5="https://www.globallivestocksolutions.com/images/ImageNotAvailable.jpg" then%>
    <center><br>
    <form action= 'membersProductsRemoveImage.asp' method = "post">
	<input type = "hidden" name="ImageID" value= "5" >
	<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
	<input type=submit value="Remove This Image" class = "regsubmit2"></center>
    </form>
    <% end if %>
  </div>
</div>
<div class = "row">
  <div class = "col-12">
     <a name="6"></a>
		<H2>Image 6</H2>
  </div>
</div>
	<div>
	<div class = "col-12"  style="background-color: #abacab; min-height: 1px"></div>
</div>
<div class = "row">
  <div class = "col-3" align = right>
      <img src = "<%=File6%>" height = "100">
      <b><%=PhotoCaption6%></b>
  </div>
  <div class = "col-9">
    <form name="frmSend" method="POST" enctype="multipart/form-data" action="membersProductUploadPhoto.asp?ProdID=<%=ProdID %>&ImageNum=6" >
    <b>Upload Photo</b><br />
    <input name="attach6" type="file" size=55 class = "roundedtopandbottom">
    <input  type=submit value="Upload" class = "regsubmit2">
    </form>
    <% if len(File6) > 4 and not File6="https://www.globallivestocksolutions.com/images/ImageNotAvailable.jpg" then%>
    <center><br>
    <form action= 'membersProductsRemoveImage.asp' method = "post">
	<input type = "hidden" name="ImageID" value= "6" >
	<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
	<input type=submit value="Remove This Image" class = "regsubmit2"></center>
    </form>
    <% end if %>
  </div>
</div>
<div class = "row">
  <div class = "col-12">
     <a name="7"></a>
		<H2>Image 7</H2>
  </div>
</div>
	<div>
	<div class = "col-12"  style="background-color: #abacab; min-height: 1px"></div>
</div>
<div class = "row">
  <div class = "col-3" align = right>
      <img src = "<%=File7%>" height = "100">
      <b><%=PhotoCaption7%></b>
  </div>
  <div class = "col-9">
    <form name="frmSend" method="POST" enctype="multipart/form-data" action="membersProductUploadPhoto.asp?ProdID=<%=ProdID %>&ImageNum=7" >
    <b>Upload Photo</b><br />
    <input name="attach7" type="file" size=55 class = "roundedtopandbottom">
    <input  type=submit value="Upload" class = "regsubmit2">
    </form>
    <% if len(File7) > 4 and not File7="https://www.globallivestocksolutions.com/images/ImageNotAvailable.jpg" then%>
    <center><br>
    <form action= 'membersProductsRemoveImage.asp' method = "post">
	<input type = "hidden" name="ImageID" value= "7" >
	<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
	<input type=submit value="Remove This Image" class = "regsubmit2"></center>
    </form>
    <% end if %>
  </div>
</div>

<div class = "row">
  <div class = "col-12">
     <a name="8"></a>
		<H2>Image 8</H2>
  </div>
</div>
	<div>
	<div class = "col-12"  style="background-color: #abacab; min-height: 1px"></div>
</div>
<div class = "row">
  <div class = "col-3" align = right>
      <img src = "<%=File8%>" height = "100">
      <b><%=PhotoCaption8%></b>
  </div>
  <div class = "col-9">
    <form name="frmSend" method="POST" enctype="multipart/form-data" action="membersProductUploadPhoto.asp?ProdID=<%=ProdID %>&ImageNum=8" >
    <b>Upload Photo</b><br />
    <input name="attach8" type="file" size=55 class = "roundedtopandbottom">
    <input  type=submit value="Upload" class = "regsubmit2">
    </form>
    <% if len(File8) > 4 and not File8="https://www.globallivestocksolutions.com/images/ImageNotAvailable.jpg" then%>
    <center><br>
    <form action= 'membersProductsRemoveImage.asp' method = "post">
	<input type = "hidden" name="ImageID" value= "8" >
	<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
	<input type=submit value="Remove This Image" class = "regsubmit2"></center>
    </form>
    <% end if %>
  </div>
</div>
</div>
</div>
<!--#Include file="membersFooter.asp"-->
 </Body>
</HTML>
