using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using RedSocialComun;

namespace RedSocialEntity
{
    public class FechaInvalidaException : ValidacionExcepcionAbstract
    {
        public FechaInvalidaException() : base("La fecha de comienzo tiene que ser anterior a la fecha de fin.")
        {
        }
    }
}
