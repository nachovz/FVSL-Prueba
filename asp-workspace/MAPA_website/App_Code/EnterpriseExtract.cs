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
/// Summary description for EnterpriseExtract
/// </summary>
public class EnterpriseExtract : IEntityExtractor
{
	public EnterpriseExtract()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public List<EntityVO> getAll()
    {
        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

        List<EntityVO> lista = new List<EntityVO>();

        List<MAPA_EMP_ALLResult> resultset = dbcon.MAPA_EMP_ALL().ToList();

        foreach (MAPA_EMP_ALLResult emp in resultset) {
            EntityVO EVO = new EntityVO();

            EVO.id = emp.Id.ToString();
            EVO.name = emp.Nombre;
            EVO.latitude = emp.Latitud.ToString();
            EVO.longitude = emp.Longitud.ToString();

            lista.Add(EVO);
        }

        return lista;
    }

    public EntityVO getDetails(int i)
    {
        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

        EnterpriseVO EMP = new EnterpriseVO();

        List<EMP_Empresa> resultset = dbcon.MAPA_EMP_DETAILS(i).ToList();

        if (resultset.Count == 1) {
            EMP = FEMP(resultset[0]);
        }

        return EMP;
    }

    private EnterpriseVO FEMP(EMP_Empresa empin)
    {
        EnterpriseVO aux = new EnterpriseVO();

        aux.id = empin.Id.ToString();
        aux.name = empin.Nombre;
        aux.latitude = empin.Latitud;
        aux.longitude = empin.Longitud;
        aux.direction = empin.Ciudad + ", " + empin.Urbanizacion + " " + empin.Calle;
        aux.website = empin.PaginaWeb;
        aux.facebook = empin.Facebook;
        aux.twitter = empin.Twitter;
        //aux.objective = empin.o;
        aux.email = empin.Correo;
        aux.type = "empresa";
        aux.beneficiarios = getEMPbeneficiario(empin.Id);
        aux.awards = getEMPaward(empin.Id);
        aux.areas = getEMParea(empin.Id);
        if (empin.Logo != null) aux.imgdata = empin.Logo.ToArray();

        return aux;
    }

    private List<string> getEMParea(int p)
    {
        throw new NotImplementedException();
    }

    private List<AwardVO> getEMPaward(int p)
    {
        List<AwardVO> lista = new List<AwardVO>();

        FVSL_LINQDataContext dbaux = new FVSL_LINQDataContext();

        List<MAPA_GET_AWAResult> awards = dbaux.MAPA_GET_AWA(p, 1).ToList();

        foreach (MAPA_GET_AWAResult awa in awards)
        {
            AwardVO AVO = new AwardVO();

            AVO.awardName = awa.nombre;
            AVO.recibido = awa.Otorgado;

            lista.Add(AVO);
        }

        return lista;
    }

    private List<String> getEMPbeneficiario(int p)
    {
        List<String> lista = new List<String>();

        FVSL_LINQDataContext dbcon = new FVSL_LINQDataContext();

        List<MAPA_GET_BENFResult> resultset = dbcon.MAPA_GET_BENF(p,1).ToList();

        foreach(MAPA_GET_BENFResult benef in resultset)
        {
            lista.Add(benef.Nombre);
        }

        return lista;

    }

    public List<EntityVO> getSearch(List<string> arr)
    {
        throw new NotImplementedException();
    }
}
