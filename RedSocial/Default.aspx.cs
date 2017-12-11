using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RedSocialBusiness;
using RedSocialEntity;
using RedSocialComun;
using RedSocialWebUtil;
using System.Globalization;

public partial class _Default : System.Web.UI.Page
{
    private TareaBO boTarea = new TareaBO();

    protected void Page_Load(object sender, EventArgs e)
    {
        //Si se termina la sesion el usuario será redirigido a la pagina de login
        if (!Response.IsClientConnected)
        {
            WebHelper.MostrarMensaje(Page, "Su Sesión Ha Caducado");
            Response.Redirect("Registracion.aspx");
        }

        if (!Page.IsPostBack)
        {
            Calendar1.SelectedDate = DateTime.Today;
            Llenar_Grilla();
        }
    }

    private void Llenar_Grilla()
    {
        var listaTareas = boTarea.ListarTareas(SessionHelper.UsuarioAutenticado.Id, fechaHoraComienzo: Calendar1.SelectedDate);
        this.gvTareasPorDia.DataSource = listaTareas;
        this.gvTareasPorDia.DataBind();
    }

    protected void gvTareasPorDia_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            Llenar_Grilla();
            gvTareasPorDia.PageIndex = e.NewPageIndex;
            this.gvTareasPorDia.DataBind();
        }
        catch (Exception ex)
        {
            WebHelper.MostrarMensaje(Page, ex.Message);
        }
    }

    protected void gvTareasPorDia_RowEditing(object sender, GridViewEditEventArgs e)
    {
        try
        {
            gvTareasPorDia.EditIndex = e.NewEditIndex;
            Llenar_Grilla();
        }
        catch (Exception ex)
        {
            WebHelper.MostrarMensaje(Page, ex.Message);
        }
    }

    protected void gvTareasPorDia_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        try
        {
            gvTareasPorDia.EditIndex = -1;
            Llenar_Grilla();
        }
        catch (Exception ex)
        {
            WebHelper.MostrarMensaje(Page, ex.Message);
        }
    }

    protected void gvTareasPorDia_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        string mensaje = "";
        try
        {
            TareaEntity tarea = new TareaEntity();
            TextBox txt = new TextBox();
            Label lbl = new Label();
            lbl = (Label)gvTareasPorDia.Rows[e.RowIndex].FindControl("Label1");
            tarea.Id = Convert.ToInt32(lbl.Text);
            tarea.UsuarioId = SessionHelper.UsuarioAutenticado.Id;
            txt = (TextBox)gvTareasPorDia.Rows[e.RowIndex].FindControl("TextBox1");
            tarea.Nombre = txt.Text;
            txt = (TextBox)gvTareasPorDia.Rows[e.RowIndex].FindControl("TextBox2");
            tarea.Descripcion = txt.Text;
            txt = (TextBox)gvTareasPorDia.Rows[e.RowIndex].FindControl("txtFechaHoraComienzoEdit");
            tarea.HoraComienzo = DateTime.Parse(txt.Text);
            txt = (TextBox)gvTareasPorDia.Rows[e.RowIndex].FindControl("txtFechaHoraFinEdit");
            tarea.HoraFin = DateTime.Parse(txt.Text);
            txt = (TextBox)gvTareasPorDia.Rows[e.RowIndex].FindControl("TextBox5");
            tarea.Lugar = txt.Text;
            mensaje = boTarea.ActualizarTarea(tarea);
            gvTareasPorDia.EditIndex = -1;
            Llenar_Grilla();
            WebHelper.MostrarMensaje(Page, mensaje);
        }
        catch (System.FormatException)
        {
            WebHelper.MostrarMensaje(Page, "Debe seleccionar una fecha y hora de inicio y una de fin");
        }
        catch (ValidacionExcepcionAbstract ex)
        {
            WebHelper.MostrarMensaje(Page, ex.Message);
        }
    }

    protected void gvTareasPorDia_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            TareaEntity tarea = new TareaEntity();
            Label lbl = new Label();
            lbl = (Label)gvTareasPorDia.Rows[e.RowIndex].FindControl("Label6");
            tarea.Id = Convert.ToInt32(lbl.Text);
            boTarea.BorrarTarea(tarea);
            gvTareasPorDia.EditIndex = -1;
            Llenar_Grilla();
            WebHelper.MostrarMensaje(Page, "Se borró la tarea correctamente.");
        }
        catch (Exception ex)
        {
            WebHelper.MostrarMensaje(Page, ex.Message);
        }
    }

    protected void ibAgregarTarea_Click1(object sender, ImageClickEventArgs e)
    {
        string fechaHoraComienzoStr, fechaHoraFinStr, mensaje = "";
        DateTime fechaHoraComienzo, fechaHoraFin;
        try
        {
            TareaEntity tarea = new TareaEntity();
            tarea.UsuarioId = SessionHelper.UsuarioAutenticado.Id;
            tarea.Nombre = txtTarea.Text;
            tarea.Descripcion = txtDesc.Text;
            tarea.Lugar = txtLugar.Text;
            fechaHoraComienzoStr = this.txtFechaHoraComienzo.Value;
            fechaHoraComienzo = DateTime.Parse(fechaHoraComienzoStr);
            tarea.HoraComienzo = fechaHoraComienzo;
            fechaHoraFinStr = this.txtFechaHoraFin.Value;
            fechaHoraFin = DateTime.Parse(fechaHoraFinStr);
            tarea.HoraFin = fechaHoraFin;
            mensaje = boTarea.AgendarTarea(tarea);
            gvTareasPorDia.EditIndex = -1;
            Llenar_Grilla();
            Limpiar();
            WebHelper.MostrarMensaje(Page, mensaje);
            //SessionHelper.AlmacenarUsuarioAutenticado(boUsuario.Autenticar(txtEmail.Text, txtPassword.Text));
            //System.Web.Security.FormsAuthentication.RedirectFromLoginPage(SessionHelper.UsuarioAutenticado.Email, false);
        }
        catch (System.FormatException)
        {
            WebHelper.MostrarMensaje(Page, "Debe seleccionar una fecha y hora de inicio y una de fin");
        }
        catch (ValidacionExcepcionAbstract ex)
        {
            WebHelper.MostrarMensaje(Page, ex.Message);
        }
    }

    protected void Calendar1_SelectionChanged(object sender, EventArgs e)
    {
        Llenar_Grilla();
        //Crear una clase de la cual hereden todas las paginas con una funcionalidad que consulte en el pageload
        //si SessionHelper tiene un usuario Loggeado, sinó redirigir al login
    }

    private void Limpiar()
    {
        txtTarea.Text = "";
        txtDesc.Text = "";
        this.txtFechaHoraComienzo.Value = "";
        this.txtFechaHoraFin.Value = "";
        txtLugar.Text = "";
    }

    protected void logoutButton_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("Registracion.aspx");
    }

    protected void gvTareasPorDia_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {

    }

    protected void tbTarea_TextChanged(object sender, EventArgs e)
    {

    }

    protected void tbDesc_TextChanged(object sender, EventArgs e)
    {

    }

    protected void TextBox5_TextChanged(object sender, EventArgs e)
    {

    }

    protected void gvTareasPorDia_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void gvTareasPorDia_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {

    }

    protected void gvTareasPorDia_DataBound(object sender, EventArgs e)
    {

    }


    protected void gvTareasPorDia_RowCommand(object sender, GridViewCommandEventArgs e)
    {

    }

    protected void gvTareasPorDia_PageIndexChanged(object sender, EventArgs e)
    {

    }


    protected void gvTareasPorDia_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {

    }

    protected void btnQuitarSeleccionados_Click(object sender, EventArgs e)
    {

    }

    protected void editarPerfil_Click(object sender, EventArgs e)
    {

    }
}