<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <script type="text/javascript" src="./cargar.js"></script>
        
    </head>
    <body>
        
        <div id="wrapper">
            <%@include file="plantilla/componentes/navegacion.jsp" %>
            
            
            <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Subir planilla</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>

            <div class="row">

                <form method="post" enctype="multipart/form-data" action="leerArchivo">
                    <input type="file" name="file"/>    <br /><br />
                    <input type="submit" value="Procesar Planilla" />
               </form>
                
                <iframe name="null" style="display: none;"></iframe>
                
            </div>

        </div>
        
            <%@include file="plantilla/componentes/mis_scritps.jsp" %>

        </div>
            

    </body>
</html>
