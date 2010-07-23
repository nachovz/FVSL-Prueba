using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PDFExport
{
    /// <summary>
    /// Summary description for ODS
    /// </summary>
    public class ODSVO : EntityVO
    {
        public List<AwardVO> awards;
        public List<String> areas;
        public List<String> beneficiarios;
        public String enfoque;
        public String tipoOrganizacion;

        public ODSVO()
        {
            //
            // TODO: Add constructor logic here
            //
        }
    }
}