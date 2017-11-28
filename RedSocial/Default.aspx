<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Agendate</title>
		<!--
			<link rel="stylesheet" type="text/css" href="/styles/stylesDefault.css" />
			<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb">
			<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh"></script>
			<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ"></script>
			-->	
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.15.1/moment.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.7.14/js/bootstrap-datetimepicker.min.js"></script>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.7.14/css/bootstrap-datetimepicker.min.css">
	</head>
	<body>
		<form id="form1" runat="server">
			<div class="container">


                <asp:Button class="btn btn-info btn-lg" ID="logoutButton" runat="server" Text="Log Out"
                    style="text-align: center; 
					width: 20%; max-width: 300px; 
					min-width: 110px; margin-left: 0px; margin-top: 5px; margin-bottom: 5px;" title="Log Out" OnClick="logoutButton_Click"/>

				<div class="row">
					<div class="col-md-8">
						<asp:Calendar class="calendar" ID="Calendar1" runat="server" 
							OnSelectionChanged="Calendar1_SelectionChanged" Font-Names="Verdana" Font-Size="8pt" ForeColor="#663399" 
							DayNameFormat="Shortest" ShowGridLines="True" Height="300px" Width="100%">
							<DayHeaderStyle Font-Bold="True" BackColor="#007ACC" Height="1px" ForeColor="White" />
							<DayStyle BackColor="White" ForeColor="#334666" />
							<NextPrevStyle Font-Size="Small" ForeColor="White" />
							<OtherMonthDayStyle ForeColor="#007ACC" />
							<SelectedDayStyle BackColor="#4992D5" Font-Bold="True" ForeColor="White" />
							<SelectorStyle BackColor="#2C92E1" />
							<TitleStyle BackColor="#337AB7" Font-Bold="True" Font-Size="Small" ForeColor="White" />
							<TodayDayStyle BackColor="#4992D5" ForeColor="White" />
						</asp:Calendar>
						<asp:GridView ID="gvTareasPorDia" runat="server"
							AutoGenerateColumns="False" 
							CssClass="table table-bordered bs-table" 
							OnRowDeleted="gvTareasPorDia_RowDeleted" 
							OnRowUpdated="gvTareasPorDia_RowUpdated" 
							OnRowEditing="gvTareasPorDia_RowEditing" 
							OnDataBound="gvTareasPorDia_DataBound" 
							allowpaging="True" OnRowCancelingEdit="gvTareasPorDia_RowCancelingEdit" OnRowDeleting="gvTareasPorDia_RowDeleting" OnRowUpdating="gvTareasPorDia_RowUpdating" >
							<FooterStyle BorderColor="#176782" />
							<HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White" BorderColor="#176782" Font-Size="Small" />
							<EditRowStyle BackColor="#FFFFCC" BorderColor="#176782" />
							<EmptyDataRowStyle forecolor="Red" CssClass="table table-bordered" BorderColor="#176782" />
							<emptydatatemplate>
								¡No hay tareas!  
							</emptydatatemplate>
							<Columns>
								<%--botones de acción sobre los registros...--%>
								<asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100%">
									<ItemTemplate>
										<%--Botones de eliminar y editar cliente...--%>
										<asp:Button ID="btnDelete" runat="server" Text="Quitar" CssClass="btn btn-danger" CommandName="Delete" OnClientClick="return confirm('¿Eliminar tarea?');" />
										<asp:Button ID="btnEdit" runat="server" Text="Editar" CssClass="btn btn-info" CommandName="Edit" />
									</ItemTemplate>
									<edititemtemplate>
										<%--Botones de grabar y cancelar la edición de registro...--%>
										<asp:Button ID="btnUpdate" runat="server" Text="Grabar" CssClass="btn btn-success" CommandName="Update" OnClientClick="return confirm('¿Seguro que quiere modificar los datos de la tarea?');" />
										<asp:Button ID="btnCancel" runat="server" Text="Cancelar" CssClass="btn btn-default" CommandName="Cancel" />
									</edititemtemplate>
									<HeaderStyle Width="100%"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
								</asp:TemplateField>

								<%--campos...--%>
								<asp:TemplateField HeaderText="Id" Visible="False">
                                    <EditItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("Id") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ControlStyle BorderStyle="None" />
                                </asp:TemplateField>
								<asp:TemplateField HeaderText="Tarea" SortExpression="Tarea">
									<EditItemTemplate>
										<asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Nombre") %>'></asp:TextBox>
									</EditItemTemplate>
									<ItemTemplate>
										<asp:Label ID="Label1" runat="server" Text='<%# Bind("Nombre") %>'></asp:Label>
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Descripcion" InsertVisible="False" SortExpression="Descripcion">
									<EditItemTemplate>
										<asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Descripcion") %>'></asp:TextBox>
									</EditItemTemplate>
									<ItemTemplate>
										<asp:Label ID="Label2" runat="server" Text='<%# Bind("Descripcion") %>'></asp:Label>
									</ItemTemplate>
									<ControlStyle Width="100%" />
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Hora De Comienzo" InsertVisible="False" SortExpression="Hora De Comienzo">
									<EditItemTemplate>
										<asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("HoraComienzo") %>'></asp:TextBox>
									</EditItemTemplate>
									<ItemTemplate>
										<asp:Label ID="Label3" runat="server" Text='<%# Bind("HoraComienzo") %>'></asp:Label>
									</ItemTemplate>
									<ControlStyle Width="100%" />
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Hora De Fin" SortExpression="Hora De Fin">
									<EditItemTemplate>
										<asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("HoraFin") %>'></asp:TextBox>
									</EditItemTemplate>
									<ItemTemplate>
										<asp:Label ID="Label4" runat="server" Text='<%# Bind("HoraFin") %>'></asp:Label>
									</ItemTemplate>
									<ControlStyle Width="100%" />
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Lugar" SortExpression="Lugar">
									<EditItemTemplate>
										<asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("Lugar") %>'></asp:TextBox>
									</EditItemTemplate>
									<ItemTemplate>
										<asp:Label ID="Label5" runat="server" Text='<%# Bind("Lugar") %>'></asp:Label>
									</ItemTemplate>
								</asp:TemplateField>
							</Columns>
							<PagerStyle BorderColor="#176782" />
							<RowStyle BorderColor="#176782" />
						</asp:GridView>
						<p style="text-align:center;">
							&nbsp;
						</p>
					</div>
					<div class="col-md-4" style="background-color: #3384D0;">
						<asp:Label ID="lTarea" runat="server" Text="Tarea" BorderColor="White" Font-Bold="True" ForeColor="White"></asp:Label>
						<br />
						<asp:TextBox ID="txtTarea" runat="server" OnTextChanged="tbTarea_TextChanged" Width="224px"></asp:TextBox>
						<br />
						<br />
						<asp:Label ID="lDesc" runat="server" Text="Descripcion" BorderColor="White" Font-Bold="True" ForeColor="White"></asp:Label>
						<br />
						<asp:TextBox ID="txtDesc" runat="server" OnTextChanged="tbDesc_TextChanged" Height="67px" Width="229px"></asp:TextBox>
						<br />
						<br />
						<div class="row">
							<div class="col-md-6">
								<asp:Label ID="lFechaCom" runat="server" Text="Fecha de Comienzo" BorderColor="White" Font-Bold="True" ForeColor="White"></asp:Label>
								<div class="form-group">
									<div class='input-group date' id='datetimepicker1'>
										<input type='text' class="form-control" id ="txtFechaHoraComienzo" runat="server" />
										<span class="input-group-addon">
										<span class="glyphicon glyphicon-calendar"></span>
										</span>
									</div>
								</div>
								<script type="text/javascript">
									$(function () {
									    $('#datetimepicker1').datetimepicker({
									        format: 'DD/MM/YYYY HH:mm'
									    });
									});
								</script>
								<!--
									<asp:Calendar ID="CalendarCom" runat="server" OnSelectionChanged="CalendarCom_SelectionChanged">
									<DayHeaderStyle BackColor="#007ACC" Font-Bold="True" ForeColor="White" />
									<DayStyle BackColor="White" ForeColor="#334666" />
									<TitleStyle BackColor="#337AB7" Font-Bold="True" ForeColor="White" />
									</asp:Calendar>
									-->
							</div>
							<div class="col-md-6">
								<asp:Label ID="lFechaFin" runat="server" Text="Fecha de Fin" BorderColor="White" Font-Bold="True" ForeColor="White"></asp:Label>
								<div class="form-group">
									<div class='input-group date' id='datetimepicker2' dir="auto">
										<input type='text' class="form-control" id ="txtFechaHoraFin" runat="server" />
										<span class="input-group-addon">
										<span class="glyphicon glyphicon-calendar"></span>
										</span>
									</div>
								</div>
								<script type="text/javascript">
									$(function () {
									    $('#datetimepicker2').datetimepicker({
									        format: 'DD/MM/YYYY HH:mm'
									    });
									});
								</script>
								<!--<asp:Calendar ID="CalendarFin" runat="server" OnSelectionChanged="CalendarFin_SelectionChanged">
									<DayHeaderStyle BackColor="#007ACC" Font-Bold="True" ForeColor="White" />
									<DayStyle BackColor="White" ForeColor="#334666" />
									<TitleStyle BackColor="#337AB7" Font-Bold="True" ForeColor="White" />
									</asp:Calendar> -->
							</div>
						</div>
						<asp:Label ID="lLugar" runat="server" Text="Lugar" BorderColor="White" Font-Bold="True" ForeColor="White"></asp:Label>
						<br />
						<asp:TextBox ID="txtLugar" runat="server" OnTextChanged="TextBox5_TextChanged" Width="231px"></asp:TextBox>
						<br />
						<br />
						<asp:Label ID="lGuardar" runat="server" Text="Guardar" BorderColor="White" Font-Bold="True" ForeColor="White"></asp:Label>
						<br />
						<asp:ImageButton ID="ibAgregarTarea" runat="server" Height="61px" ImageUrl="~/Imagenes/AddTareaImg.png" OnClick="ibAgregarTarea_Click1" Width="59px" />
					</div>
				</div>
			</div>
		</form>
	</body>
</html>