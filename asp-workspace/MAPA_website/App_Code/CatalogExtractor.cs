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
/// Summary description for CatalogExtractor
/// </summary>
public class CatalogExtractor
{
    public static String CATALOG_PREMIO { get { return "premios"; } }
    public static String CATALOG_PAIS { get { return "paises"; } }
    public static String CATALOG_BENEF { get { return "beneficiarios"; } }
    public static String CATALOG_TIPO_ORG { get { return "tipos"; } }
    public static String CATALOG_ENFOQ { get { return "enfoques"; } }
    public static String CATALOG_ESTADO { get { return "estados"; } }



	public static ICatalogExtractor create(String type)
	{
        if (type == CATALOG_PREMIO)
        {
            return new CatalogPremioExtract();
        }
        else if (type == CATALOG_PAIS)
        {
            return null;//new CatalogPaisExtract();
        }
        else if (type == CATALOG_BENEF)
        {
            return null;//new CatalogBenefExtract();
        }
        else if (type == CATALOG_TIPO_ORG)
        {
            return null;//new CatalogTipoOrgExtract();
        }
        else if (type == CATALOG_ENFOQ)
        {
            return null;//new CatalogEnfoqExtract();
        }
        else if (type == CATALOG_ESTADO)
        {
            return null;//new CatalogEstadoExtract();
        }
        return null;
	}
}
