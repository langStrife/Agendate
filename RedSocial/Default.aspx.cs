using System;
using System.Collections.Generic;
using System.Linq;
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
       
    }

    protected void Calendar1_SelectionChanged(object sender, EventArgs e)
    {
        int ID = 2;
        //int ID = SessionHelper.UsuarioAutenticado.Id;
        DateTime dia = Calendar1.SelectedDate;
        var listarTareas = boTarea.ListarTareas(ID, horaComienzo: dia);
        //var agendarTarea = boTarea.AgendarTarea();
        /*for (int i = 0; i <24 ; i++)
        {
            listarTareas.Add(new TareaEntity() { Id = i, Descripcion = "Que loco que es .NET"});
        }*/
        this.gvTareasPorDia.DataSource = listarTareas;
        this.gvTareasPorDia.DataBind();
        //this.ibAgregarTarea = agendarTarea;

        //Crear una clase de la cual hereden todas las paginas con una funcionalidad que consulte en el pageload
        //si SessionHelper tiene un usuario Loggeado, sinó redirigir al login
    }

    protected void ibAgregarTarea_Click(object sender, ImageClickEventArgs e)
    {
        
    }

    protected void FormView1_PageIndexChanging(object sender, FormViewPageEventArgs e)
    {

    }

    protected void TextBox3_TextChanged(object sender, EventArgs e)
    {

    }

    protected void TextBox5_TextChanged(object sender, EventArgs e)
    {

    }

    protected void TextBox4_TextChanged(object sender, EventArgs e)
    {

    }

    protected void TextBox6_TextChanged(object sender, EventArgs e)
    {

    }

    protected void gvTareasPorDia_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}