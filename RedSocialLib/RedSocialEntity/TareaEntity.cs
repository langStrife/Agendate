using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RedSocialEntity
{
    public class TareaEntity
    {
        public TareaEntity()
        {
            Id = 0;
            UsuarioId = 0;
            Nombre = "";
            Descripcion = null;
            HoraComienzo = DateTime.MinValue;
            HoraFin = DateTime.MinValue;
            Lugar = "";
        }

        public int Id { get; set; }
        public int UsuarioId { get; set; }
        public String Nombre { get; set; }
        public String Descripcion { get; set; }
        public DateTime HoraComienzo { get; set; }
        public DateTime HoraFin { get; set; }
        public String Lugar { get; set; }

        public void ValidarDatos()
        {
            if (Nombre.Trim() == "" ||
                HoraComienzo == DateTime.MinValue ||
                HoraFin == DateTime.MinValue)
            {
                throw new DatosObligatoriosExcepcion();
            }
        }
    }
}
