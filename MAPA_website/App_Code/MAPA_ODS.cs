using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml.Linq;
using System.Collections.Generic;

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

    [WebMethod]
    public string HelloWorld() {
        return "Hello World";
    }

    [WebMethod]
    public List<ODSVO> getODSD(int inods)
    {
        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

        List<ODS_ODS> resultset = dbcon.MAPA_ODS_DETAILS(inods).ToList();

        EntityVO aux;

        //ODS_ODS ods = new ODS_ODS();

        List<ODSVO> result = new List<ODSVO>();
        
        //dbcon.ODS_ODS ods = new System.Data.Linq.Table<ODS_OD>();
        //dbcon.ODS_ODS ods = new System.Data.Linq.Table<ODS_ODS>();
        //result.Add(dbcon.MAPA_ODS_ALL().Cast<EntityVO>);

        foreach (ODS_ODS ods in resultset)
        {
            result.Add(FODS(ods));
        }

        return result;
    }

    private ODSVO FODS(ODS_ODS odsin)
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

        return aux;

    }

    private List<String> getODSbeneficiario(int id)
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
    
}

