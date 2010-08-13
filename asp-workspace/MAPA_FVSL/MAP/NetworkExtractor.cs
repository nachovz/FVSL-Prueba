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
/// Summary description for NetworkExtractor
/// </summary>
public class NetworkExtractor
{

	public static INetworkExtractor create(String type) 
	{
        if (type == NetworkVO.ODS_EXTRACTOR)
        {
            return new NetworkODSextract();
        }
        else if (type == NetworkVO.COOP_EXTRACTOR)
        {
            return new NetworkCOOPextract();
        }
        else if (type == NetworkVO.EMP_EXTRACTOR)
        {
            return new NetworkCompanyExtract();
        }
        else if (type == NetworkVO.ALL_EXTRACTOR)
        {
            return new NetworkALLextract();
        }
        return null;
	}
}
