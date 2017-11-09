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
                tarea.ValidarDatos();

                if (daTarea.HayDisponibilidad(tarea.HoraComienzo, tarea.HoraFin))
                    throw new FechaOcupadaExcepcionBO();

                daTarea.Insertar(tarea);
            }
            catch (ExcepcionDA ex)
            {
                throw new ExcepcionBO("No se pudo realizar la registración de la tarea.", ex);
            }
        }

        public void ActualizarTarea(TareaEntity tarea)
        {
            try
            {
                daTarea.Actualizar(tarea);
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
            , DateTime? horaComienzo = null
            , DateTime? horaFin = null
            , String lugar = null)
        {
            try
            {
                //return daTarea.ListarTareas(dia, usuarioId);
                return daTarea.ListarTareas(UsuarioId: UsuarioId, horaComienzo: horaComienzo);
                //daTarea.ListarTareas(usuarioId, fechaDesde: DateTime.Now.AddDays(-30));
            }
            catch (ExcepcionBO ex)
            {
                throw new ExcepcionBO("No se pudo listar ninguna Tarea.", ex);
            }
        }
    }
}
