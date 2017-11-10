<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #form1 {
            width: 1233px;
            height: 847px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
        <asp:Calendar ID="Calendar1" runat="server" Height="300px" OnSelectionChanged="Calendar1_SelectionChanged" Width="1000px" BackColor="#FFFFCC" BorderColor="#FFCC66" BorderWidth="1px" Font-Names="Verdana" Font-Size="8pt" ForeColor="#663399" DayNameFormat="Shortest" ShowGridLines="True">
            <DayHeaderStyle Font-Bold="True" BackColor="#FFCC66" Height="1px" />
            <NextPrevStyle Font-Size="9pt" ForeColor="#FFFFCC" />
            <OtherMonthDayStyle ForeColor="#CC9966" />
            <SelectedDayStyle BackColor="#CCCCFF" Font-Bold="True" />
            <SelectorStyle BackColor="#FFCC66" />
            <TitleStyle BackColor="#990000" Font-Bold="True" Font-Size="9pt" ForeColor="#FFFFCC" />
            <TodayDayStyle BackColor="#FFCC66" ForeColor="White" />
        </asp:Calendar>
        
        <asp:GridView ID="gvTareasPorDia" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" Height="200px" Width="1000px" AutoGenerateColumns="False" OnSelectedIndexChanged="gvTareasPorDia_SelectedIndexChanged" style="margin-top: 2px">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="Nombre" HeaderText="Tarea">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Descripcion" HeaderText="Descripcion">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="HoraComienzo" HeaderText="Hora de Comienzo">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="HoraFin" HeaderText="Hora de Fin">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Lugar" HeaderText="Lugar">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            <SortedAscendingCellStyle BackColor="#FDF5AC" />
            <SortedAscendingHeaderStyle BackColor="#4D0000" />
            <SortedDescendingCellStyle BackColor="#FCF6C0" />
            <SortedDescendingHeaderStyle BackColor="#820000" />
        </asp:GridView>
        
        <br />
        <asp:Label ID="lTarea" runat="server" Text="Tarea"></asp:Label>
        <br />
        <asp:TextBox ID="tbTarea" runat="server" OnTextChanged="tbTarea_TextChanged"></asp:TextBox>
        <br />
        <asp:Label ID="lDesc" runat="server" Text="Descripcion"></asp:Label>
        <br />
        <asp:TextBox ID="tbDesc" runat="server" OnTextChanged="tbDesc_TextChanged"></asp:TextBox>
        
        <br />
        <asp:Label ID="lHoraCom" runat="server" Text="Hora de Comienzo"></asp:Label>
        <br />
        <asp:TextBox ID="tbHoraCom" runat="server" OnTextChanged="TextBox3_TextChanged"></asp:TextBox>
        <br />
        <asp:Label ID="lHoraFin" runat="server" Text="Hora de Fin"></asp:Label>
        <br />
        <asp:TextBox ID="tbHoraFin" runat="server" OnTextChanged="TextBox4_TextChanged"></asp:TextBox>
        <br />
        <asp:Label ID="lLugar" runat="server" Text="Lugar"></asp:Label>
        <br />
        <asp:TextBox ID="tbLugar" runat="server" OnTextChanged="TextBox5_TextChanged"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="lGuardar" runat="server" Text="Guardar"></asp:Label>
        <br />
        <asp:ImageButton ID="ibAgregarTarea" runat="server" Height="61px" ImageUrl="~/Imagenes/AddTareaImg.png" OnClick="ibAgregarTarea_Click1" Width="59px" />
        <br />
        
    </form>
</body>
</html>
