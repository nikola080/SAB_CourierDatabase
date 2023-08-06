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
import rs.etf.sab.operations.CourierRequestOperation;

/**
 *
 * @author Korisnik
 */
public class ImpCourierRequestOperation implements CourierRequestOperation{

    @Override
    public boolean insertCourierRequest(String userName, String driverLicenceNumber) {
        boolean ret = false;
        Connection conn = DB.getDB().getConnection();
        try(PreparedStatement pr = conn.prepareStatement("insert into ZahtevZaKurira values(?,?,null)");) {
            pr.setString(1, userName);
            pr.setString(2, driverLicenceNumber);
            
            if(pr.executeUpdate() != 0)
                ret = true;

        } catch (SQLException ex) {
            ret = false;
        }
        return ret;

    }

    @Override
    public boolean deleteCourierRequest(String userName) {
        boolean ret = false;
        Connection conn = DB.getDB().getConnection();
        try(PreparedStatement pr = conn.prepareStatement("delete from ZahtevZaKurira where username like ?");) {
            pr.setString(1, userName);
  
            if(pr.executeUpdate() != 0)
                ret = true;
            else ret = false;
        } catch (SQLException ex) {
            ret = false;
        }
        return ret;
    }

    @Override
    public boolean changeDriverLicenceNumberInCourierRequest(String userName, String licencePlateNumber) {
        boolean ret = false;
        Connection conn = DB.getDB().getConnection();
        try(PreparedStatement pr = conn.prepareStatement("update ZahtevZaKurira set br_vozacke = ? where username = ?");) {
            pr.setString(1, licencePlateNumber);
            pr.setString(2, userName);
            if(pr.executeUpdate() != 0)
                ret = true;

        } catch (SQLException ex) {
            ret = false;
        }
        return ret;
    }

    @Override
    public List<String> getAllCourierRequests() {
        List<String> ret = new ArrayList<>();
        Connection conn = DB.getDB().getConnection();
        String qi = "select username from ZahtevZaKurira";
        try(PreparedStatement pr = conn.prepareStatement(qi);) {
            
            ResultSet rs = pr.executeQuery();
            while(rs.next()){
                ret.add(rs.getString(1));
            }
                
         
        } catch (SQLException ex) {
           ret = null;
        }
        
        return ret;
    }

    @Override
    public boolean grantRequest(String username) {
       boolean ret = false;
        Connection conn = DB.getDB().getConnection();
        try(PreparedStatement pr = conn.prepareStatement("update ZahtevZaKurira set prihvaceno = 1 where username = ?");) {
            
            pr.setString(1, username);
            if(pr.executeUpdate() != 0){
                ret = true;
                deleteCourierRequest(username);
            }

        } catch (SQLException ex) {
            ret = false;
        }
        return ret;
    }
    
}
