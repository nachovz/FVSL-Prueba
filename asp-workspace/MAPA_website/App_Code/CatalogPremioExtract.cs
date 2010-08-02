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
/// Summary description for CatalogPremioExtract
/// </summary>
public class CatalogPremioExtract : ICatalogExtractor
{
    public CatalogPremioExtract()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    #region ICatalogExtractor Members

    public List<CataloValueVO> getCatalog(String type, int padre)
    {
        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

        List<CataloValueVO> lista = new List<CataloValueVO>();

        List<mapa_get_catalogo_premiosResult> resultset = dbcon.mapa_get_catalogo_premios(type).ToList();

        foreach (mapa_get_catalogo_premiosResult premio in resultset)
        {
            CataloValueVO catalo = new CataloValueVO();

            catalo.id = premio.id;
            catalo.value = premio.nombre;

            lista.Add(catalo);
        }

        return lista;
    }

    #endregion
}
