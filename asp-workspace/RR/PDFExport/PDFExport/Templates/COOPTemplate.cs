using System;
using Root.Reports;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PDFExport.Templates;
using MAP;

namespace PDFExport
{
    public class COOPTemplate : BaseTemplate
    {
        private CooperantVO _coop;
        public COOPTemplate(CooperantVO coop)
        {
            this.Id = BaseTemplate.ODS_TEMPLATE;
            this._coop = coop;
        }

        public CooperantVO coop { get { return _coop; } }

        override public void setContent()
        {
            List<String> premios = new List<string>();
            premios.Add("Premio Super Gran Mariscal de Ayacucho");
            premios.Add("El Premio Gordo");
            premios.Add("Soy El Crack PDF");
            premios.Add("Premio Verde");
            premios.Add("El Premio Gordo");
            premios.Add("Soy El Crack PDF");
            premios.Add("Premio Super Gran Mariscal de Ayacucho");
            premios.Add("El Premio Gordo");
            premios.Add("Soy El Crack PDF");
            premios.Add("Premio Verde");
            premios.Add("El Premio Gordo");
            premios.Add("Soy El Crack PDF");
            //premios.Add("Premio Super Gran Mariscal de Ayacucho");
            //premios.Add("El Premio Gordo");
            //premios.Add("Soy El Crack PDF");
            //premios.Add("Premio Verde");
            //premios.Add("El Premio Gordo");
            //premios.Add("Soy El Crack PDF");
            this.addTitle(37, 18, "Informacion de ODS");
            this.addContentLine(37, 27, coop.name);
            this.addLeftContent("desarrolla una acción educativa y pastoral de solidaridad y prevención a favor de niños y adolescentes que viven en circunstancias especialmente difíciles debido a su exclusión social.");
            this.addRightContent("Merida, El rincon, Calle Principal, asdasdasdjkasd, asdjahsduahsda, asdouahsdikjuahsdiasd, asdouahsdiuahsdas, asoduhasdad", "www.fdbmerida.org", "fdbmerida@cantv.net", "No tiene cuenta de Facebook", "No tiene cuenta de Twitter");
            this.addPremios2(60, 27, premios);
            this.newPage();
            // this.addAreas(60, 27, premios);
        }

    }
}