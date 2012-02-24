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
using System.Data.Linq;
using MAP;

/// <summary>
/// Summary description for ODSextract
/// </summary>
public class ODSextract: IEntityExtractor
{
	public ODSextract()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    //public List<ODSVO> getODSD(int inods)                                       //getODSD receive (id_ods) Return List of ODSVO
    public EntityVO getDetails(int inods)
    {
        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();                //Create LINQ-SQL connection
        
        ODSVO result = new ODSVO();

        try
        {

            List<MAPA_ODS_DETAILSResult> resultset = dbcon.MAPA_ODS_DETAILS(inods).ToList();

            if (resultset.Count == 1)
            {
                result = FODS(resultset[0]);
            }

            return (EntityVO)result;
        }
        catch (Exception e)
        {
            Logging.WriteError(e.StackTrace.ToString());
            return null;
        }
    }

    public List<EntityVO> getSearch(List<String> datos)                           //getSearch in:List<String> (int idpais, int idestado, string nombre, string area, string premios)
    {
        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

        List<EntityVO> lista = new List<EntityVO>();

        try
        {

            ISingleResult<dynamicLINQ> resultset = dbcon.MAPA_SEARCH_ODS_BY(int.Parse(datos[0]), int.Parse(datos[1]), datos[2], datos[3], datos[4]);

            foreach (dynamicLINQ dyn in resultset)
            {
                EntityVO EVO = new EntityVO();

                EVO.id = dyn.id_ods.ToString();
                EVO.name = dyn.nombre;
                EVO.latitude = dyn.Latitud;
                EVO.longitude = dyn.Longitud;

                lista.Add(EVO);
            }

            return lista;
        }
        catch (Exception e)
        {
            Logging.WriteError(e.StackTrace.ToString());
            return null;
        }
    }

    public List<EntityVO> getAll()
    {
        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

        List<EntityVO> lista = new List<EntityVO>();

        try
        {

            List<MAPA_ODS_ALLResult> resultset = dbcon.MAPA_ODS_ALL().ToList();

            foreach (MAPA_ODS_ALLResult odsa in resultset)
            {
                EntityVO EVO = new EntityVO();

                EVO.id = odsa.id_ods.ToString();
                EVO.name = odsa.nombre;
                EVO.latitude = odsa.Latitud;
                EVO.longitude = odsa.Longitud;

                lista.Add(EVO);
            }

            return lista;

        }
        catch (Exception e)
        {
            Logging.WriteError(e.StackTrace.ToString());
            return null;
        }
    }

    private ODSVO FODS(MAPA_ODS_DETAILSResult odsin)                                           //FODS receive (ODS_ODS) Return ODSVO object (full)
    {
        ODSVO aux = new ODSVO();

        aux.id = odsin.id_ods.ToString();
        aux.name = odsin.nombre;
        aux.latitude = odsin.Latitud;
        aux.longitude = odsin.Longitud;
        aux.direction = odsin.ciudad + ", " + odsin.urbanizacion + " " + odsin.calle;
        aux.website = odsin.pagina_web;
        aux.facebook = odsin.FacebookODS;
        aux.twitter = odsin.TwitterODS;
        aux.objective = odsin.objetivos;
        aux.email = odsin.email;
        aux.type = NetworkVO.ODS_EXTRACTOR;
        aux.beneficiarios = getODSbeneficiario(odsin.id_ods);
        aux.awards = getODSaward(odsin.id_ods);
        aux.areas = getODSarea(odsin.id_ods);
        if (odsin.Logo != null) aux.imgdata = odsin.Logo.ToArray();



        return aux;

    }

    private List<String> getODSbeneficiario(int id)                             //getODSbeneficiario receive (id_ods) Return List of Beneficiarion
    {
        List<String> lista = new List<String>();
        FVSL_LINQDataContext dbaux = new FVSL_LINQDataContext();

        try
        {

            List<MAPA_GET_BENFResult> benefs = dbaux.MAPA_GET_BENF(id, 2).ToList();

            foreach (MAPA_GET_BENFResult ben in benefs)
            {
                lista.Add(ben.Nombre);
            }

            return lista;
        }
        catch (Exception e)
        {
            Logging.WriteError(e.StackTrace.ToString());
            return null;
        }
    }
    private List<AwardVO> getODSaward(int id)                                   //getODSaward receive (id_ods) Return List of Award
    {
        List<AwardVO> lista = new List<AwardVO>();

        FVSL_LINQDataContext dbaux = new FVSL_LINQDataContext();

        try
        {

            List<MAPA_GET_AWAResult> awards = dbaux.MAPA_GET_AWA(id, 2).ToList();

            foreach (MAPA_GET_AWAResult awa in awards)
            {
                AwardVO AVO = new AwardVO();

                AVO.awardName = awa.nombre;
                AVO.recibido = awa.Otorgado;

                lista.Add(AVO);
            }

            return lista;
        }
        catch (Exception e)
        {
            Logging.WriteError(e.StackTrace.ToString());
            return null;
        }
    }
    private List<AreaVO> getODSarea(int id)                                     //getODSarea receive (id_ods) Return List of Areas
    {
        List<AreaVO> lista = new List<AreaVO>();
        FVSL_LINQDataContext dbaux = new FVSL_LINQDataContext();

        try
        {

            List<p_Select_ODS_PerfilResult> areas = dbaux.p_Select_ODS_Perfil(id).ToList();


            foreach (p_Select_ODS_PerfilResult are in areas)
            {
                AreaVO A = new AreaVO();
                A.area = are.AreaIntervencion;

                lista.Add(A);
            }

            return lista;
        }
        catch (Exception e)
        {
            Logging.WriteError(e.StackTrace.ToString());
            return null;
        }
    }
}
