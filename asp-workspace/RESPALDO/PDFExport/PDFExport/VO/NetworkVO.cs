using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PDFExport
{
    /// <summary>
    /// Summary description for ODS
    /// </summary>
    public class NetworkVO
    {
        public List<EntityVO> nodes;
        public EntityVO parent;
        public String type;

        public NetworkVO()
        {
            //
            // TODO: Add constructor logic here
            //
        }
    }
}