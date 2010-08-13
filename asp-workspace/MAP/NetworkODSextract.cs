﻿using System;
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
/// Summary description for NetworkODSextract
/// </summary>
public class NetworkODSextract : INetworkExtractor
{

    #region INetworkExtractor Members

    public List<NetworkVO> getN()
    {
        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

        List<NetworkVO> lista = new List<NetworkVO>();

        try
        {

            List<mapa_get_network_odsResult> resultset = dbcon.mapa_get_network_ods().ToList();

            foreach (mapa_get_network_odsResult net in resultset)
            {
                NetworkVO netw = new NetworkVO();
                EntityVO ent = new EntityVO();

                ent.id = net.id_ods.ToString();
                ent.name = net.nombre;
                ent.latitude = net.Latitud.ToString();
                ent.longitude = net.Longitud.ToString();
                netw.parent = ent;
                netw.type = NetworkVO.ODS_EXTRACTOR;

                lista.Add(netw);
            }

            return lista;
        }
        catch (Exception e)
        {
            Logging.WriteError(e.StackTrace.ToString());
            return null;
        }
    }

    public List<NetworkVO> getSearch(List<String> lista)
    {
        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

        List<NetworkVO> listain = new List<NetworkVO>();

        try
        {

            List<mapa_search_network_ods_byResult> resultset = dbcon.mapa_search_network_ods_by(int.Parse(lista[0]), int.Parse(lista[1]), lista[2]).ToList();

            foreach (mapa_search_network_ods_byResult snet in resultset)
            {
                NetworkVO netw = new NetworkVO();
                EntityVO ent = new EntityVO();

                ent.id = snet.id_anfitriona.ToString();
                ent.name = snet.nombre;
                ent.latitude = snet.latitud.ToString();
                ent.longitude = snet.longitud.ToString();
                netw.parent = ent;
                netw.type = NetworkVO.ODS_EXTRACTOR;

                listain.Add(netw);
            }

            return listain;
        }
        catch (Exception e)
        {
            Logging.WriteError(e.StackTrace.ToString());
            return null;
        }
    }

    public NetworkVO getDetails(int padre)
    {
        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

        NetworkVO network = new NetworkVO();
        EntityVO enti = new EntityVO();

        List<EntityVO> nodos = new List<EntityVO>();

        try
        {   
            enti = EntityExtractor.create(NetworkVO.ODS_EXTRACTOR).getDetails(padre);

            List<mapa_get_network_nodesResult> resultset = dbcon.mapa_get_network_nodes(2, padre).ToList();

            foreach (mapa_get_network_nodesResult res in resultset)
            {
                EntityVO nodo = new EntityVO();

                nodo.id = res.id_invitada.ToString();
                nodo.name = res.nombre;
                nodo.latitude = res.latitud;
                nodo.longitude = res.longitud;

                nodos.Add(nodo);
            }

            network.type = NetworkVO.ODS_EXTRACTOR;
        
            network.parent = enti;
            
            network.nodes = nodos;

            return network;
        }
        catch (Exception e)
        {
            Logging.WriteError(e.StackTrace.ToString());
            return null;
        }
    }

    #endregion
}
