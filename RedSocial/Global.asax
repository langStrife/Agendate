<%@ Application Language="C#" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e)
    {
        // Código que se ejecuta al iniciarse la aplicación

    }

    void Application_End(object sender, EventArgs e)
    {
        //  Código que se ejecuta cuando se cierra la aplicación

    }

    void Application_Error(object sender, EventArgs e)
    {
        // Código que se ejecuta al producirse un error no controlado

        // Get the exception object.
        Exception exc = Server.GetLastError();

        // Handle HTTP errors

        // For other kinds of errors give the user some information
        // but stay on the default page
        Response.Write("<h2>Global Page Error</h2>\n");
        Response.Write(
            "<p>" + exc.Message + "</p>\n");
        Response.Write("Vuelva a ingresar su usuario en la <a href='Registracion.aspx'>" +
            "Pagina de Inicio de Sesion</a>\n");

        // Log the exception and notify system operators

        // Clear the error from the server
        Server.ClearError();
        }

    void Session_Start(object sender, EventArgs e)
    {
        // Código que se ejecuta cuando se inicia una nueva sesión

    }

    void Session_End(object sender, EventArgs e)
    {
        // Código que se ejecuta cuando finaliza una sesión. 
        // Nota: El evento Session_End se desencadena sólo con el modo sessionstate
        // se establece como InProc en el archivo Web.config. Si el modo de sesión se establece como StateServer 
        // o SQLServer, el evento no se genera.

    }

</script>
