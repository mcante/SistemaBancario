<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.*"%>
<%@page import="beans.ClienteFull"%>
<%@page session="true"%>
<%
    String nombre="";
    String apellido="";
    String rol="";
    HttpSession sesionOK=request.getSession();
    if(sesionOK.getAttribute("usuario")==null){
    %>
    <jsp:forward page="login.jsp">
        <jsp:param name="msg" value="Tiene que loguearse"/>
    </jsp:forward>
     <%
        }else{
    nombre=(String)sesionOK.getAttribute("nombre");
    apellido=(String)sesionOK.getAttribute("apellido");
    rol=(String)sesionOK.getAttribute("rol");
        }
        %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/x-icon" href="../imagenes/favicon.ico">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="Melvin Canté">
        
        <title>Sistema Bancario UMG</title>
        
        <%@include file="plantilla/componentes/head.html" %>
        
        
    </head>
    <body>
        
        <div id="wrapper">
            <%@include file="plantilla/componentes/navegacion.jsp" %>
            
            
            <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Clientes  <a href="cliente_add.jsp"><img src="imagenes/insertar.png" width="80" height="80"> </a></h1>
                    <br>
                    
                </div>
            </div>
                
                
            <!-- /.row -->
            <div class="row">
                
                <div class="box-body">
                    
                    <div class="panel-body">
                        <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">

                            <thead>
                                    
                                    <th>CLIENTE</th>
                                    <th>NIT</th>
                                    <th>NOMBRE</th>
                                    <th>APELLIDO</th>
                                    <th>NIT_EMPR</th>
                                    <th>EMPRESA</th>
                                    <th>NO_CTA</th>
                                    <th>DISPONIBLE</th>
                                    <th>RESERVA</th>
                                    <th>TIPO</th>
                                    <th>ESTADO</th>
                                    <th>DPI</th>
                                    <th>PATENTE</th>
                            </thead>
                                <tbody>

                                    <% 
                                        ArrayList<ClienteFull> lista=(ArrayList<ClienteFull>)request.getAttribute("lista");

                                    for (int i=0; i<lista.size(); i++) {
                                            ClienteFull c=lista.get(i);
                                    %>

                                    <tr>
                                        <td><%=c.getId_cliente()%></td>
                                        <td><a href="serClientes?txtDpi=<%=c.getDpi()%>&accion=Editar"><%=c.getNIT()%></a></td>
                                        <td><%=c.getNOMBRE()%></td>
                                        <td><%=c.getAPELLIDO()%></td>
                                        <td><%=c.getNit_emp()%></td>
                                        <td><%=c.getEmpresa()%></td>
                                        <td><%=c.getNo_cuenta()%></td>
                                        <td>Q.<%=c.getSaldo_disponible()%></td>
                                        <td>Q.<%=c.getSaldo_reserva()%></td>
                                        <td><%=c.getTipo()%></td>
                                        <td><%=c.getStatus()%></td>
                                        <td><a href="serClientes?txtDpi=<%=c.getDpi()%>&accion=Editar"><%=c.getDpi()%></a></td>
                                        <td><%=c.getId_patente1()%></td>
                                    </tr>
                                    <%
                                    }
                                    %>
                                </tbody>
                                    

                        </table>
                    </div>
                <!-- /.row -->
            </div>
            <!-- /#page-wrapper -->       
            
            <%@include file="plantilla/componentes/mis_scritps.jsp" %>

        </div>

            
    </body>
</html>
