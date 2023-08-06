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
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import rs.etf.sab.operations.UserOperations;

/**
 *
 * @author Korisnik
 */
public class ImpUserOperations implements UserOperations{

    private boolean checkInserted(String ime,String prezime,String sifra){
        Pattern reg1 = Pattern.compile("[A-Z].*");
        Matcher matcher1 = reg1.matcher(ime);
        boolean matchFound1 = matcher1.find();
        Pattern reg2 = Pattern.compile("[A-Z].*");
        Matcher matcher2 = reg2.matcher(prezime);
        boolean matchFound2 = matcher2.find();
        Pattern reg3 = Pattern.compile("\\W|_");
        Matcher matcher3 = reg3.matcher(sifra);
        boolean matchFound3 = matcher3.find();
        Pattern reg4 = Pattern.compile("[A-Z]");
        Matcher matcher4 = reg4.matcher(sifra);
        boolean matchFound4 = matcher4.find();
        Pattern reg5 = Pattern.compile("[a-z]");
        Matcher matcher5 = reg5.matcher(sifra);
        boolean matchFound5 = matcher5.find();
        Pattern reg6 = Pattern.compile("[0-9]");    
        Matcher matcher6 = reg6.matcher(sifra);
        boolean matchFound6 = matcher6.find();
        if(matchFound1 == false || matchFound2 == false || matchFound3 == false 
                || matchFound4 == false || matchFound5 == false || matchFound6 == false ||  sifra.length() < 8) return false;
        return true;
    }
    @Override
    public boolean insertUser(String userName, String ime, String prezime, String sifra, int IdA) {
        boolean ret = false;
       
        if(checkInserted(ime, prezime, sifra) == false){
            return false;
        }
        
        
        Connection conn = DB.getDB().getConnection();
        String qi = "insert into Korisnik (username,ime,prezime,password,IdA,tip) \n" +
                    "values(?,?,?,?,?,null) ";
        try(PreparedStatement pr = conn.prepareStatement(qi);) {
            
            pr.setString(1,userName);
            pr.setString(2,ime);
            pr.setString(3,prezime);            
            pr.setString(4,sifra);             
            pr.setInt(5,IdA);

            if(pr.executeUpdate() != 0)
                ret = true;
            
        } catch (SQLException ex) {
            ret = false;
        }
        
        return ret;
    }

    @Override
    public boolean declareAdmin(String userName) {
        boolean ret = false;
        Connection conn = DB.getDB().getConnection();
        String qi = "insert into Administrator (username,tip) \n" +
                    "values(?,?) ";
        try(PreparedStatement pr = conn.prepareStatement(qi);) {
            
            pr.setString(1,userName);
            pr.setString(2,"C");  
     
            if(pr.executeUpdate() != 0)
                ret = true;
            
        } catch (SQLException ex) {
            ret = false;
        }
        
        return ret;
    }
   
    @Override
    public int getSentPackages(String... strings) {
        int ret = 0;
        Connection conn = DB.getDB().getConnection();
        int numOfNotExisting = 0;
        for(int i = 0; i < strings.length;i++){
            try (PreparedStatement pr = conn.prepareStatement("select count(*) from Paket p where p.vlasnik = ?");
                 PreparedStatement prCheck = conn.prepareStatement("select username from Korisnik where username = ?");){
                
                prCheck.setString(1, strings[i]);
                ResultSet rscheck = prCheck.executeQuery();
                if(!rscheck.next())
                    numOfNotExisting++;
                else{
                    pr.setString(1, strings[i]);
                    ResultSet rs = pr.executeQuery();
                    if(rs.next()){
                        ret += rs.getInt(1);

                    }
                }
            } catch (SQLException ex) {
                ret = -1;
            }
        }
        if(numOfNotExisting == strings.length) ret = -1;
        return ret;
    }

    @Override
    public int deleteUsers(String... strings) {
        int ret = 0;
        Connection conn = DB.getDB().getConnection();
        String qi = " delete from Korisnik where username like ? ";
        for(int i = 0; i < strings.length;i++){
            try(PreparedStatement pr = conn.prepareStatement(qi);) {
               pr.setString(1,strings[i]);
               ret += pr.executeUpdate();
               
            } catch (SQLException ex) {
                ret = 0;
            }
        }
        return ret;
    }

    @Override
    public List<String> getAllUsers() {
        List<String> list = new ArrayList<>();
        Connection conn = DB.getDB().getConnection();
        String qi = " select username from Korisnik";
        try(PreparedStatement pr = conn.prepareStatement(qi);) {
         
           ResultSet rs = pr.executeQuery();
           while(rs.next()){
                list.add(rs.getString(1));
           }
            
        } catch (SQLException ex) {
            list = null;
        }
        return list;
    }
    
}
