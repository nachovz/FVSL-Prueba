using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MAP;
using System.Data.Linq;

public class ProyectoExtract: IEntityExtractor
{
    public ProyectoExtract() 
    { 
    
    }

    public List<EntityVO> getAll()
    {
        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

        List<EntityVO> lista = new List<EntityVO>();

        try 
        {
            List<MAPA_GET_Proyecto_ALLResult> resulset = dbcon.MAPA_GET_Proyecto_ALL().ToList();

            foreach (MAPA_GET_Proyecto_ALLResult proyectos in resulset)
            {
                EntityVO EVO = new EntityVO();

                EVO.id = proyectos.Id.ToString();
                EVO.name = proyectos.Nombre;
                EVO.latitude = proyectos.latitud;
                EVO.longitude = proyectos.longitud;

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

    //public List<ODSVO> getODSD(int inods)                                       //getODSD receive (id_ods) Return List of ODSVO
    public EntityVO getDetails(int inproy)
    {
        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();                //Create LINQ-SQL connection

        ProyectoVO result = new ProyectoVO();

        try
        {

            List<MAPA_GET_ProyectoResult> resultset = dbcon.MAPA_GET_Proyecto(inproy).ToList();

            if (resultset.Count == 1)
            {
                result = FPRO(resultset[0]);
            }

            return (EntityVO)result;
        }
        catch (Exception e)
        {
            Logging.WriteError(e.StackTrace.ToString());
            return null;
        }
    }

    public List<EntityVO> getSearch(List<String> datos)                           //getSearch in:List<String> (int idpais, int idestado, string nombre, string area, string premios)
    {
        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

        List<EntityVO> lista = new List<EntityVO>();

        try
        {

            ISingleResult<dynamicLINQ> resultset = dbcon.MAPA_SEARCH_ODS_BY(int.Parse(datos[0]), int.Parse(datos[1]), datos[2], datos[3], datos[4]);

            foreach (dynamicLINQ dyn in resultset)
            {
                EntityVO EVO = new EntityVO();

                EVO.id = dyn.id_ods.ToString();
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

    private ProyectoVO FPRO(MAPA_GET_ProyectoResult proin)                                           //FODS receive (ODS_ODS) Return ODSVO object (full)
    {
        ProyectoVO aux = new ProyectoVO();

        aux.id = proin.Id.ToString();
        aux.name = proin.Nombre;
        aux.email = proin.Correo;
        aux.type = NetworkVO.PRO_EXTRACTOR;
        aux.beneficiarios = getBeneficiario(proin.Id);
        aux.nombreODS = proin.Institucion;
        aux.montoProyecto = proin.MontoSolicitado;
        aux.estatus = proin.Estatus;
        aux.areaAtencion = getAreaAtencion(proin.Id);
        aux.convocatoria = getConvocatoria(proin.Id);
        aux.montoAsignado = (decimal)proin.MontoAsignado;
        aux.organizacionCF = proin.OrganizacionCF;
        aux.inversionistas = proin.OrganizacionCF;//getInversionistas(proin.Id);

        return aux;

    }

    /*private List<string> getInversionistas(int p)
    {
        
    }*/

    private String getConvocatoria(int p)
    {

        FVSL_LINQDataContext dbaux = new FVSL_LINQDataContext();

        try
        {
            ISingleResult<MAPA_GET_Proyecto_ConvocatoriaResult> conv = dbaux.MAPA_GET_Proyecto_Convocatoria(p);

            return conv.First().Nombre;
            //conv.Single(MAPA_GET_Proyecto_ConvocatoriaResult => MAPA_GET_Proyecto_ConvocatoriaResult.Nombre == search);
        }
        catch (Exception e)
        {
            Logging.WriteError(e.StackTrace.ToString());
            return null;
        }
    }

    private List<String> getAreaAtencion(int p)
    {
        List<String> lista = new List<String>();
        FVSL_LINQDataContext dbaux = new FVSL_LINQDataContext();

        try
        {
            List<MAPA_GET_Proyecto_AreaAtencionResult> areas = dbaux.MAPA_GET_Proyecto_AreaAtencion(p).ToList();

            foreach (MAPA_GET_Proyecto_AreaAtencionResult area in areas)
            {
                lista.Add(area.AreaAtencion);
            }

            return lista;
        }
        catch (Exception e)
        {
            Logging.WriteError(e.StackTrace.ToString());
            return null;
        }
    }

    private List<String> getBeneficiario(int id)                             //getODSbeneficiario receive (id_ods) Return List of Beneficiarion
    {
        List<String> lista = new List<String>();
        FVSL_LINQDataContext dbaux = new FVSL_LINQDataContext();

        try
        {

            List<MAPA_GET_BENFResult> benefs = dbaux.MAPA_GET_BENF(id, 2).ToList();

            foreach (MAPA_GET_BENFResult ben in benefs)
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
}
