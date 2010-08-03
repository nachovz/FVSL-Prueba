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

    public static String CATALOG_PREMIO { get { return "premios"; } }
    public static String CATALOG_PAIS { get { return "paises"; } }
    public static String CATALOG_BENEF { get { return "beneficiarios"; } }
    public static String CATALOG_TIPO_ORG { get { return "tipos"; } }
    public static String CATALOG_ENFOQ { get { return "enfoques"; } }
    public static String CATALOG_ESTADO { get { return "estados"; } }

	public CataloValueVO()
	{
		//
		// TODO: Add constructor logic here
		//
	}
}