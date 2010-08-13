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
        private FontPropMM arialFont;
        FlowLayoutManager flm, flm2;

        public static String ODS_TEMPLATE { get { return "odstemplate"; } }
        public static String COOPERANT_TEMPLATE { get { return "cooperanttemplate"; } }
        public static String COMPANY_TEMPLATE { get { return "companytemplate"; } }
        public static String NETWORK_TEMPLATE { get { return "networktemplate"; } }

        public String Id
        {
            get { return _id; }
            set { _id = value; }
        }

        public Report report
        {
            get { return _report; }
            set { _report = value; }
        }

        public Root.Reports.Page page
        {
            get { return _page; }
            set { _page = value; }
        }

        public BaseTemplate()
        {
            report = new Report(new PdfFormatter());
            FontDef fd = new FontDef(report, "Helvetica");
            standardFont = new FontPropMM(fd, 5);
            page = new Root.Reports.Page(report);
            FontDef fss = new FontDef(report, "Arial");
            arialFont = new FontPropMM(fss, 6);
            flm = new FlowLayoutManager(null);
            flm2 = new FlowLayoutManager(null);
            flm.rContainerHeightMM = 120;
            flm2.rContainerHeightMM = 120;
            flm.rContainerWidthMM = 95;
            flm2.rContainerWidthMM = 95;
            flm.eNewContainer += new FlowLayoutManager.NewContainerEventHandler(LeftContainer);
            flm2.eNewContainer += new FlowLayoutManager.NewContainerEventHandler(RightContainer);
            setHeader();
            setFooter();
        }

        private void setHeader()
        {
            page.AddMM(0, 300, new RepImageMM("C:\\Documents and Settings\\Administrador\\Escritorio\\asp-workspace\\MAPA_FVSL\\PDFExport\\PDFExport\\Images\\imagen formato pdf(2).jpg", 210, 300));
            page.AddMM(105, 152, new RepImageMM("C:\\Documents and Settings\\Administrador\\Escritorio\\asp-workspace\\MAPA_FVSL\\PDFExport\\PDFExport\\Images\\linea.jpg", 0.05, 105));
        }

        public virtual void setContent()
        {

        }

        private void setFooter()
        {
            //page.AddMM(10, 30, new RepImageMM("C:\\wamp\\www\\vsl-maps\\asp-workspace\\PDFExport\\PDFExport\\Images\\vensinlim.jpg", 40, Double.NaN));
        }

        public void addContentLine(float x, float y, String text)
        {
            standardFont.color = System.Drawing.Color.DarkRed;
            standardFont.rSize = 8;
            standardFont.bBold = true;
            this.page.AddLT_MM(x, y, new RepString(standardFont, text));
        }

        public void addTitle(float x, float y, String text)
        {
            standardFont = new FontPropMM(new FontDef(report, "Times-Roman"), 5);
            standardFont.color = System.Drawing.Color.Black;
            standardFont.bBold = true;
            this.page.AddLT_MM(x, y, new RepString(standardFont, text));
        }

        public void addLeftContent(String text)
        {

            standardFont.rSize = 6;
            standardFont.bBold = false;
            standardFont.color = System.Drawing.Color.Black;
            standardFont.rLineFeedMM = 4;

            flm.Add(new RepString(standardFont, text));
            flm.NewLine(standardFont.rLineFeed * 0.4);

        }

        public void addRightContent(String direccion, String web, String correo, String facebook, String twitter)
        {
            standardFont.rSize = 6;
            standardFont.bBold = true;
            standardFont.color = System.Drawing.Color.Black;
            standardFont.rLineFeedMM = 4;
            flm2.Add(new RepString(standardFont, "Direccion: "));
            standardFont.bBold = false;
            flm2.Add(new RepString(standardFont, direccion));
            flm2.NewLine(standardFont.rLineFeed * 1.5);
            standardFont.bBold = true;
            flm2.Add(new RepString(standardFont, "Pagina Web: "));
            standardFont.bBold = false;
            flm2.Add(new RepString(standardFont, web));
            flm2.NewLine(standardFont.rLineFeed * 1.5);
            standardFont.bBold = true;
            flm2.Add(new RepString(standardFont, "Correo Electronico: "));
            standardFont.bBold = false;
            flm2.Add(new RepString(standardFont, correo));
            flm2.NewLine(standardFont.rLineFeed * 1.5);
            standardFont.bBold = true;
            flm2.Add(new RepString(standardFont, "Facebook: "));
            standardFont.bBold = false;
            flm2.Add(new RepString(standardFont, facebook));
            flm2.NewLine(standardFont.rLineFeed * 1.5);
            standardFont.bBold = true;
            flm2.Add(new RepString(standardFont, "Twitter: "));
            standardFont.bBold = false;
            flm2.Add(new RepString(standardFont, twitter));
            flm2.NewLine(standardFont.rLineFeed * 1.5);

        }

        public void addPremios(int x, int y, List<AwardVO> premios)
        {

            standardFont.rSize = 6;
            standardFont.bBold = true;
            standardFont.color = System.Drawing.Color.Black;
            standardFont.fontDef = new FontDef(report, FontDef.StandardFont.Helvetica);
            this.page.AddLT_MM(10, 155, new RepString(standardFont, "Premios Otorgados y Recibidos"));
            standardFont.color = System.Drawing.Color.White;

            page.AddMM(10, 165, new RepImageMM("C:\\Documents and Settings\\Administrador\\Escritorio\\asp-workspace\\MAPA_FVSL\\PDFExport\\PDFExport\\Images\\degradez.jpg", 110, 6));
            this.page.AddLT_MM(12, 161, new RepString(standardFont, "Premio"));

            standardFont.color = System.Drawing.Color.Black;
            int dy = 168, contador = 0;
            foreach (AwardVO premio in premios)
            {
                this.page.AddLT_MM(12, dy, new RepString(standardFont, premio.awardName));
                dy = dy + 9;
                contador++;

            }
            page.AddMM(10, 174 + (9 * (contador - 1)), new RepImageMM("C:\\Documents and Settings\\Administrador\\Escritorio\\asp-workspace\\MAPA_FVSL\\PDFExport\\PDFExport\\Images\\lineatabla.jpg", 0.05, 9 * contador));
            page.AddMM(80, 174 + (9 * (contador - 1)), new RepImageMM("C:\\Documents and Settings\\Administrador\\Escritorio\\asp-workspace\\MAPA_FVSL\\PDFExport\\PDFExport\\Images\\lineatabla1.jpg", 0.05, 9 * contador));
            page.AddMM(120, 174 + (9 * (contador - 1)), new RepImageMM("C:\\Documents and Settings\\Administrador\\Escritorio\\asp-workspace\\MAPA_FVSL\\PDFExport\\PDFExport\\Images\\lineatabla2.jpg", 0.05, 9 * contador));
            page.AddMM(10, 174 + (9 * (contador - 1)), new RepImageMM("C:\\Documents and Settings\\Administrador\\Escritorio\\asp-workspace\\MAPA_FVSL\\PDFExport\\PDFExport\\Images\\horizontal.jpg", 110, 0.01));
        }

        public void addPremios2(int x, int y, List<AwardVO> premios)
        {

            standardFont.rSize = 6;
            standardFont.bBold = true;
            standardFont.color = System.Drawing.Color.Black;
            this.page.AddLT_MM(10, 160, new RepString(standardFont, "Premios Otorgados y Recibidos:"));
            standardFont.color = System.Drawing.Color.White;

            page.AddMM(60, 165, new RepImageMM("C:\\Documents and Settings\\Administrador\\Escritorio\\asp-workspace\\MAPA_FVSL\\PDFExport\\PDFExport\\Images\\degradez.jpg", 110, 6));
            this.page.AddLT_MM(12 + 50, 161, new RepString(standardFont, "Premio"));

            standardFont.color = System.Drawing.Color.Black;
            int dy = 168, contador = 0;
            foreach (AwardVO premio in premios)
            {
                standardFont.bBold = false;
                this.page.AddLT_MM(12 + 50, dy, new RepString(standardFont, premio.awardName));
                standardFont.bBold = true;
                if (premio.recibido == false)
                {
                    this.page.AddLT_MM(93 + 50, dy, new RepString(standardFont, "Recibido"));
                }
                else {
                    this.page.AddLT_MM(93 + 50, dy, new RepString(standardFont, "Otorgado"));
                }
                dy = dy + 9;
                contador++;
            }
            page.AddMM(10 + 50, 174 + (9 * (contador - 1)), new RepImageMM("C:\\Documents and Settings\\Administrador\\Escritorio\\asp-workspace\\MAPA_FVSL\\PDFExport\\PDFExport\\Images\\lineatabla.jpg", 0.05, 9 * contador));
            page.AddMM(80 + 50, 174 + (9 * (contador - 1)), new RepImageMM("C:\\Documents and Settings\\Administrador\\Escritorio\\asp-workspace\\MAPA_FVSL\\PDFExport\\PDFExport\\Images\\lineatabla1.jpg", 0.05, 9 * contador));
            page.AddMM(120 + 50, 174 + (9 * (contador - 1)), new RepImageMM("C:\\Documents and Settings\\Administrador\\Escritorio\\asp-workspace\\MAPA_FVSL\\PDFExport\\PDFExport\\Images\\lineatabla2.jpg", 0.05, 9 * contador));
            page.AddMM(10 + 50, 174 + (9 * (contador - 1)), new RepImageMM("C:\\Documents and Settings\\Administrador\\Escritorio\\asp-workspace\\MAPA_FVSL\\PDFExport\\PDFExport\\Images\\horizontal.jpg", 110, 0.01));
        }

        public void addAreas(int x, int y, List<AreaVO> areas)
        {

            standardFont.rSize = 6;
            standardFont.bBold = true;
            standardFont.color = System.Drawing.Color.Black;
            this.page.AddLT_MM(10, 160+50, new RepString(standardFont, "Areas de Intervencion:"));
            standardFont.color = System.Drawing.Color.White;

            page.AddMM(60, 160 + 50, new RepImageMM("C:\\Documents and Settings\\Administrador\\Escritorio\\asp-workspace\\MAPA_FVSL\\PDFExport\\PDFExport\\Images\\horizontal1.jpg", 110, 0.05));
            this.page.AddLT_MM(12 + 50, 161, new RepString(standardFont, "Area"));

            standardFont.color = System.Drawing.Color.Black;
            int dy = 163+53, contador = 0;
            foreach (AreaVO area in areas)
            {
                if (area.subcategoria != null)
                {
                    this.page.AddLT_MM(12 + 50, dy, new RepString(standardFont, area.area + ", " + area.subcategoria));
                }
                else
                {
                    this.page.AddLT_MM(12 + 50, dy, new RepString(standardFont, area.area));
                }
                dy = dy + 7;
                contador++;
            }
            page.AddMM(10 + 50, 169 + 50 + (9 * (contador - 1)), new RepImageMM("C:\\Documents and Settings\\Administrador\\Escritorio\\asp-workspace\\MAPA_FVSL\\PDFExport\\PDFExport\\Images\\lineatablax.jpg", 0.05, 9 * contador));
            /////page.AddMM(80 + 50, 174 + 70 + (9 * (contador - 1)), new RepImageMM("D:\\WORK\\mapsvsl\\asp-workspace\\PDFExport\\PDFExport\\Images\\lineatabla1.jpg", 0.05, 9 * contador));
            page.AddMM(120 + 50, 169 + 50 + (9 * (contador - 1)), new RepImageMM("C:\\Documents and Settings\\Administrador\\Escritorio\\asp-workspace\\MAPA_FVSL\\PDFExport\\PDFExport\\Images\\lineatablax2.jpg", 0.05, 9 * contador));
            page.AddMM(10 + 50, 169 + 50 + (9 * (contador - 1)), new RepImageMM("C:\\Documents and Settings\\Administrador\\Escritorio\\asp-workspace\\MAPA_FVSL\\PDFExport\\PDFExport\\Images\\horizontal2.jpg", 110, 0.01));

        }

        public void newPage()
        {
            new Root.Reports.Page(report);

        }
        private void LeftContainer(Object oSender, FlowLayoutManager.NewContainerEventArgs ea)
        {
            this.page.AddMM(10, 50, ea.container);
        }

        private void RightContainer(Object oSender, FlowLayoutManager.NewContainerEventArgs ea)
        {
            this.page.AddMM(109, 50, ea.container);

        }

        public void request(String archivo)
        {
            RT.ViewPDF(report, archivo + ".pdf");
        }
    }
}
