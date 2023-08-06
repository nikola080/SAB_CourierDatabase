
package rs.etf.sab.student;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;


public class DB {
    
    private static DB db = null;
    private static Connection connection;
    
    private static final String username = "sa";
    private static final String password = "123";
    private static final String database = "mn170505";
    private static final int port = 1433;
    private static final String server = "localhost";
    
    
    private static final String connectionUrl = 
            "jdbc:sqlserver://" + server + ":" +port+";databaseName="+database;
    

    private  DB(){
        try {
            connection = DriverManager.getConnection(connectionUrl, username, password);
        } catch (SQLException ex) {
            Logger.getLogger(DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public Connection getConnection() {
           return connection;
    }
    public static DB getDB(){
        if(db == null){
            db = new DB();
        }
        
        return db;
    }
}
