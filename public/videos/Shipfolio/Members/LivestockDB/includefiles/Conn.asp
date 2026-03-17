<% 
Set conn = Server.CreateObject("ADODB.Connection") 

Set rs = Server.CreateObject("ADODB.Recordset")
BorderColor = "#ebebeb"
sitename = "LivestockOfTheWorld"
Sitenamelong = "Livestock of the world"
siteDomainName = "LivestockOftheWorld.com"
SiteURL = "http://www.LivestockofAmerica.US"
PrimaryColor = "#065906"
WebSiteName = "Livestock of the World" 


Set Conn  = Server.CreateObject("ADODB.Connection")

Conn.ConnectionString = "Provider=SQLOLEDB;" _
       & " Data Source=tcp:oatmealaiserverlive.database.windows.net,1433;" _
       & " Initial Catalog=OatmealAILive;" _
       & " User ID=OatmealBowl;" _
       & " Password=Mapo31415926!;" _
       & " Encrypt=yes;" _
       & " TrustServerCertificate=no;"

     
Conn.Open  
If Err.Number <> 0 Then
    Response.Write "Connection Error: " & Err.Description
    Response.End
End If

Set rs = Server.CreateObject("ADODB.Recordset")



%>