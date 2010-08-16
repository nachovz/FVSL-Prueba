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
/// Summary description for NetworkALLextract
/// </summary>
public class NetworkALLextract : INetworkExtractor
{

    #region INetworkExtractor Members

    public List<NetworkVO> getN()
    {
        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

        List<NetworkVO> lista = new List<NetworkVO>();

        try
        {
            //EMPRESAS//
            List<mapa_get_network_compResult> resultset = dbcon.mapa_get_network_comp().ToList();

            foreach (mapa_get_network_compResult net in resultset)
            {
                EntityVO ent = new EntityVO();

                ent.type = 1;
                ent.id = net.Id.ToString();
                ent.name = net.Nombre;
                ent.latitude = net.Latitud.ToString();
                ent.longitude = net.Longitud.ToString();

                NetworkVO netw = new NetworkVO();

                //netw.parent.type = NetworkVO.EMP_EXTRACTOR;
                netw.parent = ent;
                //netw.type = NetworkVO.EMP_EXTRACTOR;

                lista.Add(netw);
            }
            //ODS//
            List<mapa_get_network_odsResult> resultset1 = dbcon.mapa_get_network_ods().ToList();

            foreach (mapa_get_network_odsResult net1 in resultset1)
            {
                NetworkVO netw1 = new NetworkVO();
                EntityVO ent1 = new EntityVO();

                ent1.id = net1.id_ods.ToString();
                ent1.name = net1.nombre;
                ent1.latitude = net1.Latitud.ToString();
                ent1.longitude = net1.Longitud.ToString();
                ent1.type = NetworkVO.ODS_EXTRACTOR;
                netw1.parent = ent1;
                netw1.type = NetworkVO.ODS_EXTRACTOR;

                lista.Add(netw1);
            }
            //COOPERANTES//
            List<mapa_get_network_coopResult> resultset2 = dbcon.mapa_get_network_coop().ToList();

            foreach (mapa_get_network_coopResult net2 in resultset2)
            {
                NetworkVO netw2 = new NetworkVO();
                EntityVO ent2 = new EntityVO();

                ent2.id = net2.id_coperante.ToString();
                ent2.name = net2.nombre;
                ent2.latitude = net2.Latitud.ToString();
                ent2.longitude = net2.Longitud.ToString();
                ent2.type = NetworkVO.COOP_EXTRACTOR;
                netw2.parent = ent2;
                netw2.type = NetworkVO.COOP_EXTRACTOR;

                lista.Add(netw2);
            }

            return lista;

        }
        catch (Exception e)
        {
            Logging.WriteError(e.StackTrace.ToString());
            return null;
        }
    }

    public List<NetworkVO> getSearch(List<String> listain)
    {
        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

        List<NetworkVO> lista = new List<NetworkVO>();

        try
        {

            //EMPRESAS//
            List<mapa_search_network_ods_byResult> resultset = dbcon.mapa_search_network_ods_by(int.Parse(listain[0]), int.Parse(listain[1]), listain[2]).ToList();

            foreach (mapa_search_network_ods_byResult net in resultset)
            {
                NetworkVO netw = new NetworkVO();
                EntityVO ent = new EntityVO();

                ent.id = net.id_anfitriona.ToString();
                ent.name = net.nombre;
                ent.latitude = net.latitud.ToString();
                ent.longitude = net.longitud.ToString();
                ent.type = NetworkVO.EMP_EXTRACTOR;
                netw.parent = ent;
                netw.type = NetworkVO.ODS_EXTRACTOR;

                lista.Add(netw);
            }
            //ODS//
            List<mapa_search_network_emp_byResult> resultset1 = dbcon.mapa_search_network_emp_by(int.Parse(listain[0]), int.Parse(listain[1]), listain[2]).ToList();

            foreach (mapa_search_network_emp_byResult net1 in resultset1)
            {
                NetworkVO netw1 = new NetworkVO();
                EntityVO ent1 = new EntityVO();

                ent1.id = net1.id_anfitriona.ToString();
                ent1.name = net1.nombre;
                ent1.latitude = net1.latitud.ToString();
                ent1.longitude = net1.longitud.ToString();
                ent1.type = NetworkVO.ODS_EXTRACTOR;
                netw1.parent = ent1;
                netw1.type = NetworkVO.EMP_EXTRACTOR;

                lista.Add(netw1);
            }
            //COOPERANTES//
            List<mapa_search_network_cooperantes_byResult> resultset2 = dbcon.mapa_search_network_cooperantes_by(int.Parse(listain[0]),int.Parse(listain[1]), listain[2]).ToList();/*int.Parse(listain[1]),*/

            foreach (mapa_search_network_cooperantes_byResult net2 in resultset2)
            {
                NetworkVO netw2 = new NetworkVO();
                EntityVO ent2 = new EntityVO();

                ent2.id = net2.id_anfitriona.ToString();
                ent2.name = net2.nombre;
                ent2.latitude = net2.latitud.ToString();
                ent2.longitude = net2.longitud.ToString();
                ent2.type = NetworkVO.COOP_EXTRACTOR;
                netw2.parent = ent2;
                netw2.type = NetworkVO.COOP_EXTRACTOR;

                lista.Add(netw2);
            }

            return lista;

        }
        catch (Exception e)
        {
            Logging.WriteError(e.StackTrace.ToString());
            return null;
        }
    }

    public NetworkVO getDetails(int padre)
    {
        throw new NotImplementedException();
    }

    #endregion
}
