<%@ WebService Language="C#" Class="Cooperants" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Collections.Generic;
using System.Data;

[WebService(Namespace = "http://mapasvsl.com/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class Cooperants  : System.Web.Services.WebService {

    [WebMethod]
    public List<CooperantVO> GetAllCooperants()
    {
        List<CooperantVO> results = new List<CooperantVO>();
        
        try
        {
            VSLMapsTableAdapters.CooperantTableAdapter cooperantAdapter = new VSLMapsTableAdapters.CooperantTableAdapter();
            VSLMaps.CooperantDataTable cooperants = cooperantAdapter.GetCooperants();
            foreach (VSLMaps.CooperantRow cooperantRow in cooperants)
            {
                results.Add(geCooperantFromRow(cooperantRow));
            }
        }
        catch (Exception e)
        {
            Logging.WriteError(e.StackTrace.ToString());
        }

        return results;
    }

    private List<AwardVO> getCoperantAwards(int coperantId)
    {
        VSLMapsTableAdapters.CooperantAwardsTableAdapter cooperantAwardsAdapter = new VSLMapsTableAdapters.CooperantAwardsTableAdapter();
        VSLMaps.CooperantAwardsDataTable awards = cooperantAwardsAdapter.GetAwardsBy(coperantId);

        List<AwardVO> results = new List<AwardVO>();
        foreach (VSLMaps.CooperantAwardsRow cooperantAwardRow in awards)
        {
            AwardVO aux = new AwardVO();
            aux.awardId = cooperantAwardRow.id_premios;
            aux.awardName = cooperantAwardRow.nombre;
            aux.recibido = cooperantAwardRow.id_Otorgado_Recibido;
            results.Add(aux);
        }

        return results;
    }

    private List<String> getCoperantInterests(int coperantId)
    {
        VSLMapsTableAdapters.CooperanteAreasIntervencionTableAdapter cooperantAwardsAdapter = new VSLMapsTableAdapters.CooperanteAreasIntervencionTableAdapter();
        VSLMaps.CooperanteAreasIntervencionDataTable awards = cooperantAwardsAdapter.GetAreaDeIntervencion(coperantId);

        List<String> results = new List<String>();
        foreach (VSLMaps.CooperanteAreasIntervencionRow cooperantAwardRow in awards)
        {
            results.Add(cooperantAwardRow.area + ", " + cooperantAwardRow.nombre);
        }

        return results;
    }

    private List<String> getBeneficiarios(int coperantId)
    {
        VSLMapsTableAdapters.CooperanteBeneficiarioTableAdapter cooperantAwardsAdapter = new VSLMapsTableAdapters.CooperanteBeneficiarioTableAdapter();
        VSLMaps.CooperanteBeneficiarioDataTable awards = cooperantAwardsAdapter.GetBeneficiarios(coperantId);

        List<String> results = new List<String>();
        foreach (VSLMaps.CooperanteBeneficiarioRow cooperantAwardRow in awards)
        {
            results.Add(cooperantAwardRow.nombre+", "+cooperantAwardRow.cantidad);
        }

        return results;
    } 
       
    [WebMethod]
    public List<CooperantVO> searchCooperants(int idPais, String nombreCoop, int idOrg, int financia, int idEnfoque)
    {
        VSLMapsTableAdapters.CooperantTableAdapter cooperantAdapter = new VSLMapsTableAdapters.CooperantTableAdapter();
        VSLMaps.CooperantDataTable cooperants = cooperantAdapter.GetDataBy(idPais, nombreCoop, idOrg, financia, idEnfoque);

        List<CooperantVO> results = new List<CooperantVO>();
        foreach (VSLMaps.CooperantRow cooperantRow in cooperants)
        {
            results.Add(geCooperantFromRow(cooperantRow));
        }

        return results;
    }

    [WebMethod]
    public CooperantVO getCooperantDetails(int id)
    {
        try
        {
            VSLMapsTableAdapters.BigCooperantTableAdapter cooperantAdapter = new VSLMapsTableAdapters.BigCooperantTableAdapter();
            VSLMaps.BigCooperantDataTable cooperants = cooperantAdapter.GetSingleCooperant(id);

            if (cooperants.Count == 1)
                return getCooperantBig((VSLMaps.BigCooperantRow)cooperants.Rows[0]);
            else return null;
        
        }
        catch (Exception e)
        {
            Logging.WriteError(e.StackTrace.ToString());
            return null;
        }
    }
        

    private CooperantVO geCooperantFromRow(VSLMaps.CooperantRow cooperantRow)
    {
        CooperantVO auxCoop = new CooperantVO();
        auxCoop.id = cooperantRow.id_coperante.ToString();
        auxCoop.name = cooperantRow.nombre;
        auxCoop.latitude = cooperantRow.Latitud;
        auxCoop.longitude = cooperantRow.Longitud;
        auxCoop.type = "cooperant";

        return auxCoop;
    }

    private CooperantVO getCooperantBig(VSLMaps.BigCooperantRow cooperantRow)
    {
        CooperantVO auxCoop = new CooperantVO();
        auxCoop.name = cooperantRow.nombre;
        auxCoop.type = "cooperant";
        auxCoop.latitude = cooperantRow.Latitud;
        auxCoop.longitude = cooperantRow.Longitud;
        auxCoop.awards = getCoperantAwards(cooperantRow.id_coperante);
        auxCoop.beneficiarios = getBeneficiarios(cooperantRow.id_coperante);
        auxCoop.areas = getCoperantInterests(cooperantRow.id_coperante);
        auxCoop.direction = cooperantRow.ciudad + ", " + cooperantRow.calle + " " + cooperantRow.casa;
        auxCoop.enfoque = cooperantRow.alcance;
        auxCoop.tipoOrganizacion = cooperantRow.Tipo_Organizacion;
        if (!cooperantRow.IsNull("objetivos")) auxCoop.objective = cooperantRow.objetivos;
        if(!cooperantRow.IsNull("Telefono")) auxCoop.phone = cooperantRow.Telefono;
        if (!cooperantRow.IsNull("email")) auxCoop.email = cooperantRow.email;
        if (!cooperantRow.IsNull("Twitter")) auxCoop.twitter = cooperantRow.Twitter;
        if (!cooperantRow.IsNull("Facebook")) auxCoop.facebook = cooperantRow.Facebook;
        if (!cooperantRow.IsNull("pagina_web")) auxCoop.website = cooperantRow.pagina_web;
        if (!cooperantRow.IsNull("Logo")) auxCoop.imgdata = cooperantRow.Logo;

        return auxCoop;
    }
    
}