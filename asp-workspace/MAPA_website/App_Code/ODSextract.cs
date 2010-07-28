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

        //List<ODS_ODS> resultset = dbcon.MAPA_ODS_DETAILS(inods).ToList();       //Create ODS_ODS List AND assign SPROC result
        //ISingleResult<ODS_ODS> resultset = dbcon.MAPA_ODS_DETAILS(inods); ;
        ODSVO result = new ODSVO();                                 //Create Return list
        List<ODS_ODS> resultset = dbcon.MAPA_ODS_DETAILS(inods).ToList(); 

        //EntityVO ent = new EntityVO();
            
        if (resultset.Count == 1){  
            result = FODS(resultset[0]);
        }

        
        return (EntityVO)result;
    }

    public List<EntityVO> getSearch(List<String> datos)                           //getSearch in:List<String> (int idpais, int idestado, string nombre, string area, string premios)
    {
        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

        List<EntityVO> lista = new List<EntityVO>();

        ISingleResult<dynamicLINQ> resultset = dbcon.MAPA_SEARCH_ODS_BY(int.Parse(datos[0]), int.Parse(datos[1]), datos[2], datos[3], datos[4]);

        foreach (dynamicLINQ dyn in resultset)
        {
        //dynamicLINQ dyn = new dynamicLINQ();

        //if(resultset.Count().Equals(1)){
            EntityVO EVO = new EntityVO();

            /*EVO.id = resultset.ElementAt(0).id_ods.ToString();
            EVO.name = resultset.ElementAt(0).nombre;
            EVO.latitude = resultset.ElementAt(0).latitud.ToString();
            EVO.longitude = resultset.ElementAt(0).longitud.ToString();
            */
            EVO.id = dyn.id_ods.ToString();
            EVO.name = dyn.nombre;
            EVO.latitude = dyn.latitud.ToString();
            EVO.longitude = dyn.longitud.ToString();
            
            lista.Add(EVO);
            //return EVO;
        }

        return lista;
        //IEnumerable<dynamicLINQ> result = FVSL_LINQDataContext.ExecuteQuery<dynamicLINQ>("EXEC MAPA_SEARCH_ODS_BY",2,null,"IS",null,NULL);

        
    }

    public List<EntityVO> getAll()
    {
        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

        List<EntityVO> lista = new List<EntityVO>();

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

    private ODSVO FODS(ODS_ODS odsin)                                           //FODS receive (ODS_ODS) Return ODSVO object (full)
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
        aux.type = "ods";
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

        List<beneficiario> benefs = dbaux.MAPA_GET_BENF_ODS(id).ToList();

        foreach (beneficiario ben in benefs)
        {
            lista.Add(ben.nombre);
        }

        return lista;

    }
    private List<AwardVO> getODSaward(int id)                                   //getODSaward receive (id_ods) Return List of Award
    {
        List<AwardVO> lista = new List<AwardVO>();
        FVSL_LINQDataContext dbaux = new FVSL_LINQDataContext();

        List<tb_Premios_ODS> awards = dbaux.MAPA_GET_AWA_ODS(id).ToList();

        foreach (tb_Premios_ODS awa in awards)
        {
            AwardVO AVO = new AwardVO();

            AVO.awardId = awa.id_premios;
            AVO.awardName = awa.nombre;
            //if(!awa.id_Ortogado_Recibido.Equals(null)) 
            AVO.recibido = awa.id_Ortogado_Recibido.GetValueOrDefault();

            lista.Add(AVO);
        }

        return lista;
    }
    private List<String> getODSarea(int id)                                     //getODSarea receive (id_ods) Return List of Areas
    {
        List<String> lista = new List<String>();
        FVSL_LINQDataContext dbaux = new FVSL_LINQDataContext();

        List<p_Select_ODS_PerfilResult> areas = dbaux.p_Select_ODS_Perfil(id).ToList();


        foreach (p_Select_ODS_PerfilResult are in areas)
        {
            lista.Add(are.AreaIntervencion.ToString());
        }

        return lista;
    }
}
