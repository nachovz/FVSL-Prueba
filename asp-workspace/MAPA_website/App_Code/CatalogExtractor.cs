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

	public static ICatalogExtractor create(String type)
	{
        if (type == CataloValueVO.CATALOG_PREMIO)
        {
            return new CatalogPremioExtract();
        }
        else if (type == CataloValueVO.CATALOG_PAIS)
        {
            return new CatalogPaisExtract();
        }
        else if (type == CataloValueVO.CATALOG_BENEF)
        {
            return new CatalogBenefExtract();
        }
        else if (type == CataloValueVO.CATALOG_TIPO_ORG)
        {
            return new CatalogTipoOrgExtract();
        }
        else if (type == CataloValueVO.CATALOG_ENFOQ)
        {
            return new CatalogEnfoqExtract();
        }
        else if (type == CataloValueVO.CATALOG_ESTADO)
        {
            return new CatalogEstadoExtract();
        }
        else if (type == CataloValueVO.CATALOG_AREA)
        {
            return new CatalogAreaExtract();
        }
        return null;
	}
}
