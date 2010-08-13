<%@ WebService Language="C#" Class="Catalogs" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Collections.Generic;

[WebService(Namespace = "http://mapasvsl.com/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class Catalogs  : System.Web.Services.WebService {

    [WebMethod]
    public List<CataloValueVO> getCountries() 
    {
        try
        {
            
            VSLMapsTableAdapters.CountryTableAdapter adapter = new VSLMapsTableAdapters.CountryTableAdapter();
            VSLMaps.CountryDataTable table = adapter.GetData();

            List<CataloValueVO> results = new List<CataloValueVO>();
            foreach (VSLMaps.CountryRow row in table)
            {
                results.Add(getCatalogValueFromRow(row));
            }

            return results;
        
        }
        catch (Exception e)
        {
            Logging.WriteError(e.StackTrace.ToString());
            return null;
        }
    }

    [WebMethod]
    public List<CataloValueVO> getOrganizationTypes()
    {
        try
        {
            VSLMapsTableAdapters.OrganizationTypeTableAdapter adapter = new VSLMapsTableAdapters.OrganizationTypeTableAdapter();
            VSLMaps.OrganizationTypeDataTable table = adapter.GetData();

            List<CataloValueVO> results = new List<CataloValueVO>();
            foreach (VSLMaps.OrganizationTypeRow row in table)
            {
                results.Add(getCatalogValueFromRow(row));
            }

            return results;
        
        }
        catch (Exception e)
        {
            Logging.WriteError(e.StackTrace.ToString());
            return null;
        }
    }


    [WebMethod]
    public List<CataloValueVO> getEnfoqueGeograficoTypes()
    {
        try
        {
            VSLMapsTableAdapters.AlcanceTableAdapter adapter = new VSLMapsTableAdapters.AlcanceTableAdapter();
            VSLMaps.AlcanceDataTable table = adapter.GetData();

            List<CataloValueVO> results = new List<CataloValueVO>();
            foreach (VSLMaps.AlcanceRow row in table)
            {
                results.Add(getCatalogValueFromRow(row));
            }

            return results;
        
        }
        catch (Exception e)
        {
            Logging.WriteError(e.StackTrace.ToString());
            return null;
        }
        
    }


    [WebMethod]
    public List<CataloValueVO> getBeneficiaryTypes()
    {
        try
        {
            VSLMapsTableAdapters.BeneficiarioTableAdapter adapter = new VSLMapsTableAdapters.BeneficiarioTableAdapter();
            VSLMaps.BeneficiarioDataTable table = adapter.GetData();

            List<CataloValueVO> results = new List<CataloValueVO>();
            foreach (VSLMaps.BeneficiarioRow row in table)
            {
                results.Add(getCatalogValueFromRow(row));
            }

            return results;
        
        }
        catch (Exception e)
        {
            Logging.WriteError(e.StackTrace.ToString());
            return null;
        }
    }

    private CataloValueVO getCatalogValueFromRow(VSLMaps.CountryRow row)
    {
        CataloValueVO aux = new CataloValueVO();
        aux.value = row.nombre;
        aux.id = row.id_pais;

        return aux;
    }

    private CataloValueVO getCatalogValueFromRow(VSLMaps.OrganizationTypeRow row)
    {
        CataloValueVO aux = new CataloValueVO();
        aux.value = row.Nombre;
        aux.id = row.ID_TipoOrganizacion;

        return aux;
    }

    private CataloValueVO getCatalogValueFromRow(VSLMaps.AlcanceRow row)
    {
        CataloValueVO aux = new CataloValueVO();
        aux.value = row.Nombre;
        aux.id = row.ID;

        return aux;
    }


    private CataloValueVO getCatalogValueFromRow(VSLMaps.BeneficiarioRow row)
    {
        CataloValueVO aux = new CataloValueVO();
        aux.value = row.nombre;
        aux.id = row.id_beneficiario;

        return aux;
    }
    
}