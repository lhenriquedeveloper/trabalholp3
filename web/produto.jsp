<!--importação dos pacotes-->
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script><link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.css">
        <link href="css/usuario.css" rel="stylesheet">
        <link rel="icon" type="image/png" sizes="16x16" href="assets/favicon-16x16.png">
        <title>Produto</title>
        <!--declaração de variável-->
        <%
            Statement st = null;
            ResultSet rs = null;
        %>
    </head>

    <!DOCTYPE html>
    <body>
        <header>
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <div class="container-fluid">
                    <a class="navbar-brand" href="/">The System</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                            <li class="nav-item">
                                <a class="nav-link" href="usuario.jsp">Cadastro de Usuário</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="produto.jsp">Cadastro de Produto</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">Cadastro de Funcionário</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">Cadastro de Estado</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>

        <main>
            <div class="container">
                <div class="d-flex justify-content-between my-2">
                    <button type="button" class="btn btn-primary h-100 my-auto" data-bs-toggle="modal" data-bs-target="#exampleModal">
                        Adicionar Usuário
                    </button>


                    <form class="d-flex my-auto" method="post">
                        <input class="form-control" type="search" name="txtbuscar" placeholder="Buscar por Nome" aria-label="Search">
                        <button class="btn btn-outline-info" type="submit" name="btn-buscar">Buscar</button>
                    </form>
                </div>



                <table class="table table-striped table-sm">
                    <thead>
                        <tr>
                            <th scope="col">Nome</th>
                            <th scope="col">Valor</th>
                            <th scope="col">Quantidade</th>
                            <th scope="col">Ações</th>
                        </tr>
                    </thead>

                    <tbody>
                        <!-- Método para realizar uma busca -->
                        <%      try {
                                st = new Conexao().conectar().createStatement();
                                if (request.getParameter("btn-buscar") != null) {
                                    String buscar = '%' + request.getParameter("txtbuscar") + '%';
                                    rs = st.executeQuery("Select *from produto where nome like '" + buscar + "'");
                                } else {
                                    rs = st.executeQuery("Select *from produto"); //preencher tabela
                                }
                                while (rs.next()) {


                        %>
                        <tr>
                            <td><%= rs.getString(2)%></td>
                            <td><%= rs.getString(3)%></td>
                            <td> <%= rs.getString(4)%></td>
                            <td>
                                <a href="produto.jsp?funcao=editar&id=<%= rs.getString(1)%>"class="text-info" ><i class="fas fa-pencil-alt"></i>
                                </a>
                                <a href="produto.jsp?funcao=excluir&id=<%= rs.getString(1)%>"class="text-danger"><i class="fas fa-user-times"></i></a>
                            </td>
                        </tr>
                        <%   }
                            } catch (Exception e) {
                                out.print(e);
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </main>
        <!-- Modal - Formulário para cadastro de Produto -->
        <form>
            <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <!--Método para preencher as textbox para atualização-->
                            <%
                                String titulo = "";
                                String btn = "";
                                String idy = "";
                                String nomey = "";
                                String valory = "";
                                String quantidadey = "";
                                if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("editar")) {
                                    titulo = "Editar Produto";
                                    btn = "btn-editar";
                                    idy = request.getParameter("id");
                                    try {
                                        st = new Conexao().conectar().createStatement();
                                        rs = st.executeQuery("SELECT * FROM produto where id = '" + idy + "' ");
                                        while (rs.next()) {
                                            nomey = rs.getString(2);
                                            valory = rs.getString(3);
                                            quantidadey = rs.getString(4);

                                        }
                                    } catch (Exception e) {
                                        out.print(e);
                                    }

                                } else {
                                    titulo = "Inserir Produto";
                                    btn = "btn-salvar";
                                }
                            %>


                            <h5 class="modal-title" id="exampleModalLabel"><%=titulo%></h5>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <label for="name" class="text-info">Nome:</label><br>
                            <input value="<%=nomey%>"type="text" name="txtnome" id="username" class="form-control">

                            <label for="usuario" class="text-info">Valor:</label><br>
                            <input value="<%=valory%>" type="text" name="txtvalor" id="username" class="form-control">

                            <label for="senha" class="text-info">Quantidade:</label><br>
                            <input value="<%=quantidadey%>" type="text" name="txtquantidade" id="username" class="form-control">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
                            <button type="submit" name="<%=btn%>" class="btn btn-primary"><%=titulo%></button>
                        </div>
                    </div>
                </div>
            </div>
        </form>

        <script>
            var myModal = new bootstrap.Modal(document.getElementById('exampleModal'))
        </script>
    </body>


    <!--Método para salvar o dados-->
    <%    if (request.getParameter("btn-salvar") != null) {
            String nome = request.getParameter("txtnome");
            String valor = request.getParameter("txtvalor");
            String quantidade = request.getParameter("txtquantidade");

            st = new Conexao().conectar().createStatement();
            try {
                st.executeUpdate("Insert into produto (nomeProduto, Valor, Quantidade) values('" + nome + "','" + valor + "','" + quantidade + "')");
                response.sendRedirect("produto.jsp");

            } catch (Exception e) {
            }

        }
    %>

    <!--Método para atualização do dados-->
    <%    if (request.getParameter("btn-editar") != null) {
            String nome = request.getParameter("txtnome");
            String valor = request.getParameter("txtvalor");
            String quantidade = request.getParameter("txtquantidade");
            String id = request.getParameter("txtcodigo");

            st = new Conexao().conectar().createStatement();
            try {

                st.executeUpdate("update produto set nomeProduto= '" + nome + "', Valor= '" + valor + "',Quantidade='" + quantidade + "'where id='" + id + "'");
                response.sendRedirect("produto.jsp");
            } catch (Exception e) {
            }

        }
    %>

    <!--Método para excluir  do dados-->
    <%
        if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("excluir")) {
            String id = request.getParameter("id");

            try {

                st = new Conexao().conectar().createStatement();

                st.executeUpdate("delete from produto where id = '" + id + "'");
                response.sendRedirect("produto.jsp");

            } catch (Exception e) {
                out.print(e);
            }

        }


    %>
    <!--Função para editar o cadastro-->

    <%    if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("editar")) {
            out.print("<script>myModal.show();</script>");

        }
    %>
    <!--Função para um novo cadastro-->
    <%
        if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("novo")) {
            out.print("<script>myModal.show();</script>");
        }
    %>