<%@ WebService Language="C#" Class="Network" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Collections.Generic;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class Network  : System.Web.Services.WebService {

    [WebMethod]
    public List<NetworkVO> GetAllNetworks()
    {

        VSLMapsTableAdapters.InvitacionTableAdapter adapter = new VSLMapsTableAdapters.InvitacionTableAdapter();
        VSLMaps.InvitacionDataTable table = adapter.GetUserNetworks();      

        List<NetworkVO> results = new List<NetworkVO>();
        foreach (VSLMaps.InvitacionRow row in table)
        {
            NetworkVO ntwrk = new NetworkVO();
            
            if (Int32.Parse(row["total"].ToString()) > 0)
            {
                ntwrk.nodes = GetNetworkNodes(row.Id_Anfitriona, row.Tipo_Anfitriona);
                ntwrk.parent = GetParentNode(row.Id_Anfitriona, row.Tipo_Anfitriona);
            }
            
            results.Add(ntwrk);
        }

        return results;
    }

    private EntityVO GetParentNode(int parentId, int parentType)
    {
        EntityVO auxCoop = new EntityVO();
        
        switch (parentType)
        {
            case 3://dependiendo de el tipo de nodo que sea el padre
                
                VSLMapsTableAdapters.CooperantTableAdapter cooperantAdapter = new VSLMapsTableAdapters.CooperantTableAdapter();
                VSLMaps.CooperantDataTable cooperantTable = cooperantAdapter.GetSingleCooperant(parentId);

                if (cooperantTable.Count == 1)
                {
                    VSLMaps.CooperantRow cooperantRow = (VSLMaps.CooperantRow)cooperantTable.Rows[0];
                    auxCoop.name = cooperantRow.nombre;
                    auxCoop.latitude = cooperantRow.Latitud;
                    auxCoop.longitude = cooperantRow.Longitud;
                    auxCoop.type = "cooperant";

                }
                
                
            break;
        }

        return auxCoop;
    }

    private List<EntityVO> GetNetworkNodes(int id, int type)
    {

        VSLMapsTableAdapters.InvitacionTableAdapter adapter = new VSLMapsTableAdapters.InvitacionTableAdapter();
        VSLMaps.InvitacionDataTable table = adapter.GetNetworkNodes(id);

        List<EntityVO> results = new List<EntityVO>();
        foreach (VSLMaps.InvitacionRow row in table)
        {
            if (row.Tipo == 3)//El id del tipo de invitada
            {
                EntityVO aux = GetCooperantNode(row.Id_Invitada);
                results.Add(aux);
            }
        }

        return results;
    }
    
    private EntityVO GetCooperantNode(int id)
    {

        VSLMapsTableAdapters.CooperantTableAdapter adapter = new VSLMapsTableAdapters.CooperantTableAdapter();
        VSLMaps.CooperantDataTable cooperants = adapter.GetSingleCooperant(id);

        if (cooperants.Count == 1)
        {
            VSLMaps.CooperantRow row = (VSLMaps.CooperantRow)cooperants.Rows[0];
            EntityVO aux = new EntityVO();
            aux.latitude = row.Latitud;
            aux.longitude = row.Longitud;
            aux.name = row.nombre;
            aux.type = "cooperant";
            return aux;
        }
        else
        {
            return null;
        }
    }
    
}