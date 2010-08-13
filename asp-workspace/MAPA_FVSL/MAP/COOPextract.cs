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
using System.Data.Linq;

    /// <summary>
    /// Summary description for COOPextract
    /// </summary>
    public class COOPextract : IEntityExtractor
    {
        public COOPextract()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public EntityVO getDetails(int incoop)
        {
            FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();                //Create LINQ-SQL connection

            CooperantVO result = new CooperantVO();

            try
            {
                List<tb_Coperante> resultset = dbcon.MAPA_COOP_DETAILS(incoop).ToList() ;

                if (resultset.Count == 1)                                      //Start reading Resulset list, and adding to Result
                {
                     result = FCOOP(resultset[0]);

                }

                return (EntityVO)result;
            }
            catch (Exception e)
            {
                Logging.WriteError(e.StackTrace.ToString());
                return null;
            }
        }

        public List<EntityVO> getSearch(List<String> datos)
        {
            FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

            List<EntityVO> lista = new List<EntityVO>();
            //0int idpais, 1int idestado, 2string nombre, 3string area, 4string premios, 5int tiporg, 6int fat, 7Int enfoq

            //@idPais int, @idEstado int, @nombre varchar(8000), @tipoOrg int, @fat int, @area_intervencion varchar(8000), @enfoque_geografico int, @premios varchar(8000)
            try
            {

                ISingleResult<dynamicLINQC> resultset = dbcon.MAPA_SEARCH_COOP_BY(int.Parse(datos[0]), int.Parse(datos[1]), datos[2], int.Parse(datos[5]), int.Parse(datos[6]), datos[3], int.Parse(datos[7]), datos[4]);

                foreach (dynamicLINQC dyn in resultset)
                {
                    EntityVO EVO = new EntityVO();

                    EVO.id = dyn.id_coperante.ToString();
                    EVO.name = dyn.nombre;
                    EVO.latitude = dyn.Latitud;
                    EVO.longitude = dyn.Longitud;

                    lista.Add(EVO);
                }

                return lista;
            }
            catch (Exception e)
            {
                Logging.WriteError(e.StackTrace.ToString());
                return null;
            }
        }

        public List<EntityVO> getAll()
        {
            FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

            List<EntityVO> lista = new List<EntityVO>();

            try
            {

                List<MAPA_COOP_ALLResult> resultset = dbcon.MAPA_COOP_ALL().ToList();

                foreach (MAPA_COOP_ALLResult coopa in resultset)
                {
                    EntityVO EVO = new EntityVO();

                    EVO.id = coopa.id_coperante.ToString();
                    EVO.name = coopa.nombre;
                    EVO.latitude = coopa.Latitud;
                    EVO.longitude = coopa.Longitud;

                    lista.Add(EVO);
                }

                return lista;
            }
            catch (Exception e)
            {
                Logging.WriteError(e.StackTrace.ToString());
                return null;
            }
        }

        private CooperantVO FCOOP(tb_Coperante coopin)
        {
            CooperantVO aux = new CooperantVO();

            aux.id = coopin.id_coperante.ToString();
            aux.name = coopin.nombre;
            aux.latitude = coopin.Latitud;
            aux.longitude = coopin.Longitud;
            aux.direction = coopin.ciudad + ", " + coopin.urbanizacion + " " + coopin.calle;
            aux.website = coopin.pagina_web;
            aux.facebook = coopin.Facebook;
            aux.twitter = coopin.Twitter;
            aux.objective = coopin.objetivos;
            aux.email = coopin.email;
            aux.type = "cooperante";
            aux.beneficiarios = getCOOPbeneficiario(coopin.id_coperante);
            aux.awards = getCOOPaward(coopin.id_coperante);
            aux.areas = getCOOParea(coopin.id_coperante);
            if (coopin.Logo != null) aux.imgdata = coopin.Logo.ToArray();
            //if (coopin.Logo.ToArray().Equals(null)) aux.imgdata = coopin.Logo.ToArray();
            aux.enfoque = coopin.EnfoqueGeografico.ToString();
            aux.tipoOrganizacion = coopin.tipo_organizacion.ToString();

            return aux;
        }

        private List<String> getCOOPbeneficiario(int coopin)
        {
            List<String> lista = new List<String>();

            FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

            try
            {

                List<MAPA_GET_BENFResult> benef = dbcon.MAPA_GET_BENF(coopin, 3).ToList();

                foreach (MAPA_GET_BENFResult ben in benef)
                {
                    lista.Add(ben.Nombre);
                }

                return lista;
            }
            catch (Exception e)
            {
                Logging.WriteError(e.StackTrace.ToString());
                return null;
            }
        }
        private List<AwardVO> getCOOPaward(int id)                                   //getcoopward receive (id_ods) Return List of Award
        {
            List<AwardVO> lista = new List<AwardVO>();

            FVSL_LINQDataContext dbaux = new FVSL_LINQDataContext();

            try
            {

                List<MAPA_GET_AWAResult> awards = dbaux.MAPA_GET_AWA(id, 3).ToList();

                foreach (MAPA_GET_AWAResult awa in awards)
                {
                    AwardVO AVO = new AwardVO();

                    AVO.awardName = awa.nombre;
                    AVO.recibido = awa.Otorgado;

                    lista.Add(AVO);
                }

                return lista;
            }
            catch (Exception e)
            {
                Logging.WriteError(e.StackTrace.ToString());
                return null;
            }
        }
        private List<String> getCOOParea(int id)                                     //getcooprea receive (id_ods) Return List of Areas
        {
            List<String> lista = new List<String>();

            FVSL_LINQDataContext dbaux = new FVSL_LINQDataContext();

            try
            {

                List<MAPA_GET_AREAResult> areas = dbaux.MAPA_GET_AREA(3,id).ToList();

                foreach (MAPA_GET_AREAResult are in areas)
                {
                    lista.Add(are.Nombre);
                }

                return lista;
            }
            catch (Exception e)
            {
                Logging.WriteError(e.StackTrace.ToString());
                return null;
            }
        }
    }

