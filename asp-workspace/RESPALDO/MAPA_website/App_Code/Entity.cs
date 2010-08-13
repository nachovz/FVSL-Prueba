using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml.Linq;
using System.Collections.Generic;

/// <summary>
/// Summary description for Entity
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class Entity : System.Web.Services.WebService {

    public Entity () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public List<EntityVO> getAll(String type) {
        return EntityExtractor.create(type).getAll();
    }
    [WebMethod]
    public EntityVO getDetails(String type,int i) {
        return EntityExtractor.create(type).getDetails(i);
         
    }
    [WebMethod]
    //public EntityVO getSearch(String type, int idpais, int idestado, string nombre, string area, string premios) {
    public List<EntityVO> getSearch(String type, List<String> datos) {

        if (datos.Count >= 5)
        {
            return EntityExtractor.create(type).getSearch(datos);
        }
        else
        {
            Logging.WriteError("Los datos de entrada fueron insuficientes");
            return null;
        } 
        
    }
    /*[WebMethod]
    public EntityVO getSearch(String type, int enfoq, int idestado, string nombre, string area, string premios, int tiporg, int fat)
    {
        EntityVO objeto = EntityExtractor.create(type).getSearch(enfoq, idestado, nombre, area, premios, tiporg, fat);
        return objeto;
    }*/
}

