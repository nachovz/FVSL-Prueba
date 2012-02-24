using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MAP;
using System.Data.Linq;

public class ProyectoVO : EntityVO
{
    public String nombreODS;
    public decimal montoProyecto;
    public List<String> beneficiarios;
    public String estatus;
    public List<String> areaAtencion;
    public String tipoBeneficiario;
    public String convocatoria;
    public decimal montoAsignado;
    public String inversionistas;
    //public List<String> inversionistas;
    //public List<String> otrosFinancistas;
    public String organizacionCF;

    public ProyectoVO()
    {
    }

}
