<%@ WebService Language="C#" Class="ODS" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Collections.Generic;

[WebService(Namespace = "http://mapasvsl.com/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class ODS  : System.Web.Services.WebService {


    [WebMethod]
    public List<EntityVO> GetAllODS()
    {
        try
        {

            VSLMapsTableAdapters.ODSTableAdapter entityAdapter = new VSLMapsTableAdapters.ODSTableAdapter();
            VSLMaps.ODSDataTable ods = entityAdapter.GetAllODS();

            List<EntityVO> results = new List<EntityVO>();
            foreach (VSLMaps.ODSRow cooperantRow in ods)
            {
                results.Add(getOdsFromRow(cooperantRow));
            }

            return results;
        
        }
        catch (Exception e)
        {
            Logging.WriteError(e.StackTrace.ToString());
            return null;
        }
    }


    [WebMethod]
    public ODSVO getODSDetails(int id)
    {
        try
        {
            VSLMapsTableAdapters.BigOdsTableAdapter cooperantAdapter = new VSLMapsTableAdapters.BigOdsTableAdapter();
            VSLMaps.BigOdsDataTable cooperants = cooperantAdapter.GetSingleODS(id);

            if (cooperants.Count == 1)
                return getOdsFromBig((VSLMaps.BigOdsRow)cooperants.Rows[0]);
            else return null;
        
        }
        catch (Exception e)
        {
            Logging.WriteError(e.StackTrace.ToString());
            return null;
        }
        
    }

    private EntityVO getOdsFromRow(VSLMaps.ODSRow row)
    {
        EntityVO auxCoop = new EntityVO();
        auxCoop.name = row.nombre;
        auxCoop.latitude = row.Latitud;
        auxCoop.longitude = row.Longitud;
        auxCoop.id = row.id_ods.ToString();
        auxCoop.type = "ods";

        return auxCoop;
    }

    private ODSVO getOdsFromBig(VSLMaps.BigOdsRow row)
    {
        ODSVO auxCoop = new ODSVO();
        auxCoop.id = row.id_ods.ToString();
        auxCoop.name = row.nombre;
        auxCoop.latitude = row.Latitud;
        auxCoop.longitude = row.Longitud;
        auxCoop.direction = row.ciudad + ", " + row.urbanizacion + " " + row.calle;
        auxCoop.website = row.pagina_web;
        auxCoop.facebook = row.FacebookODS;
        auxCoop.twitter = row.TwitterODS;
        auxCoop.objective = row.objetivos;
        auxCoop.email = row.email;
        auxCoop.type = "ods";
        auxCoop.beneficiarios = getODSBeneficiarios(row.id_ods);
        auxCoop.awards = getODSAwards(row.id_ods);
        auxCoop.areas = getODSAreas(row.id_ods);
        if (!row.IsNull("Logo")) auxCoop.imgdata = row.Logo;

        return auxCoop;
    }

    private List<String> getODSBeneficiarios(int id)
    {
        List<String> list = new List<string>();

        VSLMapsTableAdapters.BeneficiariosODSTableAdapter cooperantAdapter = new VSLMapsTableAdapters.BeneficiariosODSTableAdapter();
        VSLMaps.BeneficiariosODSDataTable ods = cooperantAdapter.GetBeneficiarios(id);

        foreach (VSLMaps.BeneficiariosODSRow row in ods)
        {
            list.Add(row.nombre+", "+row.cantidad);
        }

        return list;
    }

    private List<AwardVO> getODSAwards(int id)
    {
        VSLMapsTableAdapters.ODSAwardsTableAdapter cooperantAdapter = new VSLMapsTableAdapters.ODSAwardsTableAdapter();
        VSLMaps.ODSAwardsDataTable ods = cooperantAdapter.GetAwardsBy(id);

        List<AwardVO> awards = new List<AwardVO>();
        foreach (VSLMaps.ODSAwardsRow row in ods)
        {

            AwardVO award = new AwardVO();
            award.awardName = row.nombre;
            award.awardId = row.id_premios;
            award.recibido = row.id_Ortogado_Recibido;
            awards.Add(award);
        }

        return awards;
    }

    private List<String> getODSAreas(int id)
    {
        VSLMapsTableAdapters.ODSAreasIntervencionTableAdapter cooperantAdapter = new VSLMapsTableAdapters.ODSAreasIntervencionTableAdapter();
        VSLMaps.ODSAreasIntervencionDataTable ods = cooperantAdapter.GetAreasIntervencion(id);

        List<String> list = new List<String>();
        foreach(VSLMaps.ODSAreasIntervencionRow row in ods)
        {
            list.Add(row.area+", "+row.subcategoria);
        }

        return list;
    }
    
}