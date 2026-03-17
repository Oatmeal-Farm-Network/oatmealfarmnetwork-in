<% Transfer = True %>
<!--#Include virtual="/Administration/Transfers/GatherProductData.asp"--> 
<% Conn.close
set Conn = Nothing
stopthere = False
if stopthere = False then %>
<!--#Include virtual="/ConnLOA.asp"-->
<% Found = False
if len( SourceLOAProductID) > 0 then
 sql = "select * from sfProducts where  PeopleID= " &  session("AIID") & " and (prodID = " &   SourceLOAProductID  & ") ;" 
'response.write(sql)
'Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, ConnLOA, 3, 3   
If Not rs.eof Then
prodlID = rs("prodID")
Found = True
End if
 rs.close
end if
'response.write("found=" & found)
If Found = True Then %>
<!--#Include virtual="/Administration/Transfers/TransferFoundproduct.asp"--> 
<% Else %>
<!--#Include virtual="/Administration/Transfers/TransferNewproduct.asp"--> 
<% End if%>
<% End if%>


