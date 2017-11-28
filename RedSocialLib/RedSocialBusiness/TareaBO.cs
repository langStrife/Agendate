using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RedSocialEntity;
using RedSocialData;
using RedSocialDataSQLServer;

namespace RedSocialBusiness
{
    public class TareaBO
    {
        private TareaDA daTarea;

        public TareaBO()
        {
            daTarea = new TareaDA();
        }

        public void AgendarTarea(TareaEntity tarea)
        {
            try
            {

                if (daTarea.HayDisponibilidad(tarea))
                {
                    daTarea.Insertar(tarea);
                }
            }
            catch (ExcepcionBO ex)
            {
                throw new ExcepcionBO("No se pudo realizar la registración de la tarea.", ex);
            }
         }

        public void ActualizarTarea(TareaEntity tarea)
        {
            try
            {
                if (daTarea.HayDisponibilidad(tarea))
                {
                    daTarea.Actualizar(tarea);
                }
            }
            catch (ExcepcionBO ex)
            {
                throw new ExcepcionBO("No se pudo actualizar la Tarea.", ex);
            }
        }

        public void BorrarTarea(TareaEntity tarea)
        {
            try
            {
                daTarea.Borrar(tarea);
            }
            catch (ExcepcionBO ex)
            {
                throw new ExcepcionBO("No se pudo borrar la Tarea.", ex);
            }
        }
        public List<TareaEntity> ListarTareas (int UsuarioId
            , int? Id = null
            , String nombre = null
            , String descripcion = null
            , DateTime? fechaHoraComienzo = null
            , DateTime? fechaHoraFin = null
            , String lugar = null)
        {
            try
            {
                return daTarea.ListarTareas(UsuarioId: UsuarioId, fechaHoraComienzo: fechaHoraComienzo);
            }
            catch (ExcepcionBO ex)
            {
                throw new ExcepcionBO("No se pudo listar ninguna Tarea.", ex);
            }
        }
    }
}
