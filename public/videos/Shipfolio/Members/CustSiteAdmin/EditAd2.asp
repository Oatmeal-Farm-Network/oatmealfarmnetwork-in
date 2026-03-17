<html>
<head>


<!--#Include file="Globalvariables.asp"--> 



<meta http-equiv="Content-Language" content="en-us">
<title>Edit a Product</title>
<meta name="author" content="WebArtists.biz">
<link rel="stylesheet" type="text/css" href="style.css">


<SCRIPT LANGUAGE="JavaScript">

<!-- Begin
   var submitcount=0;
   function checkSubmit() {

      if (submitcount == 0)
      {
      submitcount++;
      document.Surv.submit();
      }
   }


function wordCounter(field, countfield, maxlimit) {
wordcounter=0;
for (x=0;x<field.value.length;x++) {
      if (field.value.charAt(x) == " " && field.value.charAt(x-1) != " ")  {wordcounter++}  // Counts the spaces while ignoring double spaces, usually one in between each word.
      if (wordcounter > 250) {field.value = field.value.substring(0, x);}
      else {countfield.value = maxlimit - wordcounter;}
      }
   }

function textCounter(field, countfield, maxlimit) {
  if (field.value.length > maxlimit)
      {field.value = field.value.substring(0, maxlimit);}
      else
      {countfield.value = maxlimit - field.value.length;}
  }
//  End -->
</script>

</head>

<body>
<!--#Include virtual="/Administration/Header.asp"--> 
<!--#Include file="storeHeader.asp"--> 

<!--#Include file="EditAd2include.asp"-->

<!--#Include file="Footer.asp"--> </Body>
</HTML>