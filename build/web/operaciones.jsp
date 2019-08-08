<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.*"%>
<%@page import="beans.EstadoCuenta"%>
<%@page session="true"%>
<%!
double disponible=0.00;
String letras="";
%>
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
                    <h1 class="page-header">Estado de Cuenta  </h1>
                    <br>
                    
                </div>
            </div>
                
                
            <!-- /.row -->
            <div class="row">
                
                <div class="box-body">
                    
                    <div class="panel-body">
                        
                        <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">

                            <thead>
                                    
                                    <th>OPERACIÓN</th>
                                    <th>CUENTA</th>
                                    <th>NOMBRE</th>
                                    <th>EMPRESA</th>
                                    <th>ESTADO</th>
                                    <th>SALDO INICIAL</th>
                                    <th>MONTO</th>
                                    <th>SALDO FINAL</th>
                                    <th>EN LETRAS</th>
                                    <th>DOCUMENTO</th>
                                    <th>FECHA</th>
                                    <th>AGENCIA</th>
                                    <th>USUARIO</th>
                            </thead>
                                <tbody>

                                    <% 
                                        ArrayList<EstadoCuenta> lista=(ArrayList<EstadoCuenta>)request.getAttribute("lista");

                                    for (int i=0; i<lista.size(); i++) {
                                            EstadoCuenta o=lista.get(i);
                                    %>

                                    <tr>
                                        <td><%=o.getTipoOperacion()%></td>
                                        <td><%=o.getNoCuenta()%></td>
                                        <td><%=o.getNombre()%></td>
                                        <td><%=o.getEmpresa()%></td>
                                        <td><%=o.getEstado()%></td>
                                        <td>Q.<%=o.getSaldoInicial()%></td>
                                        <td>Q.<%=o.getMonto()%></td>
                                        <td>Q.<%=o.getSaldoFinal()%></td>
                                        <td><%=o.getLetras()%></td>
                                        <td><%=o.getTipoDocumento()%></td>
                                        <td><%=o.getFecha()%></td>
                                        <td><%=o.getAgencia() %></td>
                                        <td><%=o.getUsuario() %></td>
                                    </tr>
                                    <%
                                       disponible=Double.parseDouble(o.getSaldoFinal());
                                       letras=o.getLetras();
                                    }
                                    %>
                                </tbody>
                                    

                        </table>
                                <h1>Saldo Disponible: <%=letras %></h1>
                                <h1>Q.<%=disponible %></h1>
                                <%
                                    disponible=0.00;
                                    letras="";
                                %>
                    </div>
                <!-- /.row -->
            </div>
            <!-- /#page-wrapper -->       
            
            <%@include file="plantilla/componentes/mis_scritps.jsp" %>

        </div>

            
    </body>
</html>
