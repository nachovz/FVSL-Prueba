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

        VSLMapsTableAdapters.ODSTableAdapter entityAdapter = new VSLMapsTableAdapters.ODSTableAdapter();
        VSLMaps.ODSDataTable ods = entityAdapter.GetODS();

        List<EntityVO> results = new List<EntityVO>();
        foreach (VSLMaps.ODSRow cooperantRow in ods)
        {
            results.Add(getOdsFromRow(cooperantRow));
        }

        return results;
    }

    private EntityVO getOdsFromRow(VSLMaps.ODSRow row)
    {
        EntityVO auxCoop = new EntityVO();
        auxCoop.name = row.nombre;
        auxCoop.latitude = row.Latitud;
        auxCoop.longitude = row.Longitud;

        return auxCoop;
    }

    private EntityVO getOdsFromBig(VSLMaps.ODSRow row)
    {
        EntityVO auxCoop = new EntityVO();
        auxCoop.name = row.nombre;
        auxCoop.latitude = row.Latitud;
        auxCoop.longitude = row.Longitud;
        auxCoop.direction = row.ciudad + ", " + row.urbanizacion + " " + row.calle;
        auxCoop.website = row.pagina_web;
        auxCoop.facebook = row.FacebookODS;
        auxCoop.twitter = row.TwitterODS;
        auxCoop.objective = row.objetivos;
        auxCoop.email = row.email;
        if (!row.IsNull("Logo")) auxCoop.imgdata = row.Logo;

        return auxCoop;
    }
    
}