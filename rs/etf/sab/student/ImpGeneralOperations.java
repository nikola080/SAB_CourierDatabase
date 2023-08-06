/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rs.etf.sab.student;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import rs.etf.sab.operations.GeneralOperations;
/**
 *
 * @author Korisnik
 */
public class ImpGeneralOperations implements GeneralOperations{

    @Override
    public void eraseAll() {
     
       Connection conn = DB.getDB().getConnection();
    
      
       String qi = "	delete from ZahtevZaKurira where 1=1\n" +
"                    delete from Vozi where 1=1\n" +
"                    delete from Vozio where 1=1\n" +
"                    delete from Administrator where 1=1\n" +
"                    delete from Ponuda where 1=1\n" +
"                    delete from Paket where 1=1\n" +
"                    delete from Kurir where 1=1\n" +
"                    delete from Kupac where 1=1\n" +
"                    delete from Vozilo where 1=1\n" +
"                    delete from Magacin where 1=1\n" +
"					delete from Korisnik where 1=1\n" +
"                    delete from Adresa where 1=1\n" +
"                    delete from Grad where 1=1";
       
       //String qi = "{ call gomu_gomu_database_no_more }";
        try(PreparedStatement pr = conn.prepareStatement(qi)) {
            
            pr.execute();

        } catch (SQLException ex) {
             
        }
   
       
    }
    
}
