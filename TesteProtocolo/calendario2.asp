<form id="myForm" method="POST" action="">

<table cellspacing="0" cellpadding="5" style="border-collapse: collapse" bordercolor="#111111">
<tr>
	<td>
<script type="text/javascript" language="JavaScript1.2" src="acecalendar.js"></script>
<script type="text/javascript" language="JavaScript1.2">

var oCal_1 = new AceCalendar();
var myDate= new Date();
var ano=myDate.getFullYear();
var mes=myDate.getMonth();
var dia=myDate.getDay();

oCal_1.setName("oCal_1");
oCal_1.setFormName("myForm");
oCal_1.setFieldNames("start_yr", "start_mo", "start_dt" );
oCal_1.setStyle(0, "#FFFFFF", "#FFFFFF", "#000000", 0, 1);
oCal_1.setStyle(1, "#DDDDDD", "#DDDDDD", "#888888", 1, 0);
oCal_1.setStyle(2, "#FF8080", "#FF8080", "#FFFFFF", 0, 1);
oCal_1.setStyle(3, "#FFC0C0", "#FFC0C0", "#FFFFFF", 1, 0);
oCal_1.setStyle(4, "#8899FF", "#8899FF", "#FFFFFF", 0, 1);
oCal_1.setFont("Helvetica, sans-serif", "10pt");
oCal_1.display(ano, mes, dia);

oCal_1.setAction	 = function()
{
	var aMonths = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
	var oForm = document.forms.myForm;
	if (oForm != null)
	{
		oForm.elements.s_yr.value = this.getYear();
		oForm.elements.s_mo.value = aMonths[this.getMonth()];
		oForm.elements.s_dt.value = this.getDate();
	}

}
</script>
</td>
</tr>
</table>
</form>
