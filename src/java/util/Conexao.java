/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Usuário
 */
public class Conexao {

    public Connection conectar() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            return DriverManager.getConnection("jdbc:mysql://140.238.185.221:3306/thesystem?useTimezone=true&serverTimezone=UTC&user=alunos&password=?NW3A6J!vRhgtJ(-");

        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
}
