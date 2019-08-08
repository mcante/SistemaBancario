<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.*"%>
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
                    <h1 class="page-header">Generar Estado de Cuenta</h1>
                </div>
            </div>
                
            <div class="row">
                
                <div class="panel-body">
                    <div class="col-lg-6">
                
                    <form action="serDebitosDepositivos" role="form">
                                               
                        <table border="0" width="300" align="left">
                            <tr>
                                <td> 
                                    <div class="form-group">
                                        <label>No. CUENTA</label>
                                        <input type="text" name="txtCuenta" value="" class="form-control" placeholder="Cta."/>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td> 
                                    <div class="form-group">
                                        <label>FECHA INICIAL</label>
                                        <input type="date" name="txtFechaInicio" value="" class="form-control" placeholder="Fecha Inicio" />
                                    </div>
                                </td>
                            </tr>
                            
                            <tr>
                                <td> 
                                    <div class="form-group">
                                        <label>FECHA FINAL</label>
                                        <input type="date" name="txtFechaFinal" value="" class="form-control" placeholder="Fecha Final"/>
                                    </div>
                                </td>
                            </tr>
                            
                            <th colspan="2">
                                <button type="submit" class="btn btn-primary" value="consultar" name="accion">Consultar</button>
                            </th> 
                        </table>
                    </form>
                    </div>
                </div>
        </div>            
            <%@include file="plantilla/componentes/mis_scritps.jsp" %>

        </div>

            
    </body>
    
    
</html>
