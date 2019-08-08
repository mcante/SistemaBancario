<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.*"%>
<%@page import="beans.Cliente"%>
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
                    <h1 class="page-header">Personas  <a href="cliente_nuevo.jsp"><img src="imagenes/insertar.png" width="80" height="80"> </a></h1>
                    <br>
                    
                </div>
            </div>
                
                
            <!-- /.row -->
            <div class="row">
                
                <div class="box-body">
                    
                    <div class="panel-body">
                        <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">

                            <thead>
                                    <th>DPI</th>
                                    <th>NIT</th>
                                    <th>NOMBRE</th>
                                    <th>APELLIDO</th>
                                    <th>TELÉFONO</th>
                                    <th>DIRECCIÓN</th>
                                    <th>FECHA NAC.</th>
                                    <th>Acciones</th>
                            </thead>
                                <tbody>

                                    <% 
                                        ArrayList<Cliente> lista=(ArrayList<Cliente>)request.getAttribute("lista");

                                    for (int i=0; i<lista.size(); i++) {
                                            Cliente c=lista.get(i);
                                    %>

                                    <tr>
                                        <td><%=c.getDPI()%></td>
                                        <td><%=c.getNIT() %></td>
                                        <td><%=c.getNOMBRE()%></td>
                                        <td><%=c.getAPELLIDO()%></td>
                                        <td><%=c.getDIRECCION()%></td>
                                        <td><%=c.getFECHA_NACIMIENTO()%></td>
                                        <td><%=c.getNO_TELEFONO()%></td>
                                        <td>
                                            <form action="serClientes">
                                                <input type="hidden" name="txtDpi" value="<%=c.getDPI()%>" />
                                                <input class="btn btn-primary" type="submit" value="Editar" name="accion" />
                                                
                                                
                                            </form>
                                        </td>
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
