/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rs.etf.sab.student;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.ListIterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jdk.internal.org.objectweb.asm.Type;
import rs.etf.sab.operations.DriveOperation;

/**
 *
 * @author Korisnik
 */
public class ImpDriveOperations implements DriveOperation{
    
    private static HashMap<String,ArrayList<Paket>> packages = new HashMap<String,ArrayList<Paket>>();
    
    private ArrayList<Paket> paketiIstoMesto(int IdA, ArrayList<Paket> list){
        ArrayList<Paket> ret = new ArrayList<Paket>();
        Iterator<Paket> it = list.iterator();
        Paket pom = null;
        while(it.hasNext()){
            pom = it.next();
            if(pom.getTrenutno_mesto()== IdA)
                ret.add(pom);
        }
        return ret;
    }
    
    private ArrayList<Paket> paketiPoRedosledu(int index, ArrayList<Paket> list){
        Iterator<Paket> it = list.iterator();
        ArrayList<Paket> paketi = new ArrayList<Paket>();
        Paket p = null;
        while(it.hasNext()){
            
            p = it.next();
            if(p.getRedosled_istovar() == index || p.getRedosled_utovar() == index) paketi.add(p);
        }
        
        return paketi;
    }
    
    private ArrayList<Paket> paketiPoMestuIstovara(int mesto, ArrayList<Paket> list){
        Iterator<Paket> it = list.iterator();
        ArrayList<Paket> paketi = new ArrayList<Paket>();
        Paket p = null;
        while(it.hasNext()){
            
            p = it.next();
            if(p.getKranje_mesto() == mesto) paketi.add(p);
        }
        
        return paketi;
    }
    
    private boolean imaPaketa_uGradu(int IdG, ArrayList<Paket> list){
        boolean ret = false;
        Iterator<Paket> it = list.iterator();
        
        Connection conn = DB.getDB().getConnection();
        String qr = "select p.IdP from Paket p where p.IdA in (select a.IdA from Adresa a where a.IdG = ?)";
        try(PreparedStatement ps1 = conn.prepareStatement(qr);){
            ps1.setInt(1, IdG);
            ResultSet rs1 = ps1.executeQuery();
            if(rs1.next()) ret = true;
             
        }
        catch(SQLException ex){
        }
        
        return ret;
    }
    private boolean proveraKraj(ArrayList<Paket> list){
        boolean ret = true;
        Iterator<Paket> it = list.iterator();
        int flag0 = it.next().getKranje_mesto();
        it = list.iterator();
        int flag1;
        while(it.hasNext()){
            flag1 = it.next().getKranje_mesto();
            if(flag1 != flag0) return false;
        }
        
        
        return ret;
    }
    
    
    @Override
    public boolean planingDrive(String courierUsername) {
        boolean ret = false;
        
        
        Connection conn = DB.getDB().getConnection();
        String vozila =  "select top 1 v.reg_broj as reg_broj, v.nosivost as nosivost "
                       + "from Vozilo v "
                       + "where v.IdM = "
                       + "(select m.IdM from Magacin m  where "
                        + "( select g1.IdG from Grad g1 where g1.IdG = (select a1.IdG from Adresa a1 where a1.IdA = m.IdA)) = "
                        + "(select g2.IdG from Grad g2 where g2.IdG = "
                             + "(select a2.IdG from Adresa a2 where a2.IdA = (select k.IdA from Korisnik k where k.username like ?))))"
                        + "and v.reg_broj not in (select vv.reg_broj from Vozi vv)";
        String querry0 = "select p.status as status, p.IdP as IdP,\n" +
                            "p.pocetno_mesto as pocetno_mesto,\n" +
                            "p.kranje_mesto as kranje_mesto,\n" +
                            "p.tezina as tezina,\n" +
                            "p.trenutno_mesto as trenutno_mesto,\n" +
                            "p.Date_prihvatanja as Date_prihvatanja,\n" +
                            "coalesce(p.IdM ,0) as IdM ,\n" +
                            "coalesce(p.redosled_utovar ,0) as redosled_utovar,\n" +
                            "coalesce(p.redosled_istovar,0) as redosled_istovar,\n" +
                            "coalesce(p.vozac ,0) as vozac,\n" +
                            "coalesce(p.reg_broj ,0) as reg_broj,\n" +
                            "coalesce(p.pokupljeno_usput ,0) as pokupljeno_usput \n" +
                            "from Paket p\n" +
                            "where (p.status = 1 or (p.status = 2 and vozac is null)) and (select a1.IdG from Adresa a1 where a1.IdA = p.trenutno_mesto) = (select a2.IdG from Adresa a2 where a2.IdA = (select k.IdA from Korisnik k where k.username like ?))";
        String querry1 = "update Paket set redosled_utovar = ? where IdP = ?";
        String querry2 = "update Paket set vozac = ? where IdP = ?";
        String querry3 = "update Paket set reg_broj = ? where IdP = ?";
        String querry4 = "update Paket set redosled_istovar = ? where IdP = ?";
        String querry5 = "{? = call euklidskaDistanca(?,?)}";
        String querry6 = "select g.IdG as IdG from Grad g where g.IdG = (select a.IdG from Adresa a where a.IdA = (select k.IdA from Korisnik k where k.username like ?))";
        String querry7 = "select g.IdG as IdG from Grad g where g.IdG = (select a.IdG from Adresa a where a.IdA = ?)";
        String querry8 = "select p.status as status, p.IdP as IdP,\n" +
                            "p.pocetno_mesto as pocetno_mesto,\n" +
                            "p.kranje_mesto as kranje_mesto,\n" +
                            "p.tezina as tezina,\n" +
                            "p.trenutno_mesto as trenutno_mesto,\n" +
                            "p.Date_prihvatanja as Date_prihvatanja,\n" +
                            "coalesce(p.IdM ,0) as IdM ,\n" +
                            "coalesce(p.redosled_utovar ,0) as redosled_utovar,\n" +
                            "coalesce(p.redosled_istovar,0) as redosled_istovar,\n" +
                            "coalesce(p.vozac ,0) as vozac,\n" +
                            "coalesce(p.reg_broj ,0) as reg_broj,\n" +
                            "coalesce(p.pokupljeno_usput ,0) as pokupljeno_usput \n" +
                            "from Paket p join Adresa a on p.trenutno_mesto = a.IdA\n" +
                            "where (p.status = 1 or (p.status = 2 and vozac is null)) and a.IdG = (select g.IdG from Grad g where g.IdG = ?) ";
        String querry9 = "update Paket set pokupljeno_usput = 1 where IdP = ?";
        String querry10 = "insert into Vozi values(?,?,?,?,?,?)";
        String querry11 = "select m.IdA from Magacin m where (select a1.IdG from Adresa a1 where a1.IdA = m.IdA ) = "
                        + "( select a2.IdG from Adresa a2 where a2.IdA = (select k.IdA from Korisnik k where k.username like ?))";
        String querry12 = "select p.IdP\n" +
                          "from Paket p join Adresa a on p.pocetno_mesto = a.IdA\n" +
                          "where a.IdG = ? and redosled_utovar != 0";
        String querry13 = "update Kurir set status = 1 where username like ?";
        String querry14 = "insert into Vozio values(?,(select reg_broj from Vozi where vozac like ?),0,0,1)";
        try (PreparedStatement ps1 = conn.prepareStatement(vozila);
             PreparedStatement ps2 = conn.prepareStatement(querry0);
             PreparedStatement ps3 = conn.prepareStatement(querry1);
             PreparedStatement ps4 = conn.prepareStatement(querry2); 
             PreparedStatement ps5 = conn.prepareStatement(querry3);
             PreparedStatement ps6 = conn.prepareStatement(querry4);
             CallableStatement cs1 = conn.prepareCall(querry5);
             PreparedStatement ps7 = conn.prepareStatement(querry6);
             PreparedStatement ps8 = conn.prepareStatement(querry7);
             PreparedStatement ps9 = conn.prepareStatement(querry8);  
             PreparedStatement ps10 = conn.prepareStatement(querry9);
             PreparedStatement ps11 = conn.prepareStatement(querry10);
             PreparedStatement ps12 = conn.prepareStatement(querry11);
             PreparedStatement ps13 = conn.prepareStatement(querry12);
             PreparedStatement ps14 = conn.prepareStatement(querry13);
             PreparedStatement ps15 = conn.prepareStatement(querry14);   
             
            )
        {
            Paket pom;
            Paket p;
            String vozilo = "";
            double kapacitetVozila = 0;
            double popunjenost = 0;
            int trenutno_mesto = 0;
            int prethodno_mesto = 0;
            ArrayList<Paket> paketi = new ArrayList<Paket>();
            
            ps1.setString(1, courierUsername);
            ResultSet rs1 = ps1.executeQuery();
            if(rs1.next()){
                vozilo = rs1.getString(1);
                kapacitetVozila = rs1.getDouble(2);
            }
            else return false;
            
            ps14.setString(1,courierUsername);
            ps14.executeUpdate();
            ps2.setString(1, courierUsername);
            ResultSet rs2 = ps2.executeQuery();
            
            if(rs2.next()){
                
                do{
                    p = new Paket(rs2.getInt("IdP"),rs2.getInt("pocetno_mesto"),
                    rs2.getInt("kranje_mesto"),rs2.getTimestamp("Date_prihvatanja"),rs2.getInt("redosled_utovar"),
                    rs2.getInt("redosled_istovar"),rs2.getInt("tezina"),rs2.getString("vozac"),rs2.getString("reg_broj"),
                    rs2.getInt("trenutno_mesto"),rs2.getBoolean("pokupljeno_usput"),rs2.getInt("IdM"),rs2.getInt("status"));
                    paketi.add(p);
                }
                while(rs2.next());
            }
            else return false;

            
            ps12.setString(1,courierUsername);
            ResultSet rs12 = ps12.executeQuery();
            rs12.next();
            
            ps11.setString(1,courierUsername);
            ps11.setString(2,vozilo);
            ps11.setDouble(3,0);
            ps11.setDouble(4,0);
            ps11.setInt(5,rs12.getInt(1));
            ps11.setInt(6,1);
            ps11.execute();
            
            ps15.setString(1, courierUsername);
            ps15.setString(2, courierUsername);
            ps15.execute();
            
            paketi.sort(Comparator.comparing(Paket::getDate_prihvatanja));
            int i = 1;
            Iterator<Paket> it1 = paketi.iterator();
            ArrayList<Paket> paketiSaIstomAdresom = new ArrayList<Paket>();
            while(it1.hasNext()){
                
                p = it1.next();
                if(p.getMagacin() == 0 && popunjenost + p.getTezina() <= kapacitetVozila){
                   
                    if(p.getRedosled_utovar() == 0){
                        paketiSaIstomAdresom = this.paketiIstoMesto(p.getPocetno_mesto(), paketi);
                        Iterator<Paket> itt = paketiSaIstomAdresom.iterator();
                        while(itt.hasNext()){
                            pom = itt.next();
                            pom.setRedosled_utovar(i);
                            pom.setReg_broj(vozilo);
                            pom.setVozac(courierUsername);
                            ps3.setInt(1, i);
                            ps3.setInt(2, pom.getId());
                            ps3.executeUpdate();
                            ps4.setString(1, courierUsername);
                            ps4.setInt(2, pom.getId());
                            ps4.executeUpdate();
                            ps5.setString(1, vozilo);
                            ps5.setInt(2, pom.getId());
                            ps5.executeUpdate();
                              
                            popunjenost += pom.getTezina();
                            trenutno_mesto = pom.getPocetno_mesto();
                        }
                        i++;
                       
                   }
                }
                else if(p.getRedosled_utovar() == 0  && p.getMagacin() == 0) paketi.remove(p);
            }
            
            it1 = paketi.iterator();
 
            while(it1.hasNext()){
                
                p = it1.next();
                if(p.getMagacin() != 0 && popunjenost + p.getTezina() <= kapacitetVozila){
                   
                    if(p.getRedosled_utovar() == 0){
                        paketiSaIstomAdresom = this.paketiIstoMesto(p.getTrenutno_mesto(), paketi);
                        Iterator<Paket> itt = paketiSaIstomAdresom.iterator();
                        while(itt.hasNext()){
                            pom = itt.next();
                            pom.setRedosled_utovar(i);
                            pom.setReg_broj(vozilo);
                            pom.setVozac(courierUsername);
                            ps3.setInt(1, i);
                            ps3.setInt(2, pom.getId());
                            ps3.executeUpdate();
                            ps4.setString(1, courierUsername);
                            ps4.setInt(2, pom.getId());
                            ps4.executeUpdate();
                            ps5.setString(1, vozilo);
                            ps5.setInt(2, pom.getId());
                            ps5.executeUpdate();
                              
                            popunjenost += pom.getTezina();
                            trenutno_mesto = pom.getTrenutno_mesto();
                        }
                        i++;
                       
                   }
                }
                else if(p.getRedosled_utovar() == 0  && p.getMagacin() != 0) paketi.remove(p);
            }
            
            int pocetniGrad = 0;
            ps7.setString(1,courierUsername);
            ResultSet rs7 = ps7.executeQuery();
            rs7.next();
            pocetniGrad = rs7.getInt(1);
           
            //ps7.setInt();
            //ResultSet rs8 = ps8.executeQuery();
            //rs7.next();
            
            // krece se u isporuku pocetnih paketa 
            paketi.sort(Comparator.comparing(Paket::getRedosled_utovar));
            int trenutniGrad = 0;
            int sledeciGrad = 0;
            double minDist = 0;
            Paket sledeci = null;
            Iterator<Paket> it2 = paketi.iterator();
            ArrayList<Paket> batchPackages = new ArrayList<Paket>();
            ResultSet rs8;
            ResultSet rs9;
            ResultSet rs13;
            ArrayList<Paket> paketiZaVracanje = new ArrayList<Paket>();
            boolean idiDalje = false;
            boolean tryLast = true;
            
            while(!paketi.isEmpty() || tryLast){  
                
                ps8.setInt(1, trenutno_mesto);
                rs8 = ps8.executeQuery();
                rs8.next();
                trenutniGrad = rs8.getInt(1);
           
                
                if(trenutniGrad != pocetniGrad && !this.imaPaketa_uGradu(trenutniGrad, paketi) && !idiDalje ){
                    
                    
                    ps13.setInt(1, trenutniGrad);
                    rs13 = ps13.executeQuery();
                    if(rs13.next()) {
                        idiDalje = true;
                        continue;
                    }
                    
                    
                    ps9.setInt(1, trenutniGrad);
                    rs9 = ps9.executeQuery();
                    
                    while(rs9.next()){
                        pom = new Paket(rs9.getInt("IdP"),rs9.getInt("pocetno_mesto"),
                        rs9.getInt("kranje_mesto"),rs9.getTimestamp("Date_prihvatanja"),rs9.getInt("redosled_utovar"),
                        rs9.getInt("redosled_istovar"),rs9.getInt("tezina"),rs9.getString("vozac"),rs9.getString("reg_broj"),
                        rs9.getInt("trenutno_mesto"),rs9.getBoolean("pokupljeno_usput"),rs9.getInt("IdM"),rs9.getInt("status"));
                        paketiZaVracanje.add(pom);
                        
                    }
                    
                    paketiZaVracanje.sort(Comparator.comparing(Paket::getDate_prihvatanja));
                    it1 = paketiZaVracanje.iterator();
                    
                    while(it1.hasNext()){
                
                    p = it1.next();
                    if(p.getMagacin() == 0 && popunjenost + p.getTezina() <= kapacitetVozila){

                        if(p.getRedosled_utovar() == 0){
                            paketiSaIstomAdresom = this.paketiIstoMesto(p.getPocetno_mesto(), paketiZaVracanje);
                            Iterator<Paket> itt = paketiSaIstomAdresom.iterator();
                            while(itt.hasNext()){
                                pom = itt.next();    
                                pom.setRedosled_utovar(i);
                                pom.setReg_broj(vozilo);
                                pom.setVozac(courierUsername);
                                pom.setPokuljeno_usput(true);
                                ps3.setInt(1, i);
                                ps3.setInt(2, pom.getId());
                                ps3.executeUpdate();
                                ps4.setString(1, courierUsername);
                                ps4.setInt(2, pom.getId());
                                ps4.executeUpdate();
                                ps5.setString(1, vozilo);
                                ps5.setInt(2, pom.getId());
                                ps5.executeUpdate();
                                ps10.setInt(1,pom.getId());
                                ps10.executeUpdate();
                                popunjenost += pom.getTezina();
                                trenutno_mesto = pom.getPocetno_mesto();
                            }
                            i++;

                       }
                    }
                    else if(p.getRedosled_utovar() == 0  && p.getMagacin() == 0) paketiZaVracanje.remove(p);
                    }

                    it1 = paketiZaVracanje.iterator();

                    while(it1.hasNext()){

                        p = it1.next();
                        if(p.getMagacin() != 0 && popunjenost + p.getTezina() <= kapacitetVozila){

                            if(p.getRedosled_utovar() == 0){
                                paketiSaIstomAdresom = this.paketiIstoMesto(p.getTrenutno_mesto(), paketiZaVracanje);
                                Iterator<Paket> itt = paketiSaIstomAdresom.iterator();
                                while(itt.hasNext()){
                                    pom = itt.next();
                                    pom.setRedosled_utovar(i);
                                    pom.setReg_broj(vozilo);
                                    pom.setVozac(courierUsername);
                                    pom.setPokuljeno_usput(true);
                                    ps3.setInt(1, i);
                                    ps3.setInt(2, pom.getId());
                                    ps3.executeUpdate();
                                    ps4.setString(1, courierUsername);
                                    ps4.setInt(2, pom.getId());
                                    ps4.executeUpdate();
                                    ps5.setString(1, vozilo);
                                    ps5.setInt(2, pom.getId());
                                    ps5.executeUpdate();
                                    ps10.setInt(1,pom.getId());
                                    ps10.executeUpdate();
                                    popunjenost += pom.getTezina();  
                                    trenutno_mesto = pom.getTrenutno_mesto();
                                }
                                i++;

                           }
                        }
                        else if(p.getRedosled_utovar() == 0  && p.getMagacin() != 0) paketiZaVracanje.remove(p);
                    }
                    idiDalje = true;
                    
                    if(paketi.isEmpty()) tryLast = false;
                }
                else{
                    if(tryLast && paketi.isEmpty()) {
                        tryLast = false;
                        continue;
                    }
                    
                    idiDalje = false;
                    
                    it2 = paketi.iterator();
                    minDist = ~(Integer.rotateRight(1, 1)) * 1.0;
                    while(it2.hasNext()){
                        pom = it2.next();
                        
                        cs1.setInt(2, trenutno_mesto);
                        cs1.setInt(3, pom.getKranje_mesto());
                        cs1.registerOutParameter(1, Types.DECIMAL);
                        cs1.execute();
                        if(cs1.getDouble(1) < minDist){
                            sledeci = pom;
                            minDist = cs1.getDouble(1);
                        }
                                        
                    }

                    batchPackages = this.paketiPoMestuIstovara(sledeci.getKranje_mesto(), paketi);

                    it2 = batchPackages.iterator();
                    prethodno_mesto = trenutno_mesto;
                    trenutno_mesto = batchPackages.get(0).getKranje_mesto();

                    while(it2.hasNext()){
                       pom = it2.next();
                       ps6.setInt(1,i);
                       ps6.setInt(2, pom.getId());
                       ps6.executeUpdate();
                    }

                    i++;


                    it2 = batchPackages.iterator();
                    while(it2.hasNext()){
                        pom = it2.next();
                        paketi.remove(pom);
                    }
                }
           
            }
                   
            ret = true;
        } catch (SQLException ex) {
            ret = false;
        }
        
        return ret;
        
    }
  
    private void sortirajZaVoznju(String kurir){
        Iterator<Paket> it1 = packages.get(kurir).iterator();
        Iterator<Paket> it2 = packages.get(kurir).iterator();
        Paket pom1,pom2;
        int size1 = packages.get(kurir).size();
    
        Paket temp;
        
        boolean flag = false;
        int min = ~(Integer.rotateRight(1, 1));
        for(int i = 0; i < size1; i++){
            
            for(int j = i+1; j < size1; j++){
               
               if(packages.get(kurir).get(i).getRedosled_utovar() < min) flag = false;
               if(packages.get(kurir).get(i).getRedosled_istovar() < min) flag = false;
               if(packages.get(kurir).get(j).getRedosled_utovar() < min) flag = false;
               if(packages.get(kurir).get(j).getRedosled_istovar() < min) flag = false;
                
               
               if(flag == true){
                   temp = packages.get(kurir).get(i);
                   packages.get(kurir).set(i, packages.get(kurir).get(j));
                   packages.get(kurir).set(j,temp);
                   flag = true;
               }
            }
        }
        
    }
    @Override
    public int nextStop(String courierUsername) {
        int ret = -1;
        Connection conn = DB.getDB().getConnection();
        String query0 = "select trenutna_adresa from Vozi where vozac like ?";
        String query1 = "select p.status as status, p.IdP as IdP,\n" +
                            "p.pocetno_mesto as pocetno_mesto,\n" +
                            "p.kranje_mesto as kranje_mesto,\n" +
                            "p.tezina as tezina,\n" +
                            "p.trenutno_mesto as trenutno_mesto,\n" +
                            "p.Date_prihvatanja as Date_prihvatanja,\n" +
                            "coalesce(p.IdM ,0) as IdM ,\n" +
                            "p.redosled_utovar ,0 as redosled_utovar,\n" +
                            "p.redosled_istovar,0 as redosled_istovar,\n" +
                            "p.vozac ,0 as vozac,\n" +
                            "p.reg_broj ,0 as reg_broj,\n" +
                            "coalesce(p.pokupljeno_usput ,0) as pokupljeno_usput \n" +
                            "from Paket p\n" + 
                            "where p.vozac like ? ";
        String query2 = "select redosled from Vozi where vozac like ?";
        String query3 = "update Paket set status = 2 where IdP = ?";
        String query4 = "update Paket set status = 3 where IdP = ?";
        String query5 = "update Vozi set redosled = redosled + 1 where vozac like ?";
        String query6 = "update Paket set trenutno_mesto = ? where IdP = ?";
        String query7 = "update Vozi set trenutna_adresa = ? where vozac like ?";
        String query8 = "update Paket set vozac = null where vozac like ? and IdP = ?";
        String query9 = "update Paket set reg_broj = null where vozac like ? and IdP = ?";
        String query10 = "update Paket set IdM = (select m.IdM from Magacin m join Adresa a on a.IdA = m.IdA where a.IdG = (select a1.IdG from Adresa a1 join Korisnik k on a1.IdA = k.IdA where k.username like ?)) where IdP = ?";
        String query11 = "update Paket set redosled_utovar = null where IdP = ?";
        String query12 = "update Paket set redosled_istovar = null where IdP = ?";
        String query13 = "delete from Vozi where vozac like ?";
        String query14 = "select pocetno_mesto from Paket where redosled_utovar = ? and vozac like ? ";      
        String query15 = "select kranje_mesto from Paket where redosled_istovar = ? and vozac like ? ";
        String query16 = "update Paket set trenutno_mesto = (select m.IdA from Magacin m where m.IdM = Paket.IdM) where IdP = ?";
        String query17 = "update Paket set vozac = null where IdP = ?";
        String query18 = "update Paket set reg_broj = null where IdP = ?";
        String query19 = "update Kurir set status = 0 where username like ?";
        String query20 = "{? = call euklidskaDistanca(?,?)}";
        String query21 = "update Vozi set presao = presao + ? where vozac like ?";
        String query22 = "update Vozi set kapacitet = kapacitet + ? where vozac like ?";
        String query23 = "update Vozio set br_isporucenih_paketa = br_isporucenih_paketa + 1 where username like ? and aktivno = 1";
        String query24 = "update Vozio set profit = profit + (select p.cena from Ponuda p where p.IdP = ?) where username like ? and aktivno = 1";
        String query25 = "update Paket set status = 2 where IdP = ?";
        String query26 = "update Paket set pokupljeno_usput = 0 where IdP = ?";
        String query27 = "update Vozio set profit = profit "
                       + " + coalesce((select sum(cena) from Ponuda where Ponuda.IdP in (select IdP from Paket where vozac like ?)),0)  - "
                       + "(select presao * (select case when tip_goriva = 0 then 15 "
                                                     + "when tip_goriva = 1 then 32 "
                                                     + "when tip_goriva = 2 then 36 "
                                                + "end "
                                         + "from Vozilo where reg_broj = (select v.reg_broj from Vozi v where v.vozac like ?)) from Vozi where vozac like ?) * "
                                        + "(select potrosnja from Vozilo where reg_broj = (select v.reg_broj from Vozi v where v.vozac like ?))"
                       + " where username like ? and aktivno = 1";
        String query28 = "update Vozio set aktivno = 0 where username like ?";
        String query29 = "select m.IdA from Magacin m join Adresa a on a.IdA = m.IdA where a.IdG = (select a.IdG from Korisnik k join Adresa a1 on a1.IdA = k.IdA where k.username like ? )";
        String query30 = "update Paket set IdM = null where IdP = ?";
       
        try (PreparedStatement ps0 = conn.prepareStatement(query0); 
             PreparedStatement ps1 = conn.prepareStatement(query1);
             PreparedStatement ps2 = conn.prepareStatement(query2);
             PreparedStatement ps3 = conn.prepareStatement(query3);
             PreparedStatement ps4 = conn.prepareStatement(query4);
             PreparedStatement ps5 = conn.prepareStatement(query5);
             PreparedStatement ps6 = conn.prepareStatement(query6);
             PreparedStatement ps7 = conn.prepareStatement(query7);
             PreparedStatement ps8 = conn.prepareStatement(query8);
             PreparedStatement ps9 = conn.prepareStatement(query9);
             PreparedStatement ps10 = conn.prepareStatement(query10);
             PreparedStatement ps11 = conn.prepareStatement(query11);
             PreparedStatement ps12 = conn.prepareStatement(query12);
             PreparedStatement ps13 = conn.prepareStatement(query13);
             PreparedStatement ps14 = conn.prepareStatement(query14);
             PreparedStatement ps15 = conn.prepareStatement(query15);
             PreparedStatement ps16 = conn.prepareStatement(query16);
             PreparedStatement ps17 = conn.prepareStatement(query17);
             PreparedStatement ps18 = conn.prepareStatement(query18);
             PreparedStatement ps19 = conn.prepareStatement(query19); 
             CallableStatement cs20 = conn.prepareCall(query20);
             PreparedStatement ps21 = conn.prepareStatement(query21);   
             PreparedStatement ps22 = conn.prepareStatement(query22);
             PreparedStatement ps23 = conn.prepareStatement(query23);
             PreparedStatement ps24 = conn.prepareStatement(query24);   
             PreparedStatement ps25 = conn.prepareStatement(query25);  
             PreparedStatement ps26 = conn.prepareStatement(query26); 
             PreparedStatement ps27 = conn.prepareStatement(query27); 
             PreparedStatement ps28 = conn.prepareStatement(query28); 
             PreparedStatement ps29 = conn.prepareStatement(query29); 
             PreparedStatement ps30 = conn.prepareStatement(query30); 
            )
        {
            
            if(ImpDriveOperations.packages.get(courierUsername) == null){
                
                packages.put(courierUsername, new ArrayList<Paket>());
                
                ps1.setString(1, courierUsername);
                ResultSet rs1 = ps1.executeQuery();
                if(rs1.next()){
                
                    do{
                        packages.get(courierUsername).add(new Paket(rs1.getInt("IdP"),rs1.getInt("pocetno_mesto"),
                        rs1.getInt("kranje_mesto"),rs1.getTimestamp("Date_prihvatanja"),rs1.getInt("redosled_utovar"),
                        rs1.getInt("redosled_istovar"),rs1.getInt("tezina"),rs1.getString("vozac"),rs1.getString("reg_broj"),
                        rs1.getInt("trenutno_mesto"),rs1.getBoolean("pokupljeno_usput"),rs1.getInt("IdM"),
                                rs1.getInt("status")));
                        
                    }
                    while(rs1.next());
                }  
                else return ret;
                
                sortirajZaVoznju(courierUsername);
            }
            
            ps2.setString(1, courierUsername);
            ResultSet rs2 = ps2.executeQuery();
            rs2.next();
            int redosled = rs2.getInt(1);
            if(packages.get(courierUsername).isEmpty() || proveraOstaliSamoUsputniZaIsporuku(packages.get(courierUsername),redosled)){
                ps0.setString(1, courierUsername);
                ResultSet rs0 = ps0.executeQuery();
                rs0.next();
                int trenutno = rs0.getInt(1);
                
                ps29.setString(1, courierUsername);
                ResultSet rs29 = ps29.executeQuery();
                rs29.next();
                int sledece = rs29.getInt(1);
                
                
                cs20.setInt(2, trenutno);
                cs20.setInt(3, sledece);
                cs20.registerOutParameter(1, Types.DECIMAL);
                cs20.execute();
                
                ps21.setDouble(1, cs20.getDouble(1));
                ps21.setString(2,courierUsername);
                ps21.executeUpdate();
                  
                ArrayList<Paket> orphanPackages = packages.get(courierUsername);
                
                 ps13.setString(1,courierUsername);    
                ps19.setString(1,courierUsername);
                ps27.setString(1, courierUsername);
                ps27.setString(2, courierUsername);
                ps27.setString(3, courierUsername);
                ps27.setString(4, courierUsername);
                ps27.setString(5, courierUsername);
                ps28.setString(1,courierUsername);
                ps27.executeUpdate();
                ps19.executeUpdate();
                ps28.executeUpdate();
               
                
                for(Paket orphan:orphanPackages){
                    ps10.setString(1,courierUsername);
                    ps10.setInt(2,orphan.getId());
                    ps11.setInt(1,orphan.getId());
                    ps12.setInt(1,orphan.getId());                   
                    ps16.setInt(1,orphan.getId());
                    ps17.setInt(1,orphan.getId());
                    ps18.setInt(1,orphan.getId());                 
                    ps25.setInt(1, orphan.getId());
                    ps26.setInt(1, orphan.getId());
                  
                    
                    ps10.executeUpdate();
                    ps11.executeUpdate();
                    ps12.executeUpdate();
                    ps16.executeUpdate();
                    ps17.executeUpdate();
                    ps18.executeUpdate();                   
                    ps25.executeUpdate();
                    ps26.executeUpdate();
            
                }
                ps13.executeUpdate();
                packages.put(courierUsername, null);
                return -1;
            }
            else{
            
                ps0.setString(1, courierUsername);
                ResultSet rs0 = ps0.executeQuery();
                rs0.next();
                int prethodno_mesto = rs0.getInt(1);
                
                
                /*ps2.setString(1, courierUsername);
                ResultSet rs2 = ps2.executeQuery();
                rs2.next();
                int redosled = rs2.getInt(1);*/


                int trenutno_mesto;
                ps14.setInt(1, redosled);
                ps14.setString(2, courierUsername);
                ResultSet rs14 = ps14.executeQuery();

                
                if(rs14.next()) trenutno_mesto = rs14.getInt(1);
                else{
                    ps15.setInt(1, redosled);
                    ps15.setString(2, courierUsername);
                    ResultSet rs15 = ps15.executeQuery();
                    rs15.next();
                    trenutno_mesto = rs15.getInt(1); //greska
                    
                }
                
                cs20.setInt(2, trenutno_mesto);
                cs20.setInt(3, prethodno_mesto);
                cs20.registerOutParameter(1, Types.DECIMAL);
                cs20.execute();
                
                ps21.setDouble(1, cs20.getDouble(1));
                ps21.setString(2,courierUsername);
                ps21.executeUpdate();
                
                
                ps7.setInt(1,trenutno_mesto);
                ps7.setString(2, courierUsername);
                ps7.executeUpdate();


                ArrayList<Paket> batchPackages = new ArrayList<Paket>();           
                batchPackages = paketiPoRedosledu(redosled, packages.get(courierUsername));

                
                for(Paket p:packages.get(courierUsername)){
                    if(p.getStatus() == 2 || (p.getStatus() == 1 && p.getRedosled_utovar() == redosled) || (p.getStatus() == 2 && p.getRedosled_istovar() == redosled)){
                        ps6.setInt(1, trenutno_mesto);
                        ps6.setInt(2, p.getId());
                        ps6.executeUpdate();
                    }
                }
                
                
                for(Paket pak:batchPackages){

                    if(pak.getRedosled_utovar() == redosled){
                        if(pak.getMagacin() != 0){
                             ps30.setInt(1,pak.getId());
                             ps30.executeUpdate();
                        }
                        // izbaci ga iz magacina 
                        pak.setStatus(2);
                        ps3.setInt(1, pak.getId());
                        ps3.executeUpdate();
                        ps22.setDouble(1,pak.getTezina());
                        ps22.setString(2,courierUsername);
                        ps22.executeUpdate();
                        ret = -2;
                        
                        // azuriraj vozilo
                    }
                    else{
                        pak.setStatus(3);
                        ps4.setInt(1, pak.getId());
                        ps4.executeUpdate();
                        ps22.setDouble(1,-pak.getTezina());
                        ps22.setString(2,courierUsername);
                        ps22.executeUpdate();
                        ps23.setString(1,courierUsername);
                        ps23.executeUpdate();
                        ps24.setInt(1,pak.getId());
                        ps24.setString(2, courierUsername);
                        ps24.executeUpdate();
                        ret = batchPackages.get(0).getId();
                        // azuriraj vozilo
                    }


                }


                

                Paket pak;
                Iterator<Paket> it = batchPackages.iterator();

                while(it.hasNext()){
                    pak = it.next();
                    
                    if(pak.getRedosled_istovar() == redosled){
                       
                        ps8.setString(1,courierUsername);
                        ps9.setString(1,courierUsername);
                        ps8.setInt(2,pak.getId());
                        ps9.setInt(2,pak.getId());
                        ps11.setInt(1,pak.getId());
                        ps12.setInt(1,pak.getId());
                        ps9.executeUpdate();
                        ps8.executeUpdate();                        
                        ps11.executeUpdate();
                        ps12.executeUpdate();
                        
                        packages.get(courierUsername).remove(pak);
                    }
                }
                ps5.setString(1, courierUsername);
                ps5.executeUpdate();
            
            }
            
            
            
        } catch (SQLException ex) {
            Logger.getLogger(ImpDriveOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ret;
    }

    @Override
    public List<Integer> getPackagesInVehicle(String courierUsername) {
        ArrayList<Integer> ret = new ArrayList<Integer>();
        Connection conn = DB.getDB().getConnection();
        try (PreparedStatement ps1 = conn.prepareStatement("select IdP from Paket where vozac like ? and status = 2 and IdM is null");)
        {
            ps1.setString(1, courierUsername);
            ResultSet rs1 = ps1.executeQuery();
            
            while(rs1.next()){
                ret.add(rs1.getInt(1));
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(ImpDriveOperations.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return ret;
    }

    private boolean proveraOstaliSamoUsputniZaIsporuku(ArrayList<Paket> list,int redosled){
        boolean ret = true;
        
        Iterator<Paket> it = list.iterator();
        Paket p;
                   
                
        while(it.hasNext()){
            
            p = it.next();
            if(p.getRedosled_istovar() != 0 || p.getStatus() == 1 || (p.getStatus() == 2 && p.getRedosled_utovar() >= redosled)) return false; 
        }
        
        return ret;
    }
    
}
