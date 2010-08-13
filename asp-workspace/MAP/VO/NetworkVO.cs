using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ODS
/// </summary>
public class NetworkVO
{
    public static String ODS_EXTRACTOR { get { return "ods"; } }
    public static String COOP_EXTRACTOR { get { return "cooperant"; } }
    public static String EMP_EXTRACTOR { get { return "company"; } }
    public static String ALL_EXTRACTOR { get { return "all"; } }

    public List<EntityVO> nodes;
    public EntityVO parent;
    public String type;

    public NetworkVO()
	{
		//
		// TODO: Add constructor logic here
		//
	}
}