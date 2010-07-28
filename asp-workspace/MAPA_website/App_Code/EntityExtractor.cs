﻿using System;
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

/// <summary>
/// Summary description for AEntityExtractor
/// </summary>
public class EntityExtractor
{
    public static String ODS_EXTRACTOR { get{return "ods";} }
    public static String COOP_EXTRACTOR { get { return "cooperant"; } }

    public static IEntityExtractor create(String type) 
    {
        if (type == ODS_EXTRACTOR)
        {
            return new ODSextract();
        }
        else if (type == COOP_EXTRACTOR) {
            return new COOPextract();
        }
        return null;
    }
}
