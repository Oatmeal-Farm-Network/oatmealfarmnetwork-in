<!DOCTYPE html>
<html>
<head>
    <!--#Include virtual="/includefiles/globalvariables.asp"-->
</head>
<BODY>
    <%
   FavoriteAssocitaionID= Request.Form("FavoriteAssocitaionID")
   BusinessID = request.form("BusinessID")
   
If len(FavoriteAssocitaionID) > 0 and len(BusinessID) > 0 then


    Query =  "UPDATE Business Set FavoriteAssocitaionID = " &  FavoriteAssocitaionID & ""
    Query =  Query & " where BusinessID = " & BusinessID & ";"


    response.write("Query="	& Query )
    Conn.Execute(Query)
    Conn.close


    response.redirect("MembersAssociations.asp?BusinessID=" & BusinessID & "&changesmade=True")
else


response.redirect("MembersAssociations.asp?BusinessID=" & BusinessID & "&changesmade=False")
end if
    %>
    <br><br><br>
</BODY>
</html>