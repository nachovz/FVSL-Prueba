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
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
            switch (Request.QueryString["type"])
            {
                case "company": 
                    CompanyVO auxEmp = new CompanyVO();
                    auxEmp = (CompanyVO)EntityExtractor.create(EntityExtractor.EMP_EXTRACTOR).getDetails(int.Parse(Request.QueryString["id"]));
                    ReportManager.Instance.createReport(auxEmp, this, 1);
                    break;


                case "ods":
                    ODSVO auxOds = new ODSVO();
                    auxOds = (ODSVO)EntityExtractor.create(EntityExtractor.ODS_EXTRACTOR).getDetails(int.Parse(Request.QueryString["id"]));
                    ReportManager.Instance.createReport(auxOds, this, 2);
                    break;

                case "cooperant":
                    CooperantVO auxCoop = new  CooperantVO();
                    auxCoop = (CooperantVO)EntityExtractor.create(EntityExtractor.COOP_EXTRACTOR).getDetails(int.Parse(Request.QueryString["id"]));
                    ReportManager.Instance.createReport(auxCoop, this, 3);
                    break;
    
            }
            
        }
    }
}