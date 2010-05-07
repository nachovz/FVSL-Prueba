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

        VSLMapsTableAdapters.InvitacionSinUsuarioTableAdapter adapterSinUsuario = new VSLMapsTableAdapters.InvitacionSinUsuarioTableAdapter();
        VSLMaps.InvitacionSinUsuarioDataTable tableSinUsuario = adapterSinUsuario.GetNoUserNetworks();
        
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
        foreach (VSLMaps.InvitacionSinUsuarioRow row in tableSinUsuario)
        {
            NetworkVO ntwrk = new NetworkVO();

            if (Int32.Parse(row["total"].ToString()) > 0)
            {
                ntwrk.nodes = GetUserlessNetworkNodes(row.Id_Anfitriona, row.Tipo_Anfitriona);
                ntwrk.parent = GetParentNode(row.Id_Anfitriona, row.Tipo_Anfitriona);
            }

            results.Add(ntwrk);
        }

        return results;
    }

    [WebMethod]
    public List<NetworkVO> searchNetworks(String name, int country)
    {

        VSLMapsTableAdapters.InvitacionTableAdapter adapter = new VSLMapsTableAdapters.InvitacionTableAdapter();
        VSLMaps.InvitacionDataTable tableCooperant = adapter.GetCooperantNetworksBy(name, country);
        VSLMaps.InvitacionDataTable tableCompany = adapter.GetCompanyNetworksBy(name, country);
        VSLMaps.InvitacionDataTable tableODS = adapter.GetODSNetworksBy(country,name);

        List<NetworkVO> results = new List<NetworkVO>();
        foreach (VSLMaps.InvitacionRow row in tableCooperant)
        {
            NetworkVO ntwrk = new NetworkVO();
            if (Int32.Parse(row["total"].ToString()) > 0)
            {
                ntwrk.nodes = GetNetworkNodes(row.Id_Anfitriona, row.Tipo_Anfitriona);
                ntwrk.parent = GetParentNode(row.Id_Anfitriona, row.Tipo_Anfitriona);
            }
            results.Add(ntwrk);
        }
        foreach (VSLMaps.InvitacionRow row in tableCompany)
        {
            NetworkVO ntwrk = new NetworkVO();
            if (Int32.Parse(row["total"].ToString()) > 0)
            {
                ntwrk.nodes = GetNetworkNodes(row.Id_Anfitriona, row.Tipo_Anfitriona);
                ntwrk.parent = GetParentNode(row.Id_Anfitriona, row.Tipo_Anfitriona);
            }
            results.Add(ntwrk);
        }
        foreach (VSLMaps.InvitacionRow row in tableODS)
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

                VSLMapsTableAdapters.BigCooperantTableAdapter cooperantAdapter = new VSLMapsTableAdapters.BigCooperantTableAdapter();
                VSLMaps.BigCooperantDataTable cooperantTable = cooperantAdapter.GetSingleCooperant(parentId);

                if (cooperantTable.Count == 1)
                {
                    VSLMaps.BigCooperantRow cooperantRow = (VSLMaps.BigCooperantRow)cooperantTable.Rows[0];
                    auxCoop.name = cooperantRow.nombre;
                    auxCoop.id = cooperantRow.id_coperante.ToString();
                    auxCoop.latitude = cooperantRow.Latitud;
                    auxCoop.longitude = cooperantRow.Longitud;
                    auxCoop.type = "cooperant";

                }
                
                
            break;
            case 1://dependiendo de el tipo de nodo que sea el padre

            VSLMapsTableAdapters.ODSTableAdapter odsAdapter = new VSLMapsTableAdapters.ODSTableAdapter();
            VSLMaps.ODSDataTable odsTable = odsAdapter.GetSingleODS(parentId);

            if (odsTable.Count == 1)
            {
                VSLMaps.ODSRow cooperantRow = (VSLMaps.ODSRow)odsTable.Rows[0];
                auxCoop.name = cooperantRow.nombre;
                auxCoop.id = cooperantRow.id_ods.ToString();
                auxCoop.latitude = cooperantRow.Latitud;
                auxCoop.longitude = cooperantRow.Longitud;
                auxCoop.type = "ods";

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
            else if (row.Tipo == 1)//El id del tipo de invitada
            {
                EntityVO aux = GetOdsNode(row.Id_Invitada);
                results.Add(aux);
            }
        }

        return results;
    }


    private List<EntityVO> GetUserlessNetworkNodes(int id, int type)
    {

        VSLMapsTableAdapters.InvitacionSinUsuarioTableAdapter adapter = new VSLMapsTableAdapters.InvitacionSinUsuarioTableAdapter();
        VSLMaps.InvitacionSinUsuarioDataTable table = adapter.GetUserlessNetworkNodes(id);

        List<EntityVO> results = new List<EntityVO>();
        foreach (VSLMaps.InvitacionSinUsuarioRow row in table)
        {
            if (row.Tipo == 1)//El id del tipo de invitada
            {
                EntityVO aux = GetOdsaNode(row.Correo);
                results.Add(aux);
            }
        }

        return results;
    }
    
    private EntityVO GetCooperantNode(int id)
    {

        VSLMapsTableAdapters.BigCooperantTableAdapter adapter = new VSLMapsTableAdapters.BigCooperantTableAdapter();
        VSLMaps.BigCooperantDataTable cooperants = adapter.GetSingleCooperant(id);

        if (cooperants.Count == 1)
        {
            VSLMaps.BigCooperantRow row = (VSLMaps.BigCooperantRow)cooperants.Rows[0];
            EntityVO aux = new EntityVO();
            aux.latitude = row.Latitud;
            aux.longitude = row.Longitud;
            aux.name = row.nombre;
            aux.type = "cooperant";
            aux.id = row.id_coperante.ToString();
            return aux;
        }
        else
        {
            return null;
        }
    }

    private EntityVO GetOdsNode(int id)
    {

        VSLMapsTableAdapters.ODSTableAdapter adapter = new VSLMapsTableAdapters.ODSTableAdapter();
        VSLMaps.ODSDataTable ods = adapter.GetSingleODS(id);

        if (ods.Count == 1)
        {
            VSLMaps.ODSRow row = (VSLMaps.ODSRow)ods.Rows[0];
            EntityVO aux = new EntityVO();
            aux.latitude = row.Latitud;
            aux.longitude = row.Longitud;
            aux.id = row.id_ods.ToString();
            aux.name = row.nombre;
            aux.type = "ods";
            return aux;
        }
        else
        {
            return null;
        }
    }

    private EntityVO GetOdsaNode(String correo)
    {

        VSLMapsTableAdapters.odsaTableAdapter adapter = new VSLMapsTableAdapters.odsaTableAdapter();
        VSLMaps.odsaDataTable ods = adapter.GetODSA(correo);

        if (ods.Count == 1)
        {
            VSLMaps.odsaRow row = (VSLMaps.odsaRow)ods.Rows[0];
            EntityVO aux = new EntityVO();
            aux.latitude = row.Latitud;
            aux.longitude = row.Longitud;
            aux.id = row.id_ods.ToString();
            aux.name = row.nombre;
            aux.type = "ods";
            return aux;
        }
        else
        {
            return null;
        }
    }
    
}