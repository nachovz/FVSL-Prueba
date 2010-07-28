using System;
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

/// <summary>
/// Summary description for IEntityExtractor
/// </summary>
public interface IEntityExtractor
{
    List<EntityVO> getAll();
    EntityVO getDetails(int i);
    List<EntityVO> getSearch(List<String> arr);
    
    //EntityVO getSearch(int idpais, int idestado, string nombre, string area, string premios);
    //EntityVO getSearch(int enfoq,  int idestado, string nombre, string area, string premios, int tiporg, int fat);
    
}
