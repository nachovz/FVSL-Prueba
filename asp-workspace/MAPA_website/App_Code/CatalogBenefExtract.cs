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
using System.Collections.Generic;

/// <summary>
/// Summary description for CatalogBenefExtract
/// </summary>
public class CatalogBenefExtract : ICatalogExtractor
{
	public CatalogBenefExtract()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    #region ICatalogExtractor Members

    public System.Collections.Generic.List<CataloValueVO> getCatalog(int padre)
    {
        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

        List<CataloValueVO> lista = new List<CataloValueVO>();

        try
        {

            List<mapa_get_catalogo_beneficiarioResult> resultset = dbcon.mapa_get_catalogo_beneficiario().ToList();

            foreach (mapa_get_catalogo_beneficiarioResult benef in resultset)
            {
                CataloValueVO catalo = new CataloValueVO();

                catalo.id = benef.Id;
                catalo.value = benef.Nombre;

                lista.Add(catalo);
            }

            return lista;
        }
        catch (Exception e)
        {
            Logging.WriteError(e.StackTrace.ToString());
            return null;
        }
    }

    #endregion
}
