using System;
using System.Linq;
using System.Web;
using System.Collections.Generic;

/// <summary>
/// Summary description for EnterpriseVO
/// </summary>
public class CompanyVO : EntityVO
{
    public List<AwardVO> awards;
    public List<AreaVO> areas;
    public List<String> beneficiarios;
    public String enfoque;
    public String tipoOrganizacion;

	public CompanyVO()
	{
		//
		// TODO: Add constructor logic here
		//
	}
}
