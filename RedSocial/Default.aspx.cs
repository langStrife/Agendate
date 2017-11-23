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

public partial class _Default : System.Web.UI.Page
{
    private TareaBO boTarea = new TareaBO();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            gvTareasPorDia.EditIndex = -1;
            Llenar_Grilla(DateTime.Today);
        }
    }

    private void Llenar_Grilla(DateTime fechaHoraComienzo)
    {
        var listaTareas = boTarea.ListarTareas(SessionHelper.UsuarioAutenticado.Id, fechaHoraComienzo: fechaHoraComienzo);
        this.gvTareasPorDia.DataSource = listaTareas;
        this.gvTareasPorDia.DataBind();
    }

    protected void Calendar1_SelectionChanged(object sender, EventArgs e)
    {
        Llenar_Grilla(Calendar1.SelectedDate);

        //Crear una clase de la cual hereden todas las paginas con una funcionalidad que consulte en el pageload
        //si SessionHelper tiene un usuario Loggeado, sinó redirigir al login
    }

    protected void ibAgregarTarea_Click1(object sender, ImageClickEventArgs e)
    {
        string fechaHoraComienzoStr, fechaHoraFinStr;
        DateTime fechaHoraComienzo, fechaHoraFin;
        try
        {
            TareaEntity tarea = new TareaEntity();
            tarea.UsuarioId = SessionHelper.UsuarioAutenticado.Id;
            tarea.Nombre = txtTarea.Text;
            tarea.Descripcion = txtDesc.Text;
            tarea.Lugar = txtLugar.Text;
            fechaHoraComienzo = 
            //diaCom = CalendarCom.SelectedDate.Date;
            //tareaHoraCom = ddlDesplegableHoraCom.SelectedValue;
            //tareaMinCom = ddlDesplegableMinCom.SelectedValue;
            //tareaTipoHoraCom = ddlDesplegableTipoHoraCom.SelectedValue;
            //fechaHoraComienzoStr = (diaCom.ToString("dd/MM/yyy") + " " + tareaHoraCom + ":" + tareaMinCom + " " + tareaTipoHoraCom);
            //fechaHoraComienzo = DateTime.Parse(fechaHoraComienzoStr);
            //tarea.HoraComienzo = fechaHoraComienzo;
            //diaFin = CalendarFin.SelectedDate.Date;
            //tareaHoraFin = ddlDesplegableHoraFin.SelectedValue;
            //tareaMinFin = ddlDesplegableMinFin.SelectedValue;
            //tareaTipoHoraFin = ddlDesplegableTipoHoraFin.SelectedValue;
            //fechaHoraFinStr = (diaFin.ToString("dd/MM/yyy") + " " + tareaHoraFin + ":" + tareaMinFin + " " + tareaTipoHoraFin);
            //fechaHoraFin = DateTime.Parse(fechaHoraFinStr);
            //tarea.HoraFin = fechaHoraFin;
            //if (validacion)
            //{
            boTarea.AgendarTarea(tarea);
            //}
            //else 
            //{
            //    txtMensaje.Text = "Completar el formulario.";
            //}
            gvTareasPorDia.EditIndex = -1;
            Llenar_Grilla(Calendar1.SelectedDate);

            //SessionHelper.AlmacenarUsuarioAutenticado(boUsuario.Autenticar(txtEmail.Text, txtPassword.Text));
            //System.Web.Security.FormsAuthentication.RedirectFromLoginPage(SessionHelper.UsuarioAutenticado.Email, false);
        }
        catch (ValidacionExcepcionAbstract ex)
        {
            WebHelper.MostrarMensaje(Page, ex.Message);
        }
    }

    protected void gvTareasPorDia_RowEditing(object sender, GridViewEditEventArgs e)
    {
        try
        {
            gvTareasPorDia.EditIndex = e.NewEditIndex;
            Llenar_Grilla(Calendar1.SelectedDate);
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
            Llenar_Grilla(Calendar1.SelectedDate);
        }
        catch (Exception ex)
        {
            WebHelper.MostrarMensaje(Page, ex.Message);
        }
    }

    protected void gvTareasPorDia_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        DateTime fechaHoraComienzo, fechaHoraFin;
        try
        {
            TareaEntity tarea = new TareaEntity();
            TextBox txt = new TextBox();
            Label lbl = new Label();
            lbl = (Label)gvTareasPorDia.Rows[e.RowIndex].FindControl("TextBox6");
            tarea.Id = Convert.ToInt32(lbl.Text);
            txt = (TextBox)gvTareasPorDia.Rows[e.RowIndex].FindControl("TextBox1");
            tarea.Nombre = txt.Text;
            txt = (TextBox)gvTareasPorDia.Rows[e.RowIndex].FindControl("TextBox2");
            tarea.Descripcion = txt.Text;
            txt = (TextBox)gvTareasPorDia.Rows[e.RowIndex].FindControl("TextBox3");
            fechaHoraComienzo = DateTime.Parse(txt.Text);
            tarea.HoraComienzo = fechaHoraComienzo;
            txt = (TextBox)gvTareasPorDia.Rows[e.RowIndex].FindControl("TextBox4");
            fechaHoraFin = DateTime.Parse(txt.Text);
            tarea.HoraFin = fechaHoraFin;
            txt = (TextBox)gvTareasPorDia.Rows[e.RowIndex].FindControl("TextBox5");
            tarea.Lugar = txt.Text;
            boTarea.ActualizarTarea(tarea);
            gvTareasPorDia.EditIndex = -1;
            Llenar_Grilla(Calendar1.SelectedDate);
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
            Llenar_Grilla(Calendar1.SelectedDate);
        }
        catch (Exception ex)
        {
            WebHelper.MostrarMensaje(Page, ex.Message);
        }
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

    protected void CalendarCom_SelectionChanged(object sender, EventArgs e)
    {

    }

    protected void CalendarFin_SelectionChanged(object sender, EventArgs e)
    {

    }

    protected void ddlDesplegableHoraCom_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void ddlDesplegableMinCom_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void ddlDesplegableHoraFin_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void ddlDesplegableMinFin_SelectedIndexChanged(object sender, EventArgs e)
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


    protected void gvTareasPorDia_PageIndexChanging(object sender, GridViewPageEventArgs e)
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
}