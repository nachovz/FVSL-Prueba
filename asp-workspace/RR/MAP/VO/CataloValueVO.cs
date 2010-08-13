using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CataloValueVO
/// </summary>
public class CataloValueVO
{
    public int id;
    public String value;

    public static String CATALOG_PREMIO { get { return "awards"; } }
    public static String CATALOG_PAIS { get { return "countries"; } }
    public static String CATALOG_BENEF { get { return "beneficiaries"; } }
    public static String CATALOG_TIPO_ORG { get { return "types"; } }
    public static String CATALOG_ENFOQ { get { return "approaches"; } }
    public static String CATALOG_ESTADO { get { return "states"; } }
    public static String CATALOG_AREA { get { return "areas"; } }

	public CataloValueVO()
	{
		//
		// TODO: Add constructor logic here
		//
	}
}