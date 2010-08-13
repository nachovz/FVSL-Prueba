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
    public class EMPTemplate : BaseTemplate
    {
        private CompanyVO _emp;
        public EMPTemplate(CompanyVO emp)
        {
            this.Id = BaseTemplate.COMPANY_TEMPLATE;
            this._emp = emp;
        }

        public CompanyVO emp { get { return _emp; } }

        override public void setContent()
        {

            this.addTitle(37, 18, "Informacion de Empresa");
            this.addContentLine(37, 27, emp.name);
            this.addLeftContent(emp.objective);
            this.addRightContent(emp.direction, emp.website, emp.email, emp.facebook, emp.twitter);
            
            
        }

    }
}