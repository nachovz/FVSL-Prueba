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
    public List<EntityVO> getallODS()
    {
        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

        var resultset = dbcon.MAPA_ODS_ALL();

        EntityVO aux = new EntityVO();
        //ODS_ODS ods = new ODS_ODS();

        List<EntityVO> result = new List<EntityVO>();
        
        //dbcon.ODS_ODS ods = new System.Data.Linq.Table<ODS_OD>();
        //dbcon.ODS_ODS ods = new System.Data.Linq.Table<ODS_ODS>();
        //result.Add(dbcon.MAPA_ODS_ALL().Cast<EntityVO>);

        

        //foreach (ODS_ODS ods in result)
        //{
          //  result.Add(resultset);
        //}

        return result;
    }
    
}

