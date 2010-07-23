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
            ODSVO auxOds = new ODSVO();
            auxOds.name = "Fundacion Clamor en el Barrio";

            ReportManager.Instance.createReport(auxOds, this);
        }
    }
}