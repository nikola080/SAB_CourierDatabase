/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rs.etf.sab.student;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import rs.etf.sab.operations.StockroomOperations;

/**
 *
 * @author Korisnik
 */
public class ImpStockroomOperations implements StockroomOperations{

    @Override
    public int insertStockroom(int address) {
        int ret = -1;
        Connection conn = DB.getDB().getConnection();
        try ( PreparedStatement pr = conn.prepareStatement("insert into Magacin values(?)",Statement.RETURN_GENERATED_KEYS); ){
           pr.setInt(1,address);
           pr.executeUpdate();
           ResultSet rs = pr.getGeneratedKeys();
           if(rs.next()){
               ret = rs.getInt(1);
           }    
        } catch (SQLException ex) {
            ret = -1;
        }
        return ret;
    }

    @Override
    public boolean deleteStockroom(int idStockroom) {
        boolean ret = false;
        Connection conn = DB.getDB().getConnection();
        try ( PreparedStatement pr = conn.prepareStatement("delete from Magacin where IdM = ?"); ){
           pr.setInt(1,idStockroom);
           if(pr.executeUpdate() != 0){
               ret = true;
           }                
        } catch (SQLException ex) {
            ret = false;
        }
        return ret;
    }

    @Override
    public int deleteStockroomFromCity(int idCity) {
        int ret = -1;
        Connection conn = DB.getDB().getConnection();
        
        try ( PreparedStatement pr = conn.prepareStatement("select IdM from Magacin where IdA in (select a.IdA from Adresa a where a.IdG = ?)"); ){
           pr.setInt(1,idCity);
           
           ResultSet rs = pr.executeQuery();
           if(rs.next())
                ret = rs.getInt(1);
           
           else return -1;
           
                  
        } catch (SQLException ex) {
            ret = -1;
        }
        
        try ( PreparedStatement pr = conn.prepareStatement("delete from Magacin where IdA in (select a.IdA from Adresa a where a.IdG = ?)"); ){
           pr.setInt(1,idCity);
           pr.executeUpdate();       
        } catch (SQLException ex) {
            ret = -1;
        }
        return ret;
    }

    @Override
    public List<Integer> getAllStockrooms() {
        List<Integer> ret = new ArrayList<>();
        Connection conn = DB.getDB().getConnection();
        String qi = "select IdM from Magacin";
        try(PreparedStatement pr = conn.prepareStatement(qi);) {
            
            ResultSet rs = pr.executeQuery();
            while(rs.next()){
                ret.add(rs.getInt(1));
            }
                
         
        } catch (SQLException ex) {
           ret = null;
        }
       
        return ret;
    }
}
