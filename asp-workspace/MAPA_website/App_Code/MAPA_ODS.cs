﻿using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml.Linq;
using System.Collections.Generic;
using System.Data.Linq;

/// <summary>
/// Summary description for MAPA_ODS
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class MAPA_ODS : System.Web.Services.WebService {

    public MAPA_ODS () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    /*[WebMethod]
    public List<ODSVO> getODSD(int inods)                                       //getODSD receive (id_ods) Return List of ODSVO
    {
        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();                //Create LINQ-SQL connection

        List<ODS_ODS> resultset = dbcon.MAPA_ODS_DETAILS(inods).ToList();       //Create ODS_ODS List AND assign SPROC result
        
        List<ODSVO> result = new List<ODSVO>();                                 //Create Return list
        
        foreach (ODS_ODS ods in resultset)                                      //Start reading Resulset list, and adding to Result
        {
            result.Add(FODS(ods));
        }

        return result;
    }*/
    [WebMethod]
    public List<EntityVO> getODSsearch(int idpais, int idestado, string nombre, string area, string premios)
    {
        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

        List<EntityVO> lista = new List<EntityVO>();

        ISingleResult<dynamicLINQ> resultset = dbcon.MAPA_SEARCH_ODS_BY(idpais, idestado, nombre, area, premios);

        foreach (dynamicLINQ dyn in resultset)
        {
            EntityVO EVO = new EntityVO();

            EVO.id = dyn.id_ods.ToString();
            EVO.name = dyn.nombre;
            EVO.latitude = dyn.latitud.ToString();
            EVO.longitude = dyn.longitud.ToString();
            
            lista.Add(EVO);
        }

        //IEnumerable<dynamicLINQ> result = FVSL_LINQDataContext.ExecuteQuery<dynamicLINQ>("EXEC MAPA_SEARCH_ODS_BY",2,null,"IS",null,NULL);

        return lista;
    }
    [WebMethod]
    public List<EntityVO> getODSA()
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
        if (odsin.Logo.ToArray().Equals(null)) aux.imgdata = odsin.Logo.ToArray();

        

        return aux;

    }

    private List<String> getODSbeneficiario(int id)                             //getODSbeneficiario receive (id_ods) Return List of Beneficiarion
    {
        List<String> lista = new List<string>();
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

