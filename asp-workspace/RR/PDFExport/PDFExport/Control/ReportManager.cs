using System;
using Root.Reports;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PDFExport.Templates;

namespace PDFExport
{
    public sealed class ReportManager
    {
        static ReportManager instance = null;
        static readonly object padlock = new object();

        public ReportManager(){}

        public static ReportManager Instance
        {
            get
            {
                lock (padlock)
                {
                    if (instance == null)
                    {
                        instance = new ReportManager();
                    }
                    return instance;
                }
            }
        }

        public void createReport(EntityVO ods, System.Web.UI.Page website)
        {
            String type = ods.GetType().ToString();
            switch (type)
            {
                case "ODSVO":
                    BaseTemplate temp = new ODSTemplate((ODSVO)ods);
                    temp.setContent();
                    temp.request(ods.name);
                    break;
            }
        }
    }
}