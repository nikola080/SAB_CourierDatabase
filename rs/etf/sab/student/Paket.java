
package rs.etf.sab.student;

import java.sql.Date;
import java.sql.Timestamp;


public class Paket {
    private int Id;
    private int pocetno_mesto;
    private int kranje_mesto;
    private Timestamp Date_prihvatanja;
    private int redosled_utovar;
    private int redosled_istovar;
    private int tezina;
    private String vozac;
    private String reg_broj;
    private int trenutno_mesto;
    private boolean pokuljeno_usput;
    private int magacin;
    private int status;

    public Paket(int Id, int pocetno_mesto, int kranje_mesto, Timestamp Date_prihvatanja, int redosled_utovar, int redosled_istovar, int tezina, String vozac, String reg_broj, int trenutno_mesto, boolean pokuljeno_usput, int magacin,int status) {
        this.Id = Id;
        this.pocetno_mesto = pocetno_mesto;
        this.kranje_mesto = kranje_mesto;
        this.Date_prihvatanja = Date_prihvatanja;
        this.redosled_utovar = redosled_utovar;
        this.redosled_istovar = redosled_istovar;
        this.tezina = tezina;
        this.vozac = vozac;
        this.reg_broj = reg_broj;
        this.trenutno_mesto = trenutno_mesto;
        this.pokuljeno_usput = pokuljeno_usput;
        this.magacin = magacin;
        this.status = status;
    }

    public int getId() {
        return Id;
    }

    public int getPocetno_mesto() {
        return pocetno_mesto;
    }

    public int getKranje_mesto() {
        return kranje_mesto;
    }

    public Timestamp getDate_prihvatanja() {
        return Date_prihvatanja;
    }

    public int getRedosled_utovar() {
        return redosled_utovar;
    }

    public int getRedosled_istovar() {
        return redosled_istovar;
    }

    public int getTezina() {
        return tezina;
    }

    public String getVozac() {
        return vozac;
    }

    public String getReg_broj() {
        return reg_broj;
    }

    public int getTrenutno_mesto() {
        return trenutno_mesto;
    }

    public boolean isPokuljeno_usput() {
        return pokuljeno_usput;
    }

    public int getMagacin() {
        return magacin;
    }

    public void setId(int Id) {
        this.Id = Id;
    }

    public void setPocetno_mesto(int pocetno_mesto) {
        this.pocetno_mesto = pocetno_mesto;
    }

    public void setKranje_mesto(int kranje_mesto) {
        this.kranje_mesto = kranje_mesto;
    }

    public void setDate_prihvatanja(Timestamp Date_prihvatanja) {
        this.Date_prihvatanja = Date_prihvatanja;
    }

    public void setRedosled_utovar(int redosled_utovar) {
        this.redosled_utovar = redosled_utovar;
    }

    public void setRedosled_istovar(int redosled_istovar) {
        this.redosled_istovar = redosled_istovar;
    }

    public void setTezina(int tezina) {
        this.tezina = tezina;
    }

    public void setVozac(String vozac) {
        this.vozac = vozac;
    }

    public void setReg_broj(String reg_broj) {
        this.reg_broj = reg_broj;
    }

    public void setTrenutno_mesto(int trenutno_mesto) {
        this.trenutno_mesto = trenutno_mesto;
    }

    public void setPokuljeno_usput(boolean pokuljeno_usput) {
        this.pokuljeno_usput = pokuljeno_usput;
    }

    public void setMagacin(int magacin) {
        this.magacin = magacin;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    
    
    
}
