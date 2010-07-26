using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml.Linq;
using System.Collections.Generic;
using System.Data.Linq;

/// <summary>
/// Summary description for MAPA_COOP
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class MAPA_COOP : System.Web.Services.WebService {

    public MAPA_COOP () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public List<CooperantVO> getCOOPD(int incoop)
    {
        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

        List<CooperantVO> lista = new List<CooperantVO>();

        List<tb_Coperante> resultset = dbcon.MAPA_COOP_DETAILS(incoop).ToList();

        foreach (tb_Coperante coop in resultset)
        {
            lista.Add(FCOOP(coop));
        }

        return lista;
    }
    [WebMethod]
    public List<EntityVO> getCOOPsearch(int idestado, string nombre,int tiporg,int fat, string area,int enfoq, string premios)
    {
        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

        List<EntityVO> lista = new List<EntityVO>();

        ISingleResult<dynamicLINQC> resultset = dbcon.MAPA_SEARCH_COOP_BY(idestado, nombre, tiporg, fat, area, enfoq, premios);

        EntityVO EVO2 = new EntityVO();
        lista.Add(EVO2);

        foreach (dynamicLINQC dyn in resultset)
        {
            EntityVO EVO = new EntityVO();

            EVO.id = dyn.id_coperante.ToString();
            EVO.name = dyn.nombre;
            EVO.latitude = dyn.Latitud.ToString();
            EVO.longitude = dyn.Longitud.ToString();

            lista.Add(EVO);
        }

        //IEnumerable<dynamicLINQ> result = FVSL_LINQDataContext.ExecuteQuery<dynamicLINQ>("EXEC MAPA_SEARCH_ODS_BY",2,null,"IS",null,NULL);

        return lista;
    }
    public List<EntityVO> getCOOPA()
    {
        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

        List<EntityVO> lista = new List<EntityVO>();

        List<MAPA_COOP_ALLResult> resultset = dbcon.MAPA_COOP_ALL().ToList();

        foreach (MAPA_COOP_ALLResult coopa in resultset)
        {
            EntityVO EVO = new EntityVO();

            EVO.id = coopa.id_coperante.ToString();
            EVO.name = coopa.nombré;
            EVO.latitude = coopa.Latitud;
            EVO.longitude = coopa.Longitud;

            lista.Add(EVO);
        }

        return lista;
    }

    private CooperantVO FCOOP(tb_Coperante coopin)
    {
        CooperantVO aux = new CooperantVO();

        aux.id = coopin.id_coperante.ToString();
        aux.name = coopin.nombre;
        aux.latitude = coopin.Latitud;
        aux.longitude = coopin.Longitud;
        aux.direction = coopin.ciudad + ", " + coopin.urbanizacion + " " + coopin.calle;
        aux.website = coopin.pagina_web;
        aux.facebook = coopin.Facebook;
        aux.twitter = coopin.Twitter;
        aux.objective = coopin.objetivos;
        aux.email = coopin.email;
        aux.type = "cooperante";
        aux.beneficiarios = getCOOPbeneficiario(coopin.id_coperante);
        aux.awards = getCOOPaward(coopin.id_coperante);
        aux.areas = getCOOParea(coopin.id_coperante);
        //if (coopin.Logo.ToArray().Equals(null)) aux.imgdata = coopin.Logo.ToArray();
        aux.enfoque = coopin.EnfoqueGeografico.ToString();
        aux.tipoOrganizacion = coopin.tipo_organizacion.ToString();

        return aux;
    }

    private List<String> getCOOPbeneficiario(int coopin)
    {
        List<String> lista = new List<String>();

        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

        List<beneficiario> benef = dbcon.MAPA_GET_BENEF_COOP(coopin).ToList();

        foreach (beneficiario ben in benef)
        {
            lista.Add(ben.nombre);
        }

        return lista;
    }
    private List<AwardVO> getCOOPaward(int id)                                   //getcoopward receive (id_ods) Return List of Award
    {
        List<AwardVO> lista = new List<AwardVO>();

        FVSL_LINQDataContext dbaux = new FVSL_LINQDataContext();

        List<tb_Premios_Coperante> awards = dbaux.MAPA_GET_AWA_COOP(id).ToList();

        foreach (tb_Premios_Coperante awa in awards)
        {
            AwardVO AVO = new AwardVO();

            AVO.awardId = awa.id_premios;
            AVO.awardName = awa.nombre; 
            AVO.recibido = awa.id_Otorgado_Recibido.GetValueOrDefault();

            lista.Add(AVO);
        }

        return lista;
    }
    private List<String> getCOOParea(int id)                                     //getcooprea receive (id_ods) Return List of Areas
    {
        List<String> lista = new List<String>();

        FVSL_LINQDataContext dbaux = new FVSL_LINQDataContext();

        List<MAPA_GET_SUBAREA_COOPResult> areas = dbaux.MAPA_GET_SUBAREA_COOP(id).ToList();

        foreach (MAPA_GET_SUBAREA_COOPResult are in areas)
        {
            lista.Add(are.areaintervencion + ", " + are.subcategoria);
        }

        return lista;
    }
}

