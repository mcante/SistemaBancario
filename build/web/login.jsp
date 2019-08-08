<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/x-icon" href="../imagenes/favicon.ico">
        <title>Login</title>
        <link href="css/estilo.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <div id="cuadro">
            <form action="servletLogueo" method="post">
                <p id="titulo">INICIAR SESIÓN</p>
                <hr>
                <br/><br/>
                <label id="subtitulo">NOMBRE DE USUARIO</label>
                <br/><br/>
                <input type="text" name="TxtUsuario" class="entrada" />
                <label id="subtitulo2">CONTRASEÑA</label>
                <br/><br/>
                <input type="password" name="TxtPassword" class="entrada" />
                <br/><br/>
                <input type="submit" value="Iniciar Sesión" id="boton" />
            </form>
            
        </div>
        
        
        <h3 align="center">    
            <%
            if(request.getAttribute("msg")!=null)
                out.println(request.getAttribute("msg"));
            if(request.getParameter("msg")!=null)
                out.println(request.getParameter("msg"));
            %>
        </h3>
    </body>
</html>
