using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PDFExport
{
    /// <summary>
    /// Summary description for EntityVO
    /// </summary>
    public class EntityVO
    {
        public String type = "";
        public String name = "";
        public String id = "";
        public String latitude = "";
        public String longitude = "";
        public String objective = "";
        public String direction = "";
        public String twitter = "";
        public String facebook = "";
        public String phone = "";
        public String website = "";
        public String email = "";
        public byte[] imgdata;

        public EntityVO()
        {
            //
            // TODO: Add constructor logic here
            //
        }
    }
}