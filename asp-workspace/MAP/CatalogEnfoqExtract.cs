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
/// Summary description for CatalogEnfoqExtract
/// </summary>
public class CatalogEnfoqExtract: ICatalogExtractor
{
	public CatalogEnfoqExtract()
	{
    
		//
		// TODO: Add constructor logic here
		//
	}

    #region ICatalogExtractor Members

    public List<CataloValueVO> getCatalog(int padre)
    {
        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

        List<CataloValueVO> lista = new List<CataloValueVO>();

        try
        {

            List<MAPA_GET_CATALOGO_ENFOQUE_GEOGRAFICOResult> resultset = dbcon.MAPA_GET_CATALOGO_ENFOQUE_GEOGRAFICO().ToList();

            foreach (MAPA_GET_CATALOGO_ENFOQUE_GEOGRAFICOResult enfoq in resultset)
            {
                CataloValueVO catalo = new CataloValueVO();

                catalo.id = enfoq.id;
                catalo.value = enfoq.nombre;

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
