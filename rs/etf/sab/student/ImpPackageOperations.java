/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rs.etf.sab.student;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import rs.etf.sab.operations.PackageOperations;

/**
 *
 * @author Korisnik
 */
public class ImpPackageOperations implements PackageOperations{

    @Override
    public int insertPackage(int adresaOd, int adresaDo, String username, int tipPaketa, BigDecimal tezina) {
        int ret = -1;
        Connection conn = DB.getDB().getConnection();
        String qi = "insert into Paket (pocetno_mesto,kranje_mesto,vlasnik,tip_paketa,tezina,Date_kreiranja,status,trenutno_mesto) "
                +   "values(?,?,?,?,?,GETDATE(),?,?)";
        try(PreparedStatement pr = conn.prepareStatement(qi,Statement.RETURN_GENERATED_KEYS);) {
            
            pr.setInt(1,adresaOd);
            pr.setInt(2,adresaDo);
            pr.setString(3,username);
            pr.setInt(4,tipPaketa);
            if(tezina == null){
                pr.setBigDecimal(5, new BigDecimal(10));
            }
            else pr.setBigDecimal(5, tezina);
            pr.setInt(6,0);
            pr.setInt(7,adresaOd);
            
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
    public boolean acceptAnOffer(int i) {
        
        boolean ret = false;
        Connection conn = DB.getDB().getConnection();
        String qi = "update Ponuda set prihvacena = 1 where IdP = ?";
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
    public boolean rejectAnOffer(int i) {
        boolean ret = false;
        Connection conn = DB.getDB().getConnection();
        String qi = "update Ponuda set prihvacena = 0 where IdP = ?";
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
    public List<Integer> getAllPackages() {
       List<Integer> ret = new ArrayList<>();
       Connection conn = DB.getDB().getConnection();
       String qi = "select IdP from Paket";
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

    @Override
    public List<Integer> getAllPackagesWithSpecificType(int i) {
       List<Integer> ret = new ArrayList<>();
       Connection conn = DB.getDB().getConnection();
       String qi = "select IdP from Paket where tip_paketa = ?";
       try(PreparedStatement pr = conn.prepareStatement(qi);) {
            pr.setInt(1,i);
            ResultSet rs = pr.executeQuery();
            while(rs.next()){
                ret.add(rs.getInt(1));
            }
                
         
       } catch (SQLException ex) {
           ret = null;
       }
       
       return ret;
    }

    @Override
    public List<Integer> getAllUndeliveredPackages() {
        List<Integer> ret = new ArrayList<>();
        Connection conn = DB.getDB().getConnection();
        String qi = "select IdP from Paket where status = 1 or status = 2";
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

    @Override
    public List<Integer> getAllUndeliveredPackagesFromCity(int i) {
        List<Integer> ret = new ArrayList<>();
        Connection conn = DB.getDB().getConnection();
        String qi = "select IdP from Paket p  where status = 1 or status = 2 and p.pocetno_mesto in (select IdA from Adresa where IdG = ?)";
        try(PreparedStatement pr = conn.prepareStatement(qi);) {
            pr.setInt(1,i);
            ResultSet rs = pr.executeQuery();
            while(rs.next()){
                ret.add(rs.getInt(1));
            }
                
         
        } catch (SQLException ex) {
            ret = null;
        }
       
        return ret;
    }

    @Override
    public List<Integer> getAllPackagesCurrentlyAtCity(int i) {
        List<Integer> ret = new ArrayList<>();
        Connection conn = DB.getDB().getConnection();
        String qi = "select IdP \n" +
                    "from Paket \n" +
                    "where ((trenutno_mesto = pocetno_mesto and status = 1) or (trenutno_mesto = kranje_mesto and status = 3) or \n" +
                    "(status = 2 and IdM is not null)) and  trenutno_mesto in (select a.IdA from Adresa a where a.IdG = ?)";
        try(PreparedStatement pr = conn.prepareStatement(qi);) {
            pr.setInt(1,i);
            ResultSet rs = pr.executeQuery();
            while(rs.next()){
                ret.add(rs.getInt(1));
            }
                
         
        } catch (SQLException ex) {
            ret = null;
        }
       
        return ret;
    }

    @Override
    public boolean deletePackage(int i) {
        boolean ret = false;
        Connection conn = DB.getDB().getConnection();
        String qi = "delete from Ponuda where IdP = ?";
        String qi1 = "delete from Paket where IdP = ?";
        
        try(PreparedStatement pr = conn.prepareStatement(qi);) {          
           pr.setInt(1,i);
           pr.executeUpdate();
            
        } catch (SQLException ex) {
            return false;
        }
        
         try(PreparedStatement pr1 = conn.prepareStatement(qi1);) {          
           pr1.setInt(1,i);
           if(pr1.executeUpdate() != 0) 
               ret = true;
            
        } catch (SQLException ex) {
            return false;
        }
      
      
        return ret;
    }

    @Override
    public boolean changeWeight(int i, BigDecimal bd) {
        boolean ret = false;
        Connection conn = DB.getDB().getConnection();
        String qi = "update Paket set tezina = ? where IdP = ?";
        try(PreparedStatement pr = conn.prepareStatement(qi);) {          
           pr.setBigDecimal(1,bd);
           pr.setInt(2, i);
           if(pr.executeUpdate() != 0) 
               ret = true;
            
        } catch (SQLException ex) {
            ret = false;
        }
      
        return ret;
    }

    @Override
    public boolean changeType(int i, int i1) {
        boolean ret = false;
        Connection conn = DB.getDB().getConnection();
        String qi = "update Paket set tip_paketa = ? where IdP = ?";
        try(PreparedStatement pr = conn.prepareStatement(qi);) {          
           pr.setInt(1,i1);
           pr.setInt(2, i);
           if(pr.executeUpdate() != 0) 
               ret = true;
            
        } catch (SQLException ex) {
            ret = false;
        }
      
        return ret;
    }

    @Override
    public int getDeliveryStatus(int i) {
        int ret = -1;
        Connection conn = DB.getDB().getConnection();
        String qi = "select status from Paket where IdP = ?";
        try(PreparedStatement pr = conn.prepareStatement(qi);) {          
           pr.setInt(1, i);
           ResultSet rs = pr.executeQuery();
           if(rs.next()){
               ret = rs.getInt(1);
           }
              
            
        } catch (SQLException ex) {
            ret = -1;
        }
      
        return ret;
    }

    @Override
    public BigDecimal getPriceOfDelivery(int i) {
        BigDecimal ret = new BigDecimal(-1);
        Connection conn = DB.getDB().getConnection();
        String qi = "select cena from Ponuda where IdP = ?";
        try(PreparedStatement pr = conn.prepareStatement(qi);) {          
           pr.setInt(1, i);
           ResultSet rs = pr.executeQuery();
           if(rs.next()){
               ret = rs.getBigDecimal(1);
           }
              
            
        } catch (SQLException ex) {
            ret = new BigDecimal(-1);;
        }
      
        return ret;
    }
   
    @Override
    public int getCurrentLocationOfPackage(int i) {
        int ret = -1;
        //if(!checkIsPackageInRide(i)) return ret;
        Connection conn = DB.getDB().getConnection();
        String qi = "select a.IdG from Paket p join Adresa a on p.trenutno_mesto = a.IdA where p.IdP = ? and p.status != 2";
        try(PreparedStatement pr = conn.prepareStatement(qi);) {          
           pr.setInt(1, i);
           ResultSet rs = pr.executeQuery();
           if(rs.next()){
               ret = rs.getInt(1);
           }
              
            
        } catch (SQLException ex) {
            ret = -1;
        }
      
        return ret;
    }

    @Override
    public Date getAcceptanceTime(int i) {
        
        Date ret = null;
        Connection conn = DB.getDB().getConnection();
        String qi = "select Date_prihvatanja from Paket where IdP = ?";
        try(PreparedStatement pr = conn.prepareStatement(qi);) {          
           pr.setInt(1, i);
           ResultSet rs = pr.executeQuery();
           if(rs.next()){
               ret = rs.getDate(1);
           }
              
            
        } catch (SQLException ex) {
            ret = null;
        }
      
        return ret;
    }
    
}
