using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml.Linq;
using System.Collections.Generic;
using MAP;
/// <summary>
/// Summary description for Network
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class Network : System.Web.Services.WebService {

    public Network () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public List<NetworkVO> getN(String type)
    {
        return NetworkExtractor.create(type).getN();
    }

    [WebMethod]
    public List<NetworkVO> getSearch(String type, List<String> data)
    {
        if (data.Count >= 2)
        {
            return NetworkExtractor.create(type).getSearch(data);
        }
        else
        {
            Logging.WriteError("Los datos de entrada fueron insuficientes");
            return null;
        }
    }

    [WebMethod]
    public NetworkVO getDetails(String type, int padre)
    {
        return NetworkExtractor.create(type).getDetails(padre);
    }
    
}

