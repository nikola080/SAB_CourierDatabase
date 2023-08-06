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
import rs.etf.sab.operations.AddressOperations;

/**
 *
 * @author Korisnik
 */
public class ImpAddressOperations implements AddressOperations {

    @Override
    public int insertAddress(String string, int i, int i1, int i2, int i3) {
        int ret = -1;
        Connection conn = DB.getDB().getConnection();
        String qi = " insert into Adresa (ulica,broj,IdG,x,y) \n" +
                    "values(?,?,?,?,?) ";
        try(PreparedStatement pr = conn.prepareStatement(qi,Statement.RETURN_GENERATED_KEYS);) {
            
            pr.setString(1,string);
            pr.setInt(2,i);
            pr.setInt(3,i1);            
            pr.setInt(4,i2);            
            pr.setInt(5,i3);
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
    public int deleteAddresses(String nazivUlice, int brojUlice) {
        int ret = 0;
        Connection conn = DB.getDB().getConnection();
        String qi = " delete from Adresa where ulica like ? and broj = ? ";
        try(PreparedStatement pr = conn.prepareStatement(qi);) {
            pr.setString(1,nazivUlice);
            pr.setInt(2, brojUlice);
            ret += pr.executeUpdate();
           
            
        } catch (SQLException ex) {
            ret = 0;
        }
      
        return ret;
    }

    @Override
    public boolean deleteAdress(int i) {
        boolean ret = false;
        Connection conn = DB.getDB().getConnection();
        String qi = " delete from Adresa where IdA = ? ";
        try(PreparedStatement pr = conn.prepareStatement(qi);) {
            
           pr.setInt(1,i);
           if(pr.executeUpdate() != 0) 
               ret = true;
           
        } catch (SQLException ex) {
            ret = false;
        }
      
        return ret;
    }

    @Override
    public int deleteAllAddressesFromCity(int i) {
        int ret = 0;
        Connection conn = DB.getDB().getConnection();
        String qi = " delete from Adresa where IdG = ? ";
        try(PreparedStatement pr = conn.prepareStatement(qi);) {
         
            pr.setInt(1, i);
            ret += pr.executeUpdate();
           
            
        } catch (SQLException ex) {
            ret = 0;
        }
        
        return ret;
    }

    @Override
    public List<Integer> getAllAddresses() {
        List<Integer> list = new ArrayList<>();
        Connection conn = DB.getDB().getConnection();
        String qi = " select IdA from Adresa";
        try(PreparedStatement pr = conn.prepareStatement(qi);) {
         
           ResultSet rs = pr.executeQuery();
           while(rs.next()){
                list.add(rs.getInt(1));
           }
            
        } catch (SQLException ex) {
            list = null;
        }
        return list;
    }

    @Override
    public List<Integer> getAllAddressesFromCity(int i) {
         List<Integer> list = new ArrayList<>();
        Connection conn = DB.getDB().getConnection();
        String qi = " select IdA from Adresa where IdG = ?";
        try(PreparedStatement pr = conn.prepareStatement(qi);) {
           pr.setInt(1,i);
           ResultSet rs = pr.executeQuery();
           while(rs.next()){
                list.add(rs.getInt(1));
           }
            
        } catch (SQLException ex) {
            list = null;
        }
        if(list != null && list.isEmpty()) list = null;
        return list;
    }
    
}
