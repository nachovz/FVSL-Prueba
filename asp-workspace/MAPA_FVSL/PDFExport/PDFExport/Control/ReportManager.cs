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

        public void createReport(EntityVO entity, System.Web.UI.Page website, int type)
        {
            //String type = ods.GetType().ToString();
            BaseTemplate temp;
            switch (type)
            {
                case 1:
                    temp = new EMPTemplate((CompanyVO)entity);
                    temp.setContent();
                    temp.request(entity.name);
                    break;
                case 2:
                    temp = new ODSTemplate((ODSVO)entity);
                    temp.setContent();
                    temp.request(entity.name);
                    break;
                case 3:
                    temp = new COOPTemplate((CooperantVO)entity);
                    temp.setContent();
                    temp.request(entity.name);
                    break;
                

                    
            }
        }
    }
}