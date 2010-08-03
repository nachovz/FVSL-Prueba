﻿using System;
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
/// Summary description for COOPextract
/// </summary>
public class COOPextract: IEntityExtractor
{
	public COOPextract()
	{
		//
		// TODO: Add constructor logic here
		//
	}


    /*public List<CooperantVO> getCOOPD(int incoop)
    {
        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

        List<CooperantVO> lista = new List<CooperantVO>();

        List<tb_Coperante> resultset = dbcon.MAPA_COOP_DETAILS(incoop).ToList();

        foreach (tb_Coperante coop in resultset)
        {
            lista.Add(FCOOP(coop));
        }

        return lista;
    }*/
    public EntityVO getDetails(int incoop)
    {
        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();                //Create LINQ-SQL connection

        //List<ODS_ODS> resultset = dbcon.MAPA_ODS_DETAILS(inods).ToList();       //Create ODS_ODS List AND assign SPROC result
        //ISingleResult<ODS_ODS> resultset = dbcon.MAPA_ODS_DETAILS(inods); ;
        //List<ODSVO> result = new List<ODSVO>();                                 //Create Return list
        var resultset = dbcon.MAPA_COOP_DETAILS(incoop);

        foreach (tb_Coperante coop in resultset)                                      //Start reading Resulset list, and adding to Result
        {
            return FCOOP(coop);
            //break;
        }


        return null;
    }

    //getSearch in:List<String> (int enfoq, int idestado, string nombre, string area, string premios, int tiporg, int fat)

    public List<EntityVO> getSearch(List<String> datos)
    {
        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

        List<EntityVO> lista = new List<EntityVO>();

        ISingleResult<dynamicLINQC> resultset = dbcon.MAPA_SEARCH_COOP_BY(1, "se",2,4, "se",5, "se"/*datos[1], datos[2], (int)datos[5], (int)datos[6], datos[3], (int)datos[0], datos[4]*/);

        //EntityVO EVO2 = new EntityVO();
        //lista.Add(EVO2);

/*
        if (resultset.Count().Equals(1))
        {
            EntityVO EVO = new EntityVO();

            EVO.id = resultset.ElementAt(0).id_coperante.ToString();
            EVO.name = resultset.ElementAt(0).nombre;
            EVO.latitude = resultset.ElementAt(0).Latitud.ToString();
            EVO.longitude = resultset.ElementAt(0).Longitud.ToString();

            //lista.Add(EVO);
            return EVO;
        }

        return null;
        */

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

    public List<EntityVO> getAll()
    {
        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

        List<EntityVO> lista = new List<EntityVO>();

        List<MAPA_COOP_ALLResult> resultset = dbcon.MAPA_COOP_ALL().ToList();

        foreach (MAPA_COOP_ALLResult coopa in resultset)
        {
            EntityVO EVO = new EntityVO();

            EVO.id = coopa.id_coperante.ToString();
            EVO.name = coopa.nombre;
            EVO.latitude = coopa.Latitud;
            EVO.longitude = coopa.Longitud;

            lista.Add(EVO);
        }

        return lista;
    }

    private EntityVO FCOOP(tb_Coperante coopin)
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

        List<MAPA_GET_BENFResult> benef = dbcon.MAPA_GET_BENF(coopin, 3).ToList();

        foreach (MAPA_GET_BENFResult ben in benef)
        {
            lista.Add(ben.Nombre);
        }

        return lista;
    }
    private List<AwardVO> getCOOPaward(int id)                                   //getcoopward receive (id_ods) Return List of Award
    {
        List<AwardVO> lista = new List<AwardVO>();

        FVSL_LINQDataContext dbaux = new FVSL_LINQDataContext();

        List<MAPA_GET_AWAResult> awards = dbaux.MAPA_GET_AWA(id,3).ToList();

        foreach (MAPA_GET_AWAResult awa in awards)
        {
            AwardVO AVO = new AwardVO();

            AVO.awardName = awa.nombre;
            AVO.recibido = awa.Otorgado;

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