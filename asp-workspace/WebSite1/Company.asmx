<%@ WebService Language="C#" Class="Company" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;

[WebService(Namespace = "http://mapasvsl.com/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class Company  : System.Web.Services.WebService {

    [WebMethod]
    public EntityVO GetCompanyDetails(int id) 
    {

        VSLMapsTableAdapters.BigCompanyTableAdapter adapter = new VSLMapsTableAdapters.BigCompanyTableAdapter();
        VSLMaps.BigCompanyDataTable ods = adapter.GetSingleCompany(id);

        if (ods.Count == 1)
        {
            VSLMaps.BigCompanyRow row = (VSLMaps.BigCompanyRow)ods.Rows[0];
            EntityVO aux = new EntityVO();
            aux.latitude = row.Latitud;
            aux.longitude = row.Longitud;
            aux.id = row.id_sociosociales.ToString();
            aux.name = row.nombre;
            aux.direction = row.ciudad + ", " + row.calle + ", " + row.casa;
            if (!row.IsNull("Logo")) aux.imgdata = row.Logo;
            if (!row.IsNull("Telefono")) aux.phone = row.Telefono;
            if (!row.IsNull("email")) aux.email = row.email;
            if (!row.IsNull("FacebookODS")) aux.facebook = row.FacebookODS;
            if (!row.IsNull("TwitterODS")) aux.twitter = row.TwitterODS;
            if (!row.IsNull("pagina_web")) aux.website = row.pagina_web;

            aux.type = "company";
            return aux;
        }
        else
        {
            return null;
        }

    }
    
}