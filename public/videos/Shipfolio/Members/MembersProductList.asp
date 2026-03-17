<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

<!--#Include file="MembersGlobalVariables.asp"-->

 </head>
<body >

<% Current1="Products"
Current2 = "EditProduct"
Current3 = "Summary" %> 
<!--#Include file="MembersHeader.asp"-->
<!--#Include file="MembersProductJumpLinks2.asp"-->

<%'Products **************************************** %>
<div class="container roundedtopandbottom">
    <h2>My Products</h2>
     <%  sql = "select * from sfProducts where PeopleID = " & session("PeopleID") & " order by Prodname"
      Set rs = Server.CreateObject("ADODB.Recordset")
        rs.Open sql, conn, 3, 3  
        if rs.eof then %>
            You do not have any Products listed.<br /><br /><a href = "MembersClassifiedAdPlace0.asp#top" class = "body">Add a Product</a>.<br /><br />
        <% else    
            rowcount = 1
        %>
  <table width =" 100%" >
      <tr>
        <td class ="text-left body">Product</td>
        <td class="text-left body" width="125px" style="max-width:125px; min-width:125px"><div align = left>For Sale?</div></td>
        <td class="text-left body" >Price</td>
        <td class="text-left body d-none d-md-table-cell" width="20px" style="max-width:20px; min-width:20px"><div align = left>QTY</div></td>
        <td class="body text-right" style="max-width:90px"><div align = right>Options&nbsp;&nbsp;&nbsp;&nbsp;</div></td>
      </tr>
     <tr >
	    <td colspan="5" style="background-color: #abacab; min-height: 1px"></td>
      </tr>
      <%	
   dim ProdIDArray(99999) 
   dim prodNameArray(99999)  
   dim prodPriceArray(99999) 
   dim ProdForSaleArray(99999) 
   dim ProdQuantityAvailableArray(99999)
   dim catIDArray(99999)
   dim catNameArray(99999)
   dim PublishproductArray(99999)

	While Not rs.eof  
	prodNameArray(rowcount) =   rs("prodName")
    ProdIDArray(rowcount) =   rs("prodID")
    prodPriceArray(rowcount) =   rs("prodPrice")
    ProdForSaleArray(rowcount) =   rs("ProdForSale")
    ProdQuantityAvailableArray(rowcount)  =   rs("ProdQuantityAvailable")
    catIDArray(rowcount) =   rs("prodCategoryId")
   PublishproductArray(rowcount) =   rs("Publishproduct")
%>
      <tr>
        <td >
             <a href = "MembersProductEditBasic.asp?prodID=<%= ProdIDArray(rowcount)%>#BasicFacts" class = "body"><small><%= prodNameArray( rowcount)%></small></a>
        </td>
        <td class="body" >
           <% if PublishproductArray(rowcount) = 1 then%>
                <a href = "MembersProductEditBasic.asp?prodID=<%= ProdForSaleArray(rowcount)%>#BasicFacts" class = "body"><div align = left>&#10004;</div></a>
            <% end if %>
            
        </td>
        <td class="body" >
          <a href = "MembersProductEditBasic.asp?prodID=<%= ProdIDArray(rowcount)%>#BasicFacts" class = "body"><div align = left><%= prodPriceArray(rowcount)%></div></a>
            
        </td>
        <td class="body d-none d-md-table-cell" ><div align = left>
          <a href = "MembersProductEditBasic.asp?prodID=<%= ProdQuantityAvailableArray(rowcount)%>#BasicFacts" class = "body"><%= ProdQuantityAvailableArray(rowcount)%></a>
            </div>
        </td>
        <td class="text-right" style="min-width:110px" ><div align = right>
            
           <a href = "MembersProductEditBasic.asp?prodID=<%= ProdIDArray(rowcount)%>#BasicFacts" class = "body">    &nbsp;&nbsp;<img src= "images/edit.svg" alt = "edit" height ="26" border = "0"></a>|
    &nbsp;<a href = "MembersProductsUploadPhotos.asp?prodID=<%=ProdIDArray(rowcount)%>" class = "body"><img src= "images/Photos.svg" alt = "edit" height ="26" border = "0"></a>|
    &nbsp;<a href = "membersDeleteListinghandleform1.asp?ID=<%=ProdIDArray(rowcount)%>" class = "body"><img src= "images/delete.svg" alt = "edit" height ="26" border = "0"></a>

        </div>
        </td>
      </tr>
           <tr >
	    <td colspan="5" style="background-color: #dddddd; min-height: 1px"></td>
      </tr>
<%	rs.movenext
Wend		

end if
rs.close %>
</table>
</div>

<div class="row">
    <div class ="col">
        <br />
    </div>
</div>


<!--#Include file="membersFooter.asp"--> 
    </body>
</html>