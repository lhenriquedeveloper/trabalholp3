<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String error = "";
%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
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
                                <form id="login-form" class="form rounded" action="" method="post">
                                    <h3 class="text-center text-info">Login de Usuário:</h3>
                                    <div class="form-group">
                                        <label for="username" class="text-info">Usuário:</label><br>
                                        <input required type="text" name="txtusuario" id="username" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label for="password" class="text-info">Senha:</label><br>
                                        <input required type="password" name="txtsenha" id="password" class="form-control">
                                    </div>
                                    <div class="mt-4 d-flex justify-content-between">

                                        <input type="submit" name="submit" class="btn btn-primary btn-md" value="Entrar">

                                        <a href="registrar.jsp" class="btn btn-secondary" role="button" >Cadastre-se aqui!</a>

                                    </div>
                                    <div class="text-danger text-center">
                                        <%
                                            String usuario = request.getParameter("txtusuario");
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
                                                    error = "Dados Incorretos";
                                                }
                                            }
                                        %>
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

