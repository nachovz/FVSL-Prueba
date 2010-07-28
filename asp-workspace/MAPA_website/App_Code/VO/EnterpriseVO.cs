using System;
using System.Linq;
using System.Web;
using System.Collections.Generic;

/// <summary>
/// Summary description for EnterpriseVO
/// </summary>
public class EnterpriseVO : EntityVO
{
    public List<AwardVO> awards;
    public List<String> areas;
    public List<String> beneficiarios;
    public String enfoque;
    public String tipoOrganizacion;

	public EnterpriseVO()
	{
		//
		// TODO: Add constructor logic here
		//
	}
}
