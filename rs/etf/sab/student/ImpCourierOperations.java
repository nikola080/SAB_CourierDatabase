/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rs.etf.sab.student;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import rs.etf.sab.operations.CourierOperations;

/**
 *
 * @author Korisnik
 */
public class ImpCourierOperations implements CourierOperations {

    @Override
    public boolean insertCourier(String courierUserName, String driverLicenceNumber) {
        boolean ret = false;
        Connection conn = DB.getDB().getConnection();
        String qi = "insert into Kurir  \n" +
                    "values(?,?,?,0) ";
        try(PreparedStatement pr = conn.prepareStatement(qi);) {
            
            pr.setString(1,courierUserName);
            pr.setString(2,"B");
            pr.setString(3,driverLicenceNumber);              
     
            if(pr.executeUpdate() != 0)
                ret = true;
            
        } catch (SQLException ex) {
            ret = false;
        }
        
        return ret;
    }

    @Override
    public boolean deleteCourier(String courierUserName) {
        boolean ret = false;
        Connection conn = DB.getDB().getConnection();
        String qi = " delete from Kurir where username like ? ";
        try(PreparedStatement pr = conn.prepareStatement(qi);) {
            pr.setString(1,courierUserName);
            if(pr.executeUpdate() != 0)
                ret = true;
        } catch (SQLException ex) {
           ret = false;
         }
        return ret;
    }

    @Override
    public List<String> getCouriersWithStatus(int i) {
        List<String> ret = new ArrayList<>();
        Connection conn = DB.getDB().getConnection();
        String qi = "select username from Kurir where status = ?";
        try(PreparedStatement pr = conn.prepareStatement(qi);) {
            pr.setInt(1, i);
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
    public List<String> getAllCouriers() {
        List<String> ret = new ArrayList<>();
        Connection conn = DB.getDB().getConnection();
        String qi = "select username from Kurir";
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
    public BigDecimal getAverageCourierProfit(int i) {
       BigDecimal ret = new BigDecimal(0);
       double rett = 0;
       
       Connection conn = DB.getDB().getConnection();
        try {
            String query = "";
            PreparedStatement ps;
            if(i == -1) {
                query = "select sum(profit) from Vozio group by username";
                ps =  conn.prepareStatement(query);
                
            }
            else {
                query = "select sum(profit) \n" +
                        "from Vozio \n" +
                        "where aktivno = 0 \n" + 
                        "group by username\n" +
                        "having sum(br_isporucenih_paketa) = ?  ";
                ps =  conn.prepareStatement(query);
                ps.setInt(1,i);
            }
            
            ps.setInt(1,i);
            ResultSet rs = ps.executeQuery();
            int cnt = 0;
            while(rs.next()){
                cnt++;
                rett += rs.getDouble(1);
            }
            
            rett /= cnt;
            ret = new BigDecimal(rett);
                
        } catch (SQLException ex) {
            Logger.getLogger(ImpCourierOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        //System.out.println(new DecimalFormat("#0.000000").format(ret));
        return ret;
    }
    
    
}
