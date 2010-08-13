using Root.Reports;
using System;

// Creation date: 10.05.2002
// Checked: 12.12.2002
// Author: Otto Mayer, mot@root.ch
// Version 1.01.00

// copyright (C) 2002 root-software ag  -  Bürglen Switzerland  -  www.root.ch; Otto Mayer, Stefan Spirig, Roger Gartenmann
// This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License
// as published by the Free Software Foundation, version 2.1 of the License.
// This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details. You
// should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA www.opensource.org/licenses/lgpl-license.html

namespace ReportSamples
{
    /// <summary>Hello World (PDF Version)</summary>
    class HelloWorld
    {
        //----------------------------------------------------------------------------------------------------x
        /// <summary>Starts the "Hello World" sample.</summary>
        public static void Main()
        {
            Report report = new Report(new PdfFormatter());
            FontDef fd = new FontDef(report, "Helvetica");
            FontProp fp = new FontPropMM(fd, 25);
            Page page = new Page(report);
            page.AddCenteredMM(80, new RepString(fp, "Hello World!"));
            RT.ViewPDF(report, "HelloWorld.pdf");
        }

    }
}