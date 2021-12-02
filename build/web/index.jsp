<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link href="css/login.css" rel="stylesheet">
        <link rel="icon" type="image/png" sizes="16x16" href="assets/favicon-16x16.png">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>The System</title>
        <!--declaração de variável-->
        <%
            Statement st = null;
            ResultSet rs = null;
        %>

    </head>
    <body>
        <main>
            <div id="login">
                <h3 class="text-center text-white pt-5">The System</h3>
                <div class="container">
                    <div id="login-row" class="row justify-content-center align-items-center">
                        <div id="login-column" class="col-md-6">
                            <div id="login-box" class="col-md-12">
                                <form id="login-form" class="form" action="" method="post">
                                    <h3 class="text-center text-info">Login de Usuário:</h3>
                                    <div class="form-group">
                                        <label for="username" class="text-info">Usuário:</label><br>
                                        <input required type="text" name="txtusuario" id="username" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label for="password" class="text-info">Senha:</label><br>
                                        <input required type="password" name="txtsenha" id="password" class="form-control">
                                    </div>
                                    <div class="button">
                                        <input type="submit" name="submit" class="btn btn-info btn-md" value="Entrar">
                                    </div>
                                    <div class="button">
                                        <input  type="button" name="submit" class="btn btn-info btn-md" value="Cadastre-se aqui!">
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </body>
</html>
<!--Construção do código de Java-->
<%  String usuario = request.getParameter("txtusuario");
    String senha = request.getParameter("txtsenha");
    String nomeUsuario = "";
    String user = "", pass = "";
    int i = 0;
    try {
        st = new Conexao().conectar().createStatement();
        rs = st.executeQuery("Select *from usuarios where usuario='" + usuario + "' and senha='" + senha + "'");
        while (rs.next()) {
            user = rs.getString(3);
            pass = rs.getString(4);
            nomeUsuario = rs.getString(2);
            rs.last();
        }
    } catch (Exception e) {
        out.print(e);
    }
    if (usuario == null && senha == null) {
        
    } else {

        if (usuario.equals(user) && senha.equals(pass)) {
            session.setAttribute("nomeUsuario", nomeUsuario);

            response.sendRedirect("usuario.jsp");

        } else {
            out.println("Dados Incorretos");
        }
    }
%>
