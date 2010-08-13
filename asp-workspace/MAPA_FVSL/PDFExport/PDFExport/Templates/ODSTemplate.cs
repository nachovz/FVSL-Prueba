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
    public class ODSTemplate : BaseTemplate
    {
        private ODSVO _ods;
        public ODSTemplate(ODSVO ods)
        {
            this.Id = BaseTemplate.ODS_TEMPLATE;
            this._ods = ods;
        }

        public ODSVO ods { get { return _ods; } } 

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
            this.addContentLine(37, 27, ods.name);
            this.addLeftContent(ods.objective);
            this.addRightContent(ods.direction,ods.website,ods.email,ods.facebook,ods.twitter);
            this.addPremios2(60,27, ods.awards);
            this.newPage();
           // this.addAreas(60, 27, premios);
        }

    }
}