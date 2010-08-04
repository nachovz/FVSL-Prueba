<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
<link rel="stylesheet" type="text/css" href="css/styles.css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/map.js"></script>
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=ABQIAAAAzr2EBOXUKnm_jVnk0OJI7xSosDVG8KKPE1-m51RBrvYughuyMxQ-i1QfUnH94QxWIa6N4U6MouMmBA" type="text/javascript"></script>
</head>
<body>
<script type="text/javascript">
    var latitud = "latitud";
    var longitud = "longitud";
    var button = "cargar";
    $(document).ready(function() {
        habilitarPopup();
        return false;
    });

</script>

	<div id="content" style="display:none;"></div>
    <form id="form1" runat="server">
    <div>
        <asp:TextBox ID="latitud" runat="server"></asp:TextBox>
        <asp:TextBox ID="longitud" runat="server"></asp:TextBox>
        <a href="#" id="cargar">cargar</a>
    </div>
    </form>
</body>
</html>
