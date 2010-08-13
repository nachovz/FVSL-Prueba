using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

/// <summary>
/// Summary description for dynamicLINQ
/// </summary>
public class dynamicLINQ
{
    public int id_ods { get; set; }
    public String nombre { get; set; }
    public String Latitud { get; set; }
    public String Longitud { get; set; }

	public dynamicLINQ()
	{
		//
		// TODO: Add constructor logic here
		//
	}
}
