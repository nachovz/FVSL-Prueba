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
            this.Id = BaseTemplate.COOPERANT_TEMPLATE;
            this._coop = coop;
        }

        public CooperantVO coop { get { return _coop; } }

        override public void setContent()
        {
            this.addTitle(37, 18, "Informacion de Cooperante");
            this.addContentLine(37, 27, coop.name);
            this.addLeftContent(coop.objective);
            this.addRightContent(coop.direction, coop.website, coop.email, coop.facebook, coop.twitter);
            if (coop.awards.Count != 0)
            {
                this.addPremios2(60, 27, coop.awards);
            }
            if (coop.areas.Count != 0)
            {
                this.addAreas(60, 27, coop.areas);
            }
        }

    }
}