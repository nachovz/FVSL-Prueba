using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Class1
/// </summary>
public class CooperantVO : EntityVO
{
    public List<AwardVO> awards;
    public List<AreaVO> areas;
    public List<String> beneficiarios;
    public String enfoque;
    public int financia;
    public String tipoOrganizacion;

    public CooperantVO()
	{
		//
		// TODO: Add constructor logic here
		//
	}
}