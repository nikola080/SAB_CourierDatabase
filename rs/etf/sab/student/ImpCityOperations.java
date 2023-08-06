/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package rs.etf.sab.student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import rs.etf.sab.operations.CityOperations;

/**
 *
 * @author Korisnik
 */
public class ImpCityOperations implements CityOperations{

    @Override
    public int insertCity(String string, String string1) {
       int ret = -1;
       Connection conn = DB.getDB().getConnection();
       String qi = " insert into Grad (naziv,PB)\n" +
                    "values(?,?) ";
        try(PreparedStatement pr = conn.prepareStatement(qi,Statement.RETURN_GENERATED_KEYS);) {
            
            pr.setString(1, string); 
            pr.setString(2, string1);
            pr.executeUpdate();
            ResultSet rs = pr.getGeneratedKeys();
            if(rs.next()){
                ret = rs.getInt(1);
            }
            
        } catch (SQLException ex) {
            ret = -1;
        }
        //System.out.println(ret);
       return ret;
    }

    @Override
    public int deleteCity(String[] strings) {
       int ret = 0;
       Connection conn = DB.getDB().getConnection();
       String qi = " delete from Grad where naziv like ? ";
       int cnt = 0;
       while(cnt < strings.length){
            try(PreparedStatement pr = conn.prepareStatement(qi);) {
                     pr.setString(1,strings[cnt++]);
                     
                     ret += pr.executeUpdate();

             } catch (SQLException ex) {
                 ret = 0;
             }
       }
      // System.out.println("1 " + ret);
       return ret;
        
    }

    @Override
    public boolean deleteCity(int i) {
       boolean ret = false;
       Connection conn = DB.getDB().getConnection();
       String qi = " delete from Grad where IdG = ? ";
       try(PreparedStatement pr = conn.prepareStatement(qi);) {
            
            pr.setInt(1, i);
            if(pr.executeUpdate() != 0)
                ret = true;
            else ret = false;
            
       } catch (SQLException ex) {
           
           ret = false;
       }
       // System.out.println("2 " + ret);
       return ret;
    }

    @Override
    public List<Integer> getAllCities() {
        List<Integer> ret = new ArrayList<>();
        Connection conn = DB.getDB().getConnection();
        String qi = "select IdG from Grad";
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
