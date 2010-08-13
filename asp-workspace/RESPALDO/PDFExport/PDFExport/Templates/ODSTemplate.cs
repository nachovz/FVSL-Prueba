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
            this.addContentLine(20, 30, ods.name);
        }

    }
}