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
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import rs.etf.sab.operations.VehicleOperations;

/**
 *
 * @author Korisnik
 */
public class ImpVehicleOperations implements VehicleOperations{

    @Override
    public boolean insertVehicle(String licencePlateNumber, int fuelType, BigDecimal fuelConsumtion, BigDecimal capacity) {
        boolean ret = false;
        Connection conn = DB.getDB().getConnection();
        try (PreparedStatement pr = conn.prepareStatement("insert into Vozilo values(?,?,?,?,null)");){
            pr.setString(1, licencePlateNumber);
            pr.setInt(2,fuelType);
            pr.setBigDecimal(3, fuelConsumtion);
            pr.setBigDecimal(4, capacity);
            if(pr.executeUpdate() != 0) 
                ret = true;
        } catch (SQLException ex) {
            ret = false;
        }
        return ret;
    }

    @Override
    public int deleteVehicles(String... vozila) {
        int ret = 0;
        Connection conn = DB.getDB().getConnection();
        for(int i = 0; i < vozila.length;i++){
            try (PreparedStatement pr = conn.prepareStatement("delete from Vozilo where reg_broj = ?");){
                pr.setString(1, vozila[i]);
                if(pr.executeUpdate() != 0)
                    ret++;
            }  
            catch (SQLException ex) {
                ret = 0;
            }
        }
        return ret;
    }

    @Override
    public List<String> getAllVehichles() {
        List<String> ret = new ArrayList<>();
        Connection conn = DB.getDB().getConnection();
        try (PreparedStatement pr = conn.prepareStatement("select reg_broj from Vozilo");){
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
    public boolean changeFuelType(String licensePlateNumber, int fuelType) {
        boolean ret = false;
        Connection conn = DB.getDB().getConnection();
        try (PreparedStatement pr = conn.prepareStatement("update Vozilo set Vozilo.tip_goriva = ? where reg_broj like ?");){
            pr.setInt(1, fuelType);
            pr.setString(2, licensePlateNumber);
            if(pr.executeUpdate() != 0) 
                ret = true;
        } catch (SQLException ex) {
            ret = false;
        }
        return ret;
    }

    @Override
    public boolean changeConsumption(String licensePlateNumber, BigDecimal fuelConsumption) {
        boolean ret = false;
        Connection conn = DB.getDB().getConnection();
        try (PreparedStatement pr = conn.prepareStatement("update Vozilo set Vozilo.potrosnja = ? where reg_broj like ?");){
            pr.setBigDecimal(1, fuelConsumption);
            pr.setString(2, licensePlateNumber);
            if(pr.executeUpdate() != 0) 
                ret = true;
        } catch (SQLException ex) {
            ret = false;
        }
        return ret;
    }

    @Override
    public boolean changeCapacity(String licensePlateNumber, BigDecimal capacity) {
        boolean ret = false;
        Connection conn = DB.getDB().getConnection();
        try (PreparedStatement pr = conn.prepareStatement("update Vozilo set Vozilo.nosivost = ? where reg_broj like ?");){
            pr.setBigDecimal(1, capacity);
            pr.setString(2, licensePlateNumber);
            if(pr.executeUpdate() != 0) 
                ret = true;
        } catch (SQLException ex) {
            ret = false;
        }
        return ret; 
    }

    @Override
    public boolean parkVehicle(String licencePlateNumbers, int idStockroom) {
     boolean ret = false;
        Connection conn = DB.getDB().getConnection();
        try (PreparedStatement pr = conn.prepareStatement("update Vozilo set Vozilo.IdM = ? where reg_broj like ?");){
            pr.setInt(1, idStockroom);
            pr.setString(2, licencePlateNumbers);
            if(pr.executeUpdate() != 0) 
                ret = true;
        } catch (SQLException ex) {
            ret = false;
        }
        return ret; 
    }
    
    
}
