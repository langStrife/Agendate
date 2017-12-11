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

        public string AgendarTarea(TareaEntity tarea)
        {
            string mensaje = "";
            try
            {
                tarea.ValidarDatos();

                if (daTarea.HayDisponibilidad(tarea))
                {
                    daTarea.Insertar(tarea);
                    mensaje = "Se agendó correctamente la tarea!!";
                } else
                {
                    mensaje = "No se puede agendar la tarea. Hay otra tarea en ese horario.";
                }
            }
            catch (ExcepcionBO ex)
            {
                throw new ExcepcionBO("No se pudo agendar la tarea.", ex);
            }
            return mensaje;
         }

        public string ActualizarTarea(TareaEntity tarea)
        {
            string mensaje = "";
            try
            {
                tarea.ValidarDatos();

                if (daTarea.HayDisponibilidad(tarea))
                {
                    daTarea.Actualizar(tarea);
                    mensaje = "Se actualizó correctamente la tarea!!";
                }
                else
                {
                    mensaje = "No se puede actualizar la tarea. Hay otra tarea en ese horario.";
                }
            }
            catch (ExcepcionBO ex)
            {
                throw new ExcepcionBO("No se pudo actualizar la Tarea.", ex);
            }
            return mensaje;
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