using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using System.IO;
using RedSocialEntity;
using RedSocialData;

namespace RedSocialDataSQLServer
{
    public class TareaDA
    {
        public TareaDA()
        {
        }

        #region Métodos Privados
        private TareaEntity CrearTarea(SqlDataReader cursor)
        {
            TareaEntity tarea = new TareaEntity();
            tarea.Id = cursor.GetInt32(cursor.GetOrdinal("ID"));
            tarea.UsuarioId = cursor.GetInt32(cursor.GetOrdinal("UsuarioID"));
            tarea.Nombre = cursor.GetString(cursor.GetOrdinal("Nombre"));
            tarea.Descripcion = cursor.GetString(cursor.GetOrdinal("Descripcion"));
            tarea.HoraComienzo = cursor.GetDateTime(cursor.GetOrdinal("HoraComienzo"));
            tarea.HoraFin = cursor.GetDateTime(cursor.GetOrdinal("HoraFin"));
            tarea.Lugar = cursor.GetString(cursor.GetOrdinal("Lugar"));

            return tarea;
        }
        #endregion Métodos Privados

        #region Métodos Públicos
        public void Insertar(TareaEntity tarea)
        {
            try
            {
                using (SqlConnection conexion = ConexionDA.ObtenerConexion())
                {
                    using (SqlCommand comando = new SqlCommand("TareaInsert", conexion))
                    {
                        comando.CommandType = CommandType.StoredProcedure;
                        SqlCommandBuilder.DeriveParameters(comando);

                        comando.Parameters["@UsuarioID"].Value = tarea.UsuarioId;
                        comando.Parameters["@Nombre"].Value = tarea.Nombre;
                        comando.Parameters["@Descripcion"].Value = tarea.Descripcion;
                        comando.Parameters["@HoraComienzo"].Value = tarea.HoraComienzo;
                        comando.Parameters["@HoraFin"].Value = tarea.HoraFin;
                        comando.Parameters["@Lugar"].Value = tarea.Lugar;
                        comando.ExecuteNonQuery();
                        tarea.Id = Convert.ToInt32(comando.Parameters["@RETURN_VALUE"].Value);

                        //if (tarea.Descripcion == null)
                        //    comando.Parameters["@Descripcion"].Value = DBNull.Value;
                        //else
                        //{
                        //    var parametroDescripcion = new SqlParameter("@Descripcion", SqlDbType.NVarChar);
                        //    parametroDescripcion.Value = tarea.Descripcion;
                        //    comando.Parameters.Add(parametroDescripcion);
                        //}
                        //if (tarea.Lugar == null)
                        //    comando.Parameters["@Lugar"].Value = DBNull.Value;
                        //else
                        //{
                        //    var parametroLugar = new SqlParameter("@Lugar", SqlDbType.NVarChar);
                        //    parametroLugar.Value = tarea.Lugar;
                        //    comando.Parameters.Add(parametroLugar);
                        //}
                    }

                    conexion.Close();
                }
            }
            catch (Exception ex)
            {
                throw new ExcepcionDA("Se produjo un error al insertar la tarea.", ex);
            }
        }

        public void Actualizar(TareaEntity tarea)
        {
            try
            {
                using (SqlConnection conexion = ConexionDA.ObtenerConexion())
                {
                    using (SqlCommand comando = new SqlCommand("TareaUpdate", conexion))
                    {
                        comando.CommandType = CommandType.StoredProcedure;
                        SqlCommandBuilder.DeriveParameters(comando);

                        comando.Parameters["@ID"].Value = tarea.Id;
                        comando.Parameters["@Nombre"].Value = tarea.Nombre;
                        comando.Parameters["@Descripcion"].Value = tarea.Descripcion;
                        comando.Parameters["@HoraComienzo"].Value = tarea.HoraComienzo;
                        comando.Parameters["@HoraFin"].Value = tarea.HoraFin;
                        comando.Parameters["@Lugar"].Value = tarea.Lugar;
                    }

                    conexion.Close();
                }
            }
            catch (Exception ex)
            {
                throw new ExcepcionDA("Se produjo un error al actualizar la tarea.", ex);
            }
        }

        public void Borrar(TareaEntity tarea)
        {
            try
            {
                using (SqlConnection conexion = ConexionDA.ObtenerConexion())
                {
                    using (SqlCommand comando = new SqlCommand("TareaDelete", conexion))
                    {
                        comando.CommandType = CommandType.StoredProcedure;
                        SqlCommandBuilder.DeriveParameters(comando);

                        comando.Parameters["@ID"].Value = tarea.Id;
                    }

                    conexion.Close();
                }
            }
            catch (Exception ex)
            {
                throw new ExcepcionDA("Se produjo un error al borrar la tarea.", ex);
            }
        }

        public bool HayDisponibilidad(TareaEntity tarea)
        {
            try
            {
                bool hayDisponibilidad = false;

                using (SqlConnection conexion = ConexionDA.ObtenerConexion())
                {
                    using (SqlCommand comando = new SqlCommand("HayDisponibilidad", conexion))
                    {
                        comando.CommandType = CommandType.StoredProcedure;
                        //SqlCommandBuilder.DeriveParameters(comando);

                        //comando.Parameters["@UsuarioID"].Value = tarea.UsuarioId;
                        //comando.Parameters["@HoraComienzo"].Value = tarea.HoraComienzo;
                        //comando.Parameters["@HoraFin"].Value = tarea.HoraFin;

                        var parametroUsuarioId = new SqlParameter("@UsuarioId", SqlDbType.Int);
                        parametroUsuarioId.Value = tarea.UsuarioId;
                        comando.Parameters.Add(parametroUsuarioId);

                        if (tarea.HoraComienzo == null)
                            comando.Parameters["@HoraComienzo"].Value = DBNull.Value;
                        else
                        {
                            var parametroHoraComienzo = new SqlParameter("@HoraComienzo", SqlDbType.DateTime);
                            parametroHoraComienzo.Value = tarea.HoraComienzo;
                            comando.Parameters.Add(parametroHoraComienzo);
                        }

                        if (tarea.HoraFin == null)
                            comando.Parameters["@HoraFin"].Value = DBNull.Value;
                        else
                        {
                            var parametroHoraFin = new SqlParameter("@HoraFin", SqlDbType.DateTime);
                            parametroHoraFin.Value = tarea.HoraFin;
                            comando.Parameters.Add(parametroHoraFin);
                        }

                        var cursor = comando.ExecuteReader();
                        if (cursor.HasRows)
                        {
                            Console.WriteLine("No se puede ingresar la tarea, esta ocupado el horario.");
                        }
                        else
                        {
                            hayDisponibilidad = true;
                            Console.WriteLine("Se puede ingresar la tarea");
                        }
                }

                    conexion.Close();
                }

                return hayDisponibilidad;
            }
            catch (Exception ex)
            {
                throw new ExcepcionDA("Se produjo un error al verificar la disponibilidad.", ex);
            }
        }

        public List<TareaEntity> ListarTareas(int UsuarioId
            , int? Id = null
            , String nombre = null
            , String descripcion = null
            , DateTime? fechaHoraComienzo = null
            , DateTime? horaFin = null
            , String lugar = null)
        {
            var temp = new List<TareaEntity>();
            try
            {
                using (SqlConnection conexion = ConexionDA.ObtenerConexion())
                {
                    using (SqlCommand comando = new SqlCommand("ListarTareas", conexion))
                    {
                        comando.CommandType = CommandType.StoredProcedure;
                        //SqlCommandBuilder.DeriveParameters(comando);
                        //if (Id == null)
                        //    comando.Parameters["@ID"].Value = DBNull.Value;
                        //else
                        //    comando.Parameters["@ID"].Value = Id;

                        //comando.Parameters["@UsuarioId"].Value = UsuarioId;

                        var parametroUsuarioId = new SqlParameter("@UsuarioId", SqlDbType.Int);
                        parametroUsuarioId.Value = UsuarioId;
                        comando.Parameters.Add(parametroUsuarioId);

                        //if (nombre == null)
                        //    comando.Parameters["@Nombre"].Value = DBNull.Value;
                        //else
                        //    comando.Parameters["@Nombre"].Value = nombre;

                        //if (descripcion == null)
                        //    comando.Parameters["@Descripcion"].Value = DBNull.Value;
                        //else
                        //    comando.Parameters["@Descripcion"].Value = descripcion;

                        if (fechaHoraComienzo == null)
                            comando.Parameters["@HoraComienzo"].Value = DBNull.Value;
                        else
                        {
                            var parametroHoraComienzo = new SqlParameter("@HoraComienzo", SqlDbType.DateTime);
                            parametroHoraComienzo.Value = fechaHoraComienzo;
                            comando.Parameters.Add(parametroHoraComienzo);
                        }

                        //if (horaFin == null)
                        //    comando.Parameters["@HoraFin"].Value = DBNull.Value;
                        //else
                        //    comando.Parameters["@HoraFin"].Value = horaFin;

                        //if (lugar == null)
                        //    comando.Parameters["@Lugar"].Value = DBNull.Value;
                        //else
                        //    comando.Parameters["@Lugar"].Value = lugar;

                        var cursor = comando.ExecuteReader();
                        if (cursor.HasRows)
                        {
                            while (cursor.Read())
                            {
                                temp.Add(new TareaEntity()
                                {
                                    Id = cursor.GetInt32(0),
                                    Nombre = cursor.GetString(2),
                                    Descripcion = cursor.GetString(3),
                                    HoraComienzo = cursor.GetDateTime(4),
                                    HoraFin = cursor.GetDateTime(5),
                                    Lugar = cursor.GetString(6)
                                });
                            }
                        }
                        else
                        {
                            Console.WriteLine("No rows found.");
                        }
                    }

                    conexion.Close();
                }
            }
            catch (Exception ex)
            {
                throw new ExcepcionDA("Se produjo un error al listar las tarea.", ex);
            }
            return temp;

        }

        #endregion Métodos Públicos

    }
}
