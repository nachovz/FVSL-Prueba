using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Root.Reports;

namespace PDFExport.Templates
{
    public class BaseTemplate
    {
        private String _id = "";
        private Report _report;
        private Root.Reports.Page _page;
        private FontPropMM standardFont;

        public static String ODS_TEMPLATE{ get { return "odstemplate"; } }
        public static String COOPERANT_TEMPLATE { get { return "cooperanttemplate"; } }
        public static String COMPANY_TEMPLATE { get { return "companytemplate"; } }
        public static String NETWORK_TEMPLATE { get { return "networktemplate"; } }

        public String Id
        { 
            get{ return _id; }
            set{ _id = value; } 
        }

        public Report report
        { 
            get{ return _report; }
            set{ _report = value; } 
        }

        public Root.Reports.Page page
        { 
            get{ return _page; }
            set{ _page = value; }
        }

        public BaseTemplate()
        {
            report = new Report(new PdfFormatter());
            FontDef fd = new FontDef(report, "Helvetica");
            standardFont = new FontPropMM(fd, 5);
            page = new Root.Reports.Page(report);
            setHeader();
            setFooter();
        }

        private void setHeader()
        {
            page.AddMM(10, 30, new RepImageMM("C:\\wamp\\www\\vsl-maps\\asp-workspace\\PDFExport\\PDFExport\\Images\\vensinlim.jpg", 40, Double.NaN));
        }

        public virtual void setContent()
        {
            
        }

        private void setFooter()
        {
            //page.AddMM(10, 30, new RepImageMM("C:\\wamp\\www\\vsl-maps\\asp-workspace\\PDFExport\\PDFExport\\Images\\vensinlim.jpg", 40, Double.NaN));
        }

        public void addContentLine(float x,float y, String text)
        {
            this.page.AddLT_MM(x, y, new RepString(standardFont, text));
        }

        public void request(System.Web.UI.Page web)
        {
            RT.ResponsePDF(report, web);   
        }
    }
}
