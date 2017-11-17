﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #form1 {
            width: 1233px;
            height: 1365px;
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
        <asp:TextBox ID="txtTarea" runat="server" OnTextChanged="tbTarea_TextChanged" Width="224px"></asp:TextBox>
        <br />
        <asp:Label ID="lDesc" runat="server" Text="Descripcion"></asp:Label>
        <br />
        <asp:TextBox ID="txtDesc" runat="server" OnTextChanged="tbDesc_TextChanged" Height="67px" Width="229px"></asp:TextBox>
        
        <br />
        <asp:Label ID="lFechaCom" runat="server" Text="Fecha de Comienzo"></asp:Label>
        <asp:Calendar ID="CalendarCom" runat="server" OnSelectionChanged="CalendarCom_SelectionChanged"></asp:Calendar>
        <br />
        <asp:Label ID="lHoraCom" runat="server" Text="Hora de Comienzo"></asp:Label>
        &nbsp;<asp:DropDownList ID="ddlDesplegableHoraCom" runat="server" Height="32px" OnSelectedIndexChanged="ddlDesplegableHoraCom_SelectedIndexChanged">
            <asp:ListItem>01</asp:ListItem>
            <asp:ListItem>02</asp:ListItem>
            <asp:ListItem>03</asp:ListItem>
            <asp:ListItem>04</asp:ListItem>
            <asp:ListItem>05</asp:ListItem>
            <asp:ListItem Value="06">06</asp:ListItem>
            <asp:ListItem>07</asp:ListItem>
            <asp:ListItem>08</asp:ListItem>
            <asp:ListItem>09</asp:ListItem>
            <asp:ListItem>10</asp:ListItem>
            <asp:ListItem>11</asp:ListItem>
            <asp:ListItem>12</asp:ListItem>
        </asp:DropDownList>
&nbsp;<asp:DropDownList ID="ddlDesplegableMinCom" runat="server" OnSelectedIndexChanged="ddlDesplegableMinCom_SelectedIndexChanged">
            <asp:ListItem>00</asp:ListItem>
            <asp:ListItem>05</asp:ListItem>
            <asp:ListItem>10</asp:ListItem>
            <asp:ListItem>15</asp:ListItem>
            <asp:ListItem>20</asp:ListItem>
            <asp:ListItem>25</asp:ListItem>
            <asp:ListItem>30</asp:ListItem>
            <asp:ListItem>35</asp:ListItem>
            <asp:ListItem>40</asp:ListItem>
            <asp:ListItem>45</asp:ListItem>
            <asp:ListItem>50</asp:ListItem>
            <asp:ListItem>55</asp:ListItem>
        </asp:DropDownList>
&nbsp;<asp:DropDownList ID="ddlDesplegableTipoHoraCom" runat="server" OnSelectedIndexChanged="ddlDesplegableMinCom_SelectedIndexChanged">
            <asp:ListItem>a. m.</asp:ListItem>
            <asp:ListItem>p. m.</asp:ListItem>
        </asp:DropDownList>
        <br />
        <br />
        <asp:Label ID="lFechaFin" runat="server" Text="Fecha de Fin"></asp:Label>
        <asp:Calendar ID="CalendarFin" runat="server" OnSelectionChanged="CalendarFin_SelectionChanged"></asp:Calendar>
        <br />
        <asp:Label ID="lHoraFin" runat="server" Text="Hora de Fin"></asp:Label>
        &nbsp;<asp:DropDownList ID="ddlDesplegableHoraFin" runat="server" Height="33px" OnSelectedIndexChanged="ddlDesplegableHoraFin_SelectedIndexChanged">
            <asp:ListItem>01</asp:ListItem>
            <asp:ListItem>02</asp:ListItem>
            <asp:ListItem Value="03">03</asp:ListItem>
            <asp:ListItem>04</asp:ListItem>
            <asp:ListItem>05</asp:ListItem>
            <asp:ListItem>06</asp:ListItem>
            <asp:ListItem>07</asp:ListItem>
            <asp:ListItem>08</asp:ListItem>
            <asp:ListItem>09</asp:ListItem>
            <asp:ListItem>10</asp:ListItem>
            <asp:ListItem>11</asp:ListItem>
            <asp:ListItem>12</asp:ListItem>
        </asp:DropDownList>
&nbsp;<asp:DropDownList ID="ddlDesplegableMinFin" runat="server" Height="26px" OnSelectedIndexChanged="ddlDesplegableMinFin_SelectedIndexChanged">
            <asp:ListItem>00</asp:ListItem>
            <asp:ListItem>05</asp:ListItem>
            <asp:ListItem>10</asp:ListItem>
            <asp:ListItem>15</asp:ListItem>
            <asp:ListItem>20</asp:ListItem>
            <asp:ListItem>25</asp:ListItem>
            <asp:ListItem>30</asp:ListItem>
            <asp:ListItem>35</asp:ListItem>
            <asp:ListItem>40</asp:ListItem>
            <asp:ListItem>45</asp:ListItem>
            <asp:ListItem>50</asp:ListItem>
            <asp:ListItem>55</asp:ListItem>
        </asp:DropDownList>
&nbsp;<asp:DropDownList ID="ddlDesplegableTipoHoraFin" runat="server" OnSelectedIndexChanged="ddlDesplegableMinCom_SelectedIndexChanged">
            <asp:ListItem>a. m.</asp:ListItem>
            <asp:ListItem>p. m.</asp:ListItem>
        </asp:DropDownList>
        <br />
        <br />
        <asp:Label ID="lLugar" runat="server" Text="Lugar"></asp:Label>
        <br />
        <asp:TextBox ID="txtLugar" runat="server" OnTextChanged="TextBox5_TextChanged" Width="231px"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="lGuardar" runat="server" Text="Guardar"></asp:Label>
        <br />
        <asp:ImageButton ID="ibAgregarTarea" runat="server" Height="61px" ImageUrl="~/Imagenes/AddTareaImg.png" OnClick="ibAgregarTarea_Click1" Width="59px" />
        <br />
        
    </form>
</body>
</html>