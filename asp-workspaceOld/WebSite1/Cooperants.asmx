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

        VSLMapsTableAdapters.CooperantTableAdapter cooperantAdapter = new VSLMapsTableAdapters.CooperantTableAdapter();
        VSLMaps.CooperantDataTable cooperants;

        cooperants = cooperantAdapter.GetCooperants();

        List<CooperantVO> results = new List<CooperantVO>();
        foreach (VSLMaps.CooperantRow cooperantRow in cooperants)
        {
            results.Add(geCooperantFromRow(cooperantRow));
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

            results.Add(aux);
        }

        return results;
    }

    [WebMethod]
    public List<CooperantVO> searchCooperants(int idPais, String nombreCoop, int idOrg, int financia, int idEnfoque, Array beneficiarios)
    {
        VSLMapsTableAdapters.CooperantTableAdapter cooperantAdapter = new VSLMapsTableAdapters.CooperantTableAdapter();
        DataTable resultDataTable = ((VSLMaps.CooperantDataTable)cooperantAdapter.GetDataBy(idPais, nombreCoop, idOrg, financia, idEnfoque)).CopyToDataTable();

        foreach (String idBeneficiario in beneficiarios)
        {
            VSLMaps.CooperantDataTable cooperantsB = cooperantAdapter.GetCooperanyByBeneficiary(Int32.Parse(idBeneficiario));

            resultDataTable = (DataTable)DataTableExtensions.Intersect(resultDataTable, cooperantsB.CopyToDataTable());
        }

        List<CooperantVO> results = new List<CooperantVO>();
//        foreach (VSLMaps.CooperantRow cooperantRow in cooperants)
//        {
//            results.Add(geCooperantFromRow(cooperantRow));
//        }

        return results;
    }

    [WebMethod]
    public CooperantVO getCooperantDetails(int id)
    {
        VSLMapsTableAdapters.CooperantTableAdapter cooperantAdapter = new VSLMapsTableAdapters.CooperantTableAdapter();
        VSLMaps.CooperantDataTable cooperants = cooperantAdapter.GetSingleCooperant(id);

        if (cooperants.Count == 1)
            return getCooperantBig((VSLMaps.CooperantRow)cooperants.Rows[0]);
        else return null;
    }
        

    private CooperantVO geCooperantFromRow(VSLMaps.CooperantRow cooperantRow)
    {
        CooperantVO auxCoop = new CooperantVO();
        auxCoop.name = cooperantRow.nombre;
        auxCoop.latitude = cooperantRow.Latitud;
        auxCoop.longitude = cooperantRow.Longitud;

        return auxCoop;
    }

    private CooperantVO getCooperantBig(VSLMaps.CooperantRow cooperantRow)
    {
        CooperantVO auxCoop = new CooperantVO();
        auxCoop.name = cooperantRow.nombre;
        auxCoop.awards = getCoperantAwards(cooperantRow.id_coperante);
        auxCoop.direction = cooperantRow.ciudad + ", " + cooperantRow.calle + " " + cooperantRow.casa;
        if (!cooperantRow.IsNull("objetivos")) auxCoop.objective = cooperantRow.objetivos;
        if(!cooperantRow.IsNull("Telefono")) auxCoop.phone = cooperantRow.Telefono;
        if (!cooperantRow.IsNull("email")) auxCoop.email = cooperantRow.email;
        if (!cooperantRow.IsNull("Twitter")) auxCoop.twitter = cooperantRow.Twitter;
        if (!cooperantRow.IsNull("Facebook")) auxCoop.facebook = cooperantRow.Facebook;
        if (!cooperantRow.IsNull("pagina_web")) auxCoop.website = cooperantRow.pagina_web;

        return auxCoop;
    }
    
}