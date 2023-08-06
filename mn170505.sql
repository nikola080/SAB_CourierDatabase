CREATE TABLE [Administrator]
( 
	[username]           varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[tip]                varchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL 
)
go

CREATE TABLE [Adresa]
( 
	[x]                  decimal(10,3)  NOT NULL ,
	[y]                  decimal(10,3)  NOT NULL ,
	[ulica]              varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[broj]               int  NOT NULL ,
	[IdA]                int  IDENTITY ( 1,1 )  NOT NULL ,
	[IdG]                int  NULL 
)
go

CREATE TABLE [Grad]
( 
	[PB]                 varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[naziv]              varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[IdG]                int  IDENTITY ( 1,1 )  NOT NULL 
)
go

CREATE TABLE [Korisnik]
( 
	[username]           varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[ime]                varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[prezime]            varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[password]           varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[IdA]                int  NOT NULL ,
	[tip]                varchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL 
)
go

ALTER TABLE [Korisnik]
	 WITH NOCHECK ADD CONSTRAINT [provera_korisnik_1980369930] CHECK  ( [tip]='A' OR [tip]='B' OR [tip]='C' OR [tip]='BC' )
go

CREATE TABLE [Kupac]
( 
	[username]           varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[tip]                varchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL 
)
go

ALTER TABLE [Kupac]
	 WITH NOCHECK ADD CONSTRAINT [provera_kupac_1142622547] CHECK  ( [tip]='A' )
go

CREATE TABLE [Kurir]
( 
	[username]           varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[tip]                varchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[broj_vozacke]       varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[status]             tinyint  NOT NULL 
)
go

ALTER TABLE [Kurir]
	 WITH NOCHECK ADD CONSTRAINT [provera_status_vozaca_2035383898] CHECK  ( [status]=0 OR [status]=1 )
go

CREATE TABLE [Magacin]
( 
	[IdM]                int  IDENTITY ( 1,1 )  NOT NULL ,
	[IdA]                int  NULL 
)
go

CREATE TABLE [Paket]
( 
	[vozac]              varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[IdP]                int  IDENTITY ( 1,1 )  NOT NULL ,
	[status]             tinyint  NOT NULL ,
	[tip_paketa]         tinyint  NOT NULL ,
	[pocetno_mesto]      int  NULL ,
	[kranje_mesto]       int  NULL ,
	[tezina]             decimal(10,3)  NOT NULL ,
	[reg_broj]           varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[pokupljeno_usput]   bit  NULL ,
	[IdM]                int  NULL ,
	[redosled_utovar]    int  NULL ,
	[Date_kreiranja]     datetime  NOT NULL ,
	[Date_prihvatanja]   datetime  NULL ,
	[redosled_istovar]   int  NULL ,
	[vlasnik]            varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[trenutno_mesto]     int  NULL 
)
go

ALTER TABLE [Paket]
	 WITH NOCHECK ADD CONSTRAINT [provera_status_paketa_1900118600] CHECK  ( [status]=0 OR [status]=1 OR [status]=2 OR [status]=3 OR [status]=4 )
go

ALTER TABLE [Paket]
	 WITH NOCHECK ADD CONSTRAINT [provera_tip_paketa_1731358874] CHECK  ( [tip_paketa]=0 OR [tip_paketa]=1 OR [tip_paketa]=2 OR [tip_paketa]=3 )
go

ALTER TABLE [Paket]
	 WITH NOCHECK ADD CONSTRAINT [provera_tezina] CHECK  ( [tezina]>(0) )
go

CREATE TABLE [Ponuda]
( 
	[IdP]                int  NOT NULL ,
	[cena]               decimal(10,3)  NOT NULL ,
	[prihvacena]         bit  NULL 
)
go

CREATE TABLE [Vozi]
( 
	[vozac]              varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[reg_broj]           varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[kapacitet]          decimal(10,3)  NOT NULL 
	CONSTRAINT [Default_Value_0_810552921]
		 DEFAULT  0,
	[presao]             decimal(10,3)  NOT NULL ,
	[trenutna_adresa]    int  NULL ,
	[redosled]           int  NOT NULL 
	CONSTRAINT [DF_Vozi_redosled]
		 DEFAULT  1
)
go

ALTER TABLE [Vozi]
	 WITH NOCHECK ADD CONSTRAINT [provera_kapacitet] CHECK  ( kapacitet >= 0 )
go

ALTER TABLE [Vozi]
	 WITH NOCHECK ADD CONSTRAINT [provera_presao] CHECK  ( presao >= 0 )
go

CREATE TABLE [Vozilo]
( 
	[reg_broj]           varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[tip_goriva]         tinyint  NOT NULL ,
	[potrosnja]          decimal(10,3)  NOT NULL ,
	[nosivost]           decimal(10,3)  NOT NULL ,
	[IdM]                int  NULL 
)
go

ALTER TABLE [Vozilo]
	 WITH NOCHECK ADD CONSTRAINT [provera_tip_goriva_2143105594] CHECK  ( [tip_goriva]=0 OR [tip_goriva]=1 OR [tip_goriva]=2 )
go

ALTER TABLE [Vozilo]
	 WITH NOCHECK ADD CONSTRAINT [provera_potrosnja] CHECK  ( [potrosnja]>(0) )
go

ALTER TABLE [Vozilo]
	 WITH NOCHECK ADD CONSTRAINT [provera_nosivost] CHECK  ( [nosivost]>(0) )
go

CREATE TABLE [Vozio]
( 
	[username]           varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[reg_broj]           varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[profit]             decimal(10,3)  NULL ,
	[br_isporucenih_paketa] int  NULL ,
	[IdVozio]            int  IDENTITY ( 1,1 )  NOT NULL ,
	[aktivno]            int  NULL 
)
go

CREATE TABLE [ZahtevZaKurira]
( 
	[username]           varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[br_vozacke]         int  NOT NULL ,
	[prihvaceno]         bit  NULL 
)
go

ALTER TABLE [Administrator]
	ADD CONSTRAINT [XPKAdministrator] PRIMARY KEY  CLUSTERED ([username] ASC)
go

ALTER TABLE [Adresa]
	ADD CONSTRAINT [XPKAdresa] PRIMARY KEY  CLUSTERED ([IdA] ASC)
go

ALTER TABLE [Grad]
	ADD CONSTRAINT [XPKGrad] PRIMARY KEY  CLUSTERED ([IdG] ASC)
go

ALTER TABLE [Korisnik]
	ADD CONSTRAINT [XPKKorisnik] PRIMARY KEY  CLUSTERED ([username] ASC)
go

ALTER TABLE [Kupac]
	ADD CONSTRAINT [XPKKupac] PRIMARY KEY  CLUSTERED ([username] ASC)
go

ALTER TABLE [Kurir]
	ADD CONSTRAINT [XPKKurir] PRIMARY KEY  CLUSTERED ([username] ASC)
go

ALTER TABLE [Magacin]
	ADD CONSTRAINT [XPKMagacin] PRIMARY KEY  CLUSTERED ([IdM] ASC)
go

ALTER TABLE [Paket]
	ADD CONSTRAINT [XPKPaket] PRIMARY KEY  CLUSTERED ([IdP] ASC)
go

ALTER TABLE [Ponuda]
	ADD CONSTRAINT [XPKPonuda] PRIMARY KEY  CLUSTERED ([IdP] ASC)
go

ALTER TABLE [Vozi]
	ADD CONSTRAINT [XPKVozi] PRIMARY KEY  CLUSTERED ([vozac] ASC,[reg_broj] ASC)
go

ALTER TABLE [Vozilo]
	ADD CONSTRAINT [XPKVozilo] PRIMARY KEY  CLUSTERED ([reg_broj] ASC)
go

ALTER TABLE [Vozio]
	ADD CONSTRAINT [PK_Vozio] PRIMARY KEY  CLUSTERED ([IdVozio] ASC)
go

ALTER TABLE [ZahtevZaKurira]
	ADD CONSTRAINT [XPKZahtevZaKurira] PRIMARY KEY  CLUSTERED ([username] ASC)
go


ALTER TABLE [Administrator] WITH NOCHECK 
	ADD CONSTRAINT [R_21] FOREIGN KEY ([username]) REFERENCES [Korisnik]([username])
		ON DELETE CASCADE
		ON UPDATE CASCADE
go

ALTER TABLE [Administrator]
	  WITH NOCHECK CHECK CONSTRAINT [R_21]
go


ALTER TABLE [Adresa] WITH NOCHECK 
	ADD CONSTRAINT [R_19] FOREIGN KEY ([IdG]) REFERENCES [Grad]([IdG])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [Adresa]
	  WITH NOCHECK CHECK CONSTRAINT [R_19]
go


ALTER TABLE [Korisnik] WITH NOCHECK 
	ADD CONSTRAINT [R_2] FOREIGN KEY ([IdA]) REFERENCES [Adresa]([IdA])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [Korisnik]
	  WITH NOCHECK CHECK CONSTRAINT [R_2]
go


ALTER TABLE [Kupac] WITH NOCHECK 
	ADD CONSTRAINT [R_3] FOREIGN KEY ([username]) REFERENCES [Korisnik]([username])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [Kupac]
	  WITH NOCHECK CHECK CONSTRAINT [R_3]
go


ALTER TABLE [Kurir] WITH NOCHECK 
	ADD CONSTRAINT [R_20] FOREIGN KEY ([username]) REFERENCES [Korisnik]([username])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [Kurir]
	  WITH NOCHECK CHECK CONSTRAINT [R_20]
go


ALTER TABLE [Magacin] WITH NOCHECK 
	ADD CONSTRAINT [R_34] FOREIGN KEY ([IdA]) REFERENCES [Adresa]([IdA])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [Magacin]
	  WITH NOCHECK CHECK CONSTRAINT [R_34]
go


ALTER TABLE [Paket] WITH NOCHECK 
	ADD CONSTRAINT [FK_Paket_Vozi] FOREIGN KEY ([vozac],[reg_broj]) REFERENCES [Vozi]([vozac],[reg_broj])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [Paket]
	  WITH NOCHECK CHECK CONSTRAINT [FK_Paket_Vozi]
go


ALTER TABLE [Ponuda] WITH NOCHECK 
	ADD CONSTRAINT [R_39] FOREIGN KEY ([IdP]) REFERENCES [Paket]([IdP])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [Ponuda]
	  WITH NOCHECK CHECK CONSTRAINT [R_39]
go


ALTER TABLE [Vozi] WITH NOCHECK 
	ADD CONSTRAINT [R_22] FOREIGN KEY ([vozac]) REFERENCES [Kurir]([username])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Vozi]
	  WITH NOCHECK CHECK CONSTRAINT [R_22]
go

ALTER TABLE [Vozi] WITH NOCHECK 
	ADD CONSTRAINT [R_23] FOREIGN KEY ([reg_broj]) REFERENCES [Vozilo]([reg_broj])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [Vozi]
	  WITH NOCHECK CHECK CONSTRAINT [R_23]
go

ALTER TABLE [Vozi] WITH NOCHECK 
	ADD CONSTRAINT [FK_Vozi_Adresa] FOREIGN KEY ([trenutna_adresa]) REFERENCES [Adresa]([IdA])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Vozi]
	  WITH NOCHECK CHECK CONSTRAINT [FK_Vozi_Adresa]
go


ALTER TABLE [Vozilo] WITH NOCHECK 
	ADD CONSTRAINT [R_36] FOREIGN KEY ([IdM]) REFERENCES [Magacin]([IdM])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Vozilo]
	  WITH NOCHECK CHECK CONSTRAINT [R_36]
go


ALTER TABLE [Vozio] WITH NOCHECK 
	ADD CONSTRAINT [R_24] FOREIGN KEY ([username]) REFERENCES [Kurir]([username])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [Vozio]
	  WITH NOCHECK CHECK CONSTRAINT [R_24]
go

ALTER TABLE [Vozio] WITH NOCHECK 
	ADD CONSTRAINT [R_25] FOREIGN KEY ([reg_broj]) REFERENCES [Vozilo]([reg_broj])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [Vozio]
	  WITH NOCHECK CHECK CONSTRAINT [R_25]
go


ALTER TABLE [ZahtevZaKurira] WITH NOCHECK 
	ADD CONSTRAINT [R_26] FOREIGN KEY ([username]) REFERENCES [Korisnik]([username])
		ON DELETE CASCADE
		ON UPDATE CASCADE
go

ALTER TABLE [ZahtevZaKurira]
	  WITH NOCHECK CHECK CONSTRAINT [R_26]
go

CREATE FUNCTION [euklidskaDistanca] (@pocetak int , @kraj int )  
  RETURNS decimal(10,3) 
  
AS BEGIN
	declare @distance decimal(10,3)
	declare @x1 decimal(10,3)
	declare @y1 decimal(10,3)
	declare @x2 decimal(10,3)
	declare @y2 decimal(10,3)

	select @x1 = x,@y1 = y
	from Adresa a
	where a.IdA = @pocetak
	
	select @x2 = x,@y2 = y
	from Adresa a
	where a.IdA = @kraj

	if(@x1 = NULL or @y1 = NULL or @x2 = NULL or @y2 = NULL)
	begin
		return -1
	end
	
	set @distance = SQRT(SQUARE(cast(@x1 as float) - cast(@x2 as float)) +
						 SQUARE(cast(@y1 as float) - cast(@y2 as float)))

	RETURN @distance

END
go

CREATE PROCEDURE [gomu_gomu_database_no_more]   
   
 AS BEGIN
	
	exec projekat_SAB_v3.[dbo].sp_MSForEachTable 'DISABLE TRIGGER ALL ON ?'
	
	exec projekat_SAB_v3.[dbo].sp_MSForEachTable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'
	
	exec projekat_SAB_v3.[dbo].sp_MSForEachTable 'DELETE FROM ?'
	 
	exec projekat_SAB_v3.[dbo].sp_MSForEachTable 'ALTER TABLE ? CHECK CONSTRAINT ALL' 
	
	exec projekat_SAB_v3.[dbo].sp_MSForEachTable 'DISABLE TRIGGER ALL ON ?'
	
END
go

CREATE TRIGGER [provera_kurir] ON Kurir
   WITH 
 EXECUTE AS CALLER  AFTER INSERT 
  
  AS

BEGIN
	declare @kursor cursor
	declare @username varchar(100)
	declare @tip varchar(2)

	set @kursor = cursor for
	select username,tip
	from inserted

	open @kursor

	fetch next from @kursor into
	@username,@tip

	while @@FETCH_STATUS = 0
	begin
		if(@tip != 'B') 
		begin
			rollback transaction
			raiserror('Cannot insert Kurir, type can only have value B',11,1)
			return
		end
		if( not exists(
				  select * from Korisnik k where k.username = @username and k.tip is null))
		begin
			rollback transaction
			raiserror('Cannot insert Kurir, Korisnik does not exist',11,1)
		end
		else 
		begin
			update Korisnik set Korisnik.tip = 'B' where Korisnik.username = @username
		end
		fetch next from @kursor into
		@username,@tip

	end

	close @kursor
	deallocate @kursor

END

 
go


ENABLE TRIGGER [provera_kurir] ON Kurir
go

CREATE TRIGGER [provera_jedinstvenosti_vozacke] ON Kurir
   WITH 
 EXECUTE AS CALLER  AFTER INSERT,UPDATE 
  
  AS

BEGIN
	
	declare @kursor cursor
	declare @username varchar(100)
	declare @broj_vozacke int
	declare @tabela TABLE(username varchar(100),reg_broj varchar(100))

	set @kursor = cursor for
	select username, broj_vozacke
	from inserted

	insert into @tabela 
	select inserted.username,inserted.broj_vozacke from inserted

	open @kursor

	fetch next from @kursor into
	@username,@broj_vozacke
	--select * from inserted

	while @@FETCH_STATUS = 0
	begin
		if(exists
			(
				select k.broj_vozacke
				from Kurir k
				where k.broj_vozacke like @broj_vozacke and k.username not in (select username from @tabela)
			)
		)
		begin
			rollback transaction
			raiserror('Courier with the same registration license already exists',11,1)
		end

		delete from @tabela where username = @username
		fetch next from @kursor into
		@username,@broj_vozacke

	end

	close @kursor
	deallocate @kursor

END

 
go


ENABLE TRIGGER [provera_jedinstvenosti_vozacke] ON Kurir
go

CREATE TRIGGER [tD_Korisnik] ON Korisnik
   WITH 
 EXECUTE AS CALLER  AFTER DELETE 
  
  AS

/* erwin Builtin Trigger */
/* DELETE trigger on Korisnik */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Korisnik  Paket on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00045b8a", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_20", FK_COLUMNS="vlasnik" */
    IF EXISTS (
      SELECT * FROM deleted,Paket
      WHERE
        /*  JoinFKPK" = "," AND") */
        Paket.vlasnik = deleted.username
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Korisnik because Paket exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Korisnik  ZahtevZaKurira on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="ZahtevZaKurira"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_26", FK_COLUMNS="username" */
    DELETE ZahtevZaKurira
      FROM ZahtevZaKurira,deleted
      WHERE
        /*  JoinFKPK" = "," AND") */
        ZahtevZaKurira.username = deleted.username

    /* erwin Builtin Trigger */
    /* Korisnik  Kurir on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_20", FK_COLUMNS="username" */
    IF EXISTS (
      SELECT * FROM deleted,Kurir
      WHERE
        /*  JoinFKPK" = "," AND") */
        Kurir.username = deleted.username
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Korisnik because Kurir exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Korisnik  Kupac on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Kupac"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="username" */
    IF EXISTS (
      SELECT * FROM deleted,Kupac
      WHERE
        /*  JoinFKPK" = "," AND") */
        Kupac.username = deleted.username
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Korisnik because Kupac exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Korisnik  Administrator on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Administrator"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_21", FK_COLUMNS="username" */
    DELETE Administrator
      FROM Administrator,deleted
      WHERE
        /*  JoinFKPK" = "," AND") */
        Administrator.username = deleted.username


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

 
go


ENABLE TRIGGER [tD_Korisnik] ON Korisnik
go

CREATE TRIGGER [tU_Korisnik] ON Korisnik
   WITH 
 EXECUTE AS CALLER  AFTER UPDATE 
  
  AS

/* erwin Builtin Trigger */
/* UPDATE trigger on Korisnik */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insusername varchar(100),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Korisnik  Paket on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="0006dda0", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_20", FK_COLUMNS="vlasnik" */
  IF
    /* (" OR",UPDATE) */
    UPDATE(username)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insusername = inserted.username
        FROM inserted
      UPDATE Paket
      SET
        /*  JoinFKPK" = ",",") */
        Paket.vlasnik = @insusername
      FROM Paket,inserted,deleted
      WHERE
        /*  JoinFKPK" = "," AND") */
        Paket.vlasnik = deleted.username
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Korisnik update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Korisnik  ZahtevZaKurira on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="ZahtevZaKurira"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_26", FK_COLUMNS="username" */
  IF
    /* (" OR",UPDATE) */
    UPDATE(username)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insusername = inserted.username
        FROM inserted
      UPDATE ZahtevZaKurira
      SET
        /*  JoinFKPK" = ",",") */
        ZahtevZaKurira.username = @insusername
      FROM ZahtevZaKurira,inserted,deleted
      WHERE
        /*  JoinFKPK" = "," AND") */
        ZahtevZaKurira.username = deleted.username
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Korisnik update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Korisnik  Kurir on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_20", FK_COLUMNS="username" */
  IF
    /* (" OR",UPDATE) */
    UPDATE(username)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insusername = inserted.username
        FROM inserted
      UPDATE Kurir
      SET
        /*  JoinFKPK" = ",",") */
        Kurir.username = @insusername
      FROM Kurir,inserted,deleted
      WHERE
        /*  JoinFKPK" = "," AND") */
        Kurir.username = deleted.username
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Korisnik update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Korisnik  Kupac on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Kupac"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="username" */
  IF
    /* (" OR",UPDATE) */
    UPDATE(username)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insusername = inserted.username
        FROM inserted
      UPDATE Kupac
      SET
        /*  JoinFKPK" = ",",") */
        Kupac.username = @insusername
      FROM Kupac,inserted,deleted
      WHERE
        /*  JoinFKPK" = "," AND") */
        Kupac.username = deleted.username
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Korisnik update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Korisnik  Administrator on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Administrator"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_21", FK_COLUMNS="username" */
  IF
    /* (" OR",UPDATE) */
    UPDATE(username)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insusername = inserted.username
        FROM inserted
      UPDATE Administrator
      SET
        /*  JoinFKPK" = ",",") */
        Administrator.username = @insusername
      FROM Administrator,inserted,deleted
      WHERE
        /*  JoinFKPK" = "," AND") */
        Administrator.username = deleted.username
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Korisnik update because more than one row has been affected.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

 
go


ENABLE TRIGGER [tU_Korisnik] ON Korisnik
go

CREATE TRIGGER [provera_unos] ON ZahtevZaKurira
   WITH 
 EXECUTE AS CALLER  AFTER INSERT 
  
  AS

BEGIN
	declare @kursor cursor
	declare @username varchar(100)
	declare @br_vozacke varchar(100)
	declare @table TABLE(username varchar(100))
	insert into @table
	select inserted.username
	from inserted

	set @kursor = cursor for
	select username,br_vozacke
	from inserted

	open @kursor

	fetch next from @kursor into
	@username,@br_vozacke

	while @@FETCH_STATUS = 0
	begin
		if(not exists
			(	
				select username from Korisnik k where k.username = @username and k.tip is null 
			)
		)
		begin
			rollback transaction
			raiserror('Request has been denied because the user is already a courier or something else',11,1)
		end
		else if(exists(
			select z.username
			from ZahtevZaKurira z
			where z.br_vozacke = @br_vozacke and z.username not in (select username from @table)
		))
		begin
			raiserror('Request with the same license plate has already been submited!',11,1)
			rollback transaction
		end
		delete from @table
		where username = @username
		fetch next from @kursor into
		@username,@br_vozacke

	end

	close @kursor
	deallocate @kursor

END

 
go


ENABLE TRIGGER [provera_unos] ON ZahtevZaKurira
go

CREATE TRIGGER [provera_jedinstvenosti_brojaVozacke] ON ZahtevZaKurira
   WITH 
 EXECUTE AS CALLER  AFTER UPDATE 
  
  AS

IF(UPDATE(br_vozacke))
BEGIN
	declare @kursor cursor
	declare @username varchar(100)
	declare @br_vozacke int
	declare @table TABLE(username varchar(100))
	insert into @table
	select inserted.username
	from inserted

	set @kursor = cursor for
	select username,br_vozacke from inserted

	open @kursor
	fetch next from @kursor into
	@username,@br_vozacke

	while @@FETCH_STATUS = 0
	begin
		if(exists(
			select z.username
			from ZahtevZaKurira z
			where z.br_vozacke = @br_vozacke and z.username not in (select username from @table)
		))
		begin
			raiserror('Request with the same license plate has already been submited!',11,1)
			rollback transaction
		end
		delete from @table
		where username = @username
		fetch next from @kursor into
		@username,@br_vozacke
	end
	close @kursor
	deallocate @kursor

END

 
go


ENABLE TRIGGER [provera_jedinstvenosti_brojaVozacke] ON ZahtevZaKurira
go

CREATE TRIGGER [postavi_kurira] ON ZahtevZaKurira
   WITH 
 EXECUTE AS CALLER  AFTER UPDATE 
  
  AS

IF(UPDATE(prihvaceno))
BEGIN
	declare @kursor cursor
	declare @username varchar(100)
	declare @br_vozacke int
	declare @status bit

	set @kursor = cursor for
	select username,br_vozacke,prihvaceno from inserted


	if((select count(*)
	   from inserted
	   group by inserted.username) > 1) 
	   begin
			rollback transaction
			raiserror('Cannot change the requset multiple times on a same user.',11,1)
	   end



	open @kursor
	fetch next from @kursor into
	@username,@br_vozacke,@status




	while @@FETCH_STATUS = 0
	begin
		if( (select d.prihvaceno from deleted d where d.username = @username) is not null)
		begin
			rollback transaction
			raiserror('Cannot change the requset multiple times on a same user.',11,1)
		end
		if(@status = 1)
		begin
			insert into Kurir
			values (@username,'B',@br_vozacke,0)

			update Korisnik
			set Korisnik.tip = 'B'
			where Korisnik.username = @username
		end
		fetch next from @kursor into
		@username,@br_vozacke,@status
	end
	close @kursor
	deallocate @kursor
END

 
go


ENABLE TRIGGER [postavi_kurira] ON ZahtevZaKurira
go

CREATE TRIGGER [promeni_tip_korisnika] ON Administrator
   WITH 
 EXECUTE AS CALLER  AFTER INSERT 
  
  AS

BEGIN
	
	declare @kursor cursor
	declare @username varchar(100)

	set @kursor = cursor for
	select username from inserted

	open @kursor

	fetch next from @kursor into
	@username

	while @@FETCH_STATUS = 0
	begin

		if((select k.tip
			from Korisnik k
			where k.username = @username) = 'B')
		begin  
			update Korisnik 
			set Korisnik.tip = 'BC'
			where Korisnik.username = @username
			update Kurir 
			set Kurir.tip = 'BC'
			where Kurir.username = @username
			update Administrator 
			set Administrator.tip = 'BC'
			where Administrator.username = @username
			
		end
		else 
		if(ISNULL((select k.tip from Korisnik k where k.username = @username),-1) = -1)
		begin
			update Korisnik 
			set Korisnik.tip = 'C'
			where Korisnik.username = @username
			
		end
		else rollback transaction

		fetch next from @kursor into
		@username
	end
	close @kursor
	deallocate @kursor

END

 
go


ENABLE TRIGGER [promeni_tip_korisnika] ON Administrator
go

CREATE TRIGGER [provera_promena] ON Vozilo
   WITH 
 EXECUTE AS CALLER  AFTER UPDATE 
  
  AS

IF( UPDATE(tip_goriva) or UPDATE(potrosnja) or UPDATE(nosivost) )
BEGIN
	if(exists(
		select i.reg_broj
		from inserted i
		where i.IdM is null
	))
	begin
		rollback transaction	
		raiserror('Cannot make a change on vehicle because it is not in Stockroom', 11,1)
	end

END

 
go


ENABLE TRIGGER [provera_promena] ON Vozilo
go

CREATE TRIGGER [tD_Adresa] ON Adresa
   WITH 
 EXECUTE AS CALLER  AFTER DELETE 
  
  AS

/* erwin Builtin Trigger */
/* DELETE trigger on Adresa */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Adresa  Paket on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00055e57", PARENT_OWNER="", PARENT_TABLE="Adresa"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_33", FK_COLUMNS="kranje_mesto" */
    IF EXISTS (
      SELECT * FROM deleted,Paket
      WHERE
        /*  JoinFKPK" = "," AND") */
        Paket.kranje_mesto = deleted.IdA
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Adresa because Paket exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Adresa  Paket on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Adresa"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_32", FK_COLUMNS="pocetno_mesto" */
    IF EXISTS (
      SELECT * FROM deleted,Paket
      WHERE
        /*  JoinFKPK" = "," AND") */
        Paket.pocetno_mesto = deleted.IdA
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Adresa because Paket exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Adresa  Magacin on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Adresa"
    CHILD_OWNER="", CHILD_TABLE="Magacin"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_34", FK_COLUMNS="IdA" */
    IF EXISTS (
      SELECT * FROM deleted,Magacin
      WHERE
        /*  JoinFKPK" = "," AND") */
        Magacin.IdA = deleted.IdA
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Adresa because Magacin exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Adresa  Korisnik on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Adresa"
    CHILD_OWNER="", CHILD_TABLE="Korisnik"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="IdA" */
    IF EXISTS (
      SELECT * FROM deleted,Korisnik
      WHERE
        /*  JoinFKPK" = "," AND") */
        Korisnik.IdA = deleted.IdA
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Adresa because Korisnik exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

 
 
 
go


ENABLE TRIGGER [tD_Adresa] ON Adresa
go

CREATE TRIGGER [tU_Adresa] ON Adresa
   WITH 
 EXECUTE AS CALLER  AFTER UPDATE 
  
  AS

/* erwin Builtin Trigger */
/* UPDATE trigger on Adresa */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdA int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Adresa  Vozi on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00058a7e", PARENT_OWNER="", PARENT_TABLE="Adresa"
    CHILD_OWNER="", CHILD_TABLE="Vozi"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_40", FK_COLUMNS="trenutno_mesto" */
  IF
    /* (" OR",UPDATE) */
    UPDATE(IdA)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Vozi
      WHERE
        /*  JoinFKPK" = "," AND") */
        Vozi.trenutno_mesto = deleted.IdA
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Adresa because Vozi exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Adresa  Paket on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Adresa"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_33", FK_COLUMNS="kranje_mesto" */
  IF
    /* (" OR",UPDATE) */
    UPDATE(IdA)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Paket
      WHERE
        /*  JoinFKPK" = "," AND") */
        Paket.kranje_mesto = deleted.IdA
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Adresa because Paket exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Adresa  Paket on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Adresa"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_32", FK_COLUMNS="pocetno_mesto" */
  IF
    /* (" OR",UPDATE) */
    UPDATE(IdA)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Paket
      WHERE
        /*  JoinFKPK" = "," AND") */
        Paket.pocetno_mesto = deleted.IdA
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Adresa because Paket exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Adresa  Magacin on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Adresa"
    CHILD_OWNER="", CHILD_TABLE="Magacin"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_34", FK_COLUMNS="IdA" */
  IF
    /* (" OR",UPDATE) */
    UPDATE(IdA)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdA = inserted.IdA
        FROM inserted
      UPDATE Magacin
      SET
        /*  JoinFKPK" = ",",") */
        Magacin.IdA = @insIdA
      FROM Magacin,inserted,deleted
      WHERE
        /*  JoinFKPK" = "," AND") */
        Magacin.IdA = deleted.IdA
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Adresa update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Adresa  Korisnik on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Adresa"
    CHILD_OWNER="", CHILD_TABLE="Korisnik"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="IdA" */
  IF
    /* (" OR",UPDATE) */
    UPDATE(IdA)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdA = inserted.IdA
        FROM inserted
      UPDATE Korisnik
      SET
        /*  JoinFKPK" = ",",") */
        Korisnik.IdA = @insIdA
      FROM Korisnik,inserted,deleted
      WHERE
        /*  JoinFKPK" = "," AND") */
        Korisnik.IdA = deleted.IdA
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Adresa update because more than one row has been affected.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

 
go


ENABLE TRIGGER [tU_Adresa] ON Adresa
go

CREATE TRIGGER [vec_postoji] ON Grad
   WITH 
 EXECUTE AS CALLER  AFTER INSERT,UPDATE 
  
  AS

BEGIN
	
	if(exists (
	    select PB
	    from Grad 
		group by PB
		having count(*) > 1
		) ) 
	begin
		rollback transaction 
		raiserror('Cannot insert city with th same PB and name',11,1)
	end
END

 
go


ENABLE TRIGGER [vec_postoji] ON Grad
go

CREATE TRIGGER [jedinstvenost_u_gradu] ON Magacin
   WITH 
 EXECUTE AS CALLER  AFTER INSERT,UPDATE 
  
  AS

BEGIN
	
	if(exists(
		select g.IdG
		from Magacin m join Grad g on g.IdG in (select a.IdG from Adresa a where a.IdA = m.IdA ) 
		group by g.IdG
		having count(*) > 1
	)
	)
	begin
		rollback transaction 
		raiserror('Cannot insert more than one stockroom in the same city.',11,1)
	end

END

 
go


ENABLE TRIGGER [jedinstvenost_u_gradu] ON Magacin
go

CREATE TRIGGER [tD_Magacin] ON Magacin
   WITH 
 EXECUTE AS CALLER  AFTER DELETE 
  
  AS

/* erwin Builtin Trigger */
/* DELETE trigger on Magacin */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Magacin  Vozilo on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001c4cd", PARENT_OWNER="", PARENT_TABLE="Magacin"
    CHILD_OWNER="", CHILD_TABLE="Vozilo"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_36", FK_COLUMNS="IdM" */
    IF EXISTS (
      SELECT * FROM deleted,Vozilo
      WHERE
        /*  JoinFKPK" = "," AND") */
        Vozilo.IdM = deleted.IdM
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Magacin because Vozilo exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Magacin  Paket on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Magacin"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_37", FK_COLUMNS="IdM" */
    IF EXISTS (
      SELECT * FROM deleted,Paket
      WHERE
        /*  JoinFKPK" = "," AND") */
        Paket.IdM = deleted.IdM
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Magacin because Paket exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

 
go


ENABLE TRIGGER [tD_Magacin] ON Magacin
go

CREATE TRIGGER [tU_Magacin] ON Magacin
   WITH 
 EXECUTE AS CALLER  AFTER UPDATE 
  
  AS

/* erwin Builtin Trigger */
/* UPDATE trigger on Magacin */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdM int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Magacin  Vozilo on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0001f5f0", PARENT_OWNER="", PARENT_TABLE="Magacin"
    CHILD_OWNER="", CHILD_TABLE="Vozilo"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_36", FK_COLUMNS="IdM" */
  IF
    /* (" OR",UPDATE) */
    UPDATE(IdM)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Vozilo
      WHERE
        /*  JoinFKPK" = "," AND") */
        Vozilo.IdM = deleted.IdM
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Magacin because Vozilo exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Magacin  Paket on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Magacin"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_37", FK_COLUMNS="IdM" */
  IF
    /* (" OR",UPDATE) */
    UPDATE(IdM)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Paket
      WHERE
        /*  JoinFKPK" = "," AND") */
        Paket.IdM = deleted.IdM
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Magacin because Paket exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

 
go


ENABLE TRIGGER [tU_Magacin] ON Magacin
go

CREATE TRIGGER [provera_jedinstvenosti] ON Vozi
   WITH 
 EXECUTE AS CALLER  AFTER INSERT,UPDATE 
  
  AS

BEGIN
	
	if(exists(
		select count(*)
		from Vozi v 
		group by v.vozac
		having count(*) > 1
	) or exists(
		select count(*)
		from Vozi v 
		group by v.reg_broj
		having count(*) > 1
	)
	)
	begin
		rollback transaction
	end

END

 
go


ENABLE TRIGGER [provera_jedinstvenosti] ON Vozi
go

CREATE TRIGGER [promena_statusa_paketa] ON Ponuda
   WITH 
 EXECUTE AS CALLER  AFTER UPDATE 
  
  AS

if(UPDATE(prihvacena))
BEGIN
	
	declare @kursor cursor
	declare @IdP int
	declare @prihvacena int

	set @kursor = cursor for
	select IdP,prihvacena from inserted

	open @kursor
	fetch next from @kursor into 
	@IdP,@prihvacena

	while @@FETCH_STATUS = 0
	begin
		if(
			(select p.status from Paket p where p.IdP = @IdP) = 0
		)
		begin
			if(@prihvacena = 0)  update Paket set Paket.status = 4 where Paket.IdP = @IdP
			else if(@prihvacena = 1) 
				begin 
					update Paket set Paket.status = 1 where Paket.IdP = @IdP
					--WAITFOR DELAY '00:00:01'
					update Paket set Paket.Date_prihvatanja = CURRENT_TIMESTAMP where Paket.IdP = @IdP
					--ako ne postoji metoda u paketu koja ce da ga stavi u odgovarajuci magacin
					--update Paket
					--set Paket.IdM = (select IdM from Magacin where Magacin.IdA = Paket.pocetno_mesto)
					--where Paket.IdP = @IdP
				end

		end
		else
		begin
			rollback transaction
			RAISERROR('Cannot update Ponuda, the decision has already been made.',11,1)
		end
		
		fetch next from @kursor into 
		@Idp,@prihvacena
	end
	close @kursor
	deallocate @kursor
END

 
 
 
 
go


ENABLE TRIGGER [promena_statusa_paketa] ON Ponuda
go

CREATE TRIGGER [ispravi_cenu] ON Paket
   WITH 
 EXECUTE AS CALLER  AFTER UPDATE 
  
  AS

IF(UPDATE(tip_paketa) or UPDATE(tezina) or UPDATE(pocetno_mesto) or UPDATE(kranje_mesto))
BEGIN
	
	declare @kursor cursor
	declare @IdP int
	declare @tip_paketa tinyint
	declare @tezina decimal(10,3)
	declare @pocetak int
	declare @kraj int
	declare @ponuda int
	declare @cena decimal(10,3)
	set @kursor = cursor for
	select i.IdP,i.tip_paketa,i.tezina,i.pocetno_mesto,i.kranje_mesto
	from inserted i

	open @kursor
	fetch next from @kursor into
	@IdP,@tip_paketa,@tezina,@pocetak,@kraj

	declare @x decimal(10,3)
	declare @y decimal(10,3)
	declare @distance float
	while @@FETCH_STATUS = 0
	begin
		if((select d.status from deleted d where d.IdP = @IdP) != 0)
		begin
			RAISERROR('Package is not in the initial state anymore.',11,1)
			rollback transaction
		end
		else
		begin 
			select @ponuda = IdP
			from Ponuda p 
			where p.IdP= @IdP
			set @distance = dbo.euklidskaDistanca(@pocetak,@kraj)

			if(@distance = -1)
			begin
				rollback transaction
				RAISERROR('Both adresess do not exist',11,1)
				
				continue
			end
			set @x = case
						  when @tip_paketa = 0 then 115
						  when @tip_paketa = 1 then 175
						  when @tip_paketa = 2 then 250
						  when @tip_paketa = 3 then 350 
					 end
		    set @y = case
						  when @tip_paketa = 0 then 0
						  when @tip_paketa = 1 then 100
						  when @tip_paketa = 2 then 100
						  when @tip_paketa = 3 then 500
					end

			set @cena =   (@x + @tezina*@y) * @distance
			
			update Ponuda 
			set Ponuda.cena = cast(@cena as decimal(10,3))
			where Ponuda.IdP = @IdP


		end
		fetch next from @kursor into
		@IdP,@tip_paketa,@tezina,@pocetak,@kraj
	end
	close @kursor
	deallocate @kursor
END

 
go


ENABLE TRIGGER [ispravi_cenu] ON Paket
go

CREATE TRIGGER [napravi_ponudu] ON Paket
   WITH 
 EXECUTE AS CALLER  AFTER INSERT 
  
  AS

BEGIN
	declare @kursor cursor
	declare @IdP int
	declare @tip_paketa tinyint
	declare @tezina decimal(10,3)
	declare @pocetak int
	declare @kraj int
	declare @ponuda int
	declare @cena decimal(10,3)
	set @kursor = cursor for
	select i.IdP,i.tip_paketa,i.tezina,i.pocetno_mesto,i.kranje_mesto
	from inserted i

	open @kursor
	fetch next from @kursor into
	@IdP,@tip_paketa,@tezina,@pocetak,@kraj

	declare @x decimal(10,3)
	declare @y decimal(10,3)
	declare @distance float
	declare @IdM int
	while @@FETCH_STATUS = 0
	begin		
		
	
			select @ponuda = IdP
			from Ponuda p 
			where p.IdP= @IdP
		
			set @distance = dbo.euklidskaDistanca(@pocetak,@kraj)
		
			if(@distance = -1)
			begin
				rollback transaction
				RAISERROR('Both adresess do not exist',11,1)
				
				continue
			end
			set @x = case
						  when @tip_paketa = 0 then 115
						  when @tip_paketa = 1 then 175
						  when @tip_paketa = 2 then 250
						  when @tip_paketa = 3 then 350 
					 end
		    set @y = case
						  when @tip_paketa = 0 then 0
						  when @tip_paketa = 1 then 100
						  when @tip_paketa = 2 then 100
						  when @tip_paketa = 3 then 500
					end

			set @cena =   (@x + @tezina*@y) * @distance
		
			insert into Ponuda (IdP,cena,prihvacena)
			values(@IdP,@cena,NULL)
			
			
			if( exists(select p.pocetno_mesto from Paket p where p.IdP = @IdP and p.pocetno_mesto in (select IdA from Magacin m)))
			begin 
				update Paket 
				set IdM = (select m.IdM from Magacin m where Paket.pocetno_mesto = m.IdA)
				where Paket.IdP = @IdP
			end
		
			fetch next from @kursor into
			@IdP,@tip_paketa,@tezina,@pocetak,@kraj
		end

		close @kursor
		deallocate @kursor

		
END

 
go


ENABLE TRIGGER [napravi_ponudu] ON Paket
go


CREATE TRIGGER tD_Administrator ON Administrator FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Administrator */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Korisnik  Administrator on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00015111", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Administrator"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_21", FK_COLUMNS="username" */
    IF EXISTS (SELECT * FROM deleted,Korisnik
      WHERE
        /* %JoinFKPK(deleted,Korisnik," = "," AND") */
        deleted.username = Korisnik.username AND
        NOT EXISTS (
          SELECT * FROM Administrator
          WHERE
            /* %JoinFKPK(Administrator,Korisnik," = "," AND") */
            Administrator.username = Korisnik.username
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Administrator because Korisnik exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Administrator ON Administrator FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Administrator */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insusername varchar(100),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Korisnik  Administrator on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00015cb0", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Administrator"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_21", FK_COLUMNS="username" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(username)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Korisnik
        WHERE
          /* %JoinFKPK(inserted,Korisnik) */
          inserted.username = Korisnik.username
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Administrator because Korisnik does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Grad ON Grad FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Grad */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Grad  Adresa on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001030b", PARENT_OWNER="", PARENT_TABLE="Grad"
    CHILD_OWNER="", CHILD_TABLE="Adresa"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_19", FK_COLUMNS="IdG" */
    IF EXISTS (
      SELECT * FROM deleted,Adresa
      WHERE
        /*  %JoinFKPK(Adresa,deleted," = "," AND") */
        Adresa.IdG = deleted.IdG
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Grad because Adresa exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Grad ON Grad FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Grad */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdG int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Grad  Adresa on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00016612", PARENT_OWNER="", PARENT_TABLE="Grad"
    CHILD_OWNER="", CHILD_TABLE="Adresa"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_19", FK_COLUMNS="IdG" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdG)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdG = inserted.IdG
        FROM inserted
      UPDATE Adresa
      SET
        /*  %JoinFKPK(Adresa,@ins," = ",",") */
        Adresa.IdG = @insIdG
      FROM Adresa,inserted,deleted
      WHERE
        /*  %JoinFKPK(Adresa,deleted," = "," AND") */
        Adresa.IdG = deleted.IdG
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Grad update because more than one row has been affected.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Kupac ON Kupac FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Kupac */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Korisnik  Kupac on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00014942", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Kupac"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="username" */
    IF EXISTS (SELECT * FROM deleted,Korisnik
      WHERE
        /* %JoinFKPK(deleted,Korisnik," = "," AND") */
        deleted.username = Korisnik.username AND
        NOT EXISTS (
          SELECT * FROM Kupac
          WHERE
            /* %JoinFKPK(Kupac,Korisnik," = "," AND") */
            Kupac.username = Korisnik.username
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Kupac because Korisnik exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Kupac ON Kupac FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Kupac */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insusername varchar(100),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Korisnik  Kupac on child update no action */
  /* ERWIN_RELATION:CHECKSUM="000163f8", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Kupac"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="username" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(username)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Korisnik
        WHERE
          /* %JoinFKPK(inserted,Korisnik) */
          inserted.username = Korisnik.username
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Kupac because Korisnik does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Kurir ON Kurir FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Kurir */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Kurir  Vozio on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002f5f5", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Vozio"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="username" */
    IF EXISTS (
      SELECT * FROM deleted,Vozio
      WHERE
        /*  %JoinFKPK(Vozio,deleted," = "," AND") */
        Vozio.username = deleted.username
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Kurir because Vozio exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Kurir  Vozi on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Vozi"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="vozac" */
    IF EXISTS (
      SELECT * FROM deleted,Vozi
      WHERE
        /*  %JoinFKPK(Vozi,deleted," = "," AND") */
        Vozi.vozac = deleted.username
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Kurir because Vozi exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Korisnik  Kurir on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_20", FK_COLUMNS="username" */
    IF EXISTS (SELECT * FROM deleted,Korisnik
      WHERE
        /* %JoinFKPK(deleted,Korisnik," = "," AND") */
        deleted.username = Korisnik.username AND
        NOT EXISTS (
          SELECT * FROM Kurir
          WHERE
            /* %JoinFKPK(Kurir,Korisnik," = "," AND") */
            Kurir.username = Korisnik.username
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Kurir because Korisnik exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Kurir ON Kurir FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Kurir */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insusername varchar(100),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Kurir  Vozio on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="0003a015", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Vozio"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="username" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(username)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insusername = inserted.username
        FROM inserted
      UPDATE Vozio
      SET
        /*  %JoinFKPK(Vozio,@ins," = ",",") */
        Vozio.username = @insusername
      FROM Vozio,inserted,deleted
      WHERE
        /*  %JoinFKPK(Vozio,deleted," = "," AND") */
        Vozio.username = deleted.username
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Kurir update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Kurir  Vozi on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Vozi"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="vozac" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(username)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Vozi
      WHERE
        /*  %JoinFKPK(Vozi,deleted," = "," AND") */
        Vozi.vozac = deleted.username
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Kurir because Vozi exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Korisnik  Kurir on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_20", FK_COLUMNS="username" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(username)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Korisnik
        WHERE
          /* %JoinFKPK(inserted,Korisnik) */
          inserted.username = Korisnik.username
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Kurir because Korisnik does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Paket ON Paket FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Paket */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Paket  Ponuda on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000229a0", PARENT_OWNER="", PARENT_TABLE="Paket"
    CHILD_OWNER="", CHILD_TABLE="Ponuda"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_39", FK_COLUMNS="IdP" */
    IF EXISTS (
      SELECT * FROM deleted,Ponuda
      WHERE
        /*  %JoinFKPK(Ponuda,deleted," = "," AND") */
        Ponuda.IdP = deleted.IdP
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Paket because Ponuda exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Vozi  Paket on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Vozi"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Paket_Vozi", FK_COLUMNS="vozac""reg_broj" */
    IF EXISTS (SELECT * FROM deleted,Vozi
      WHERE
        /* %JoinFKPK(deleted,Vozi," = "," AND") */
        deleted.vozac = Vozi.vozac AND
        deleted.reg_broj = Vozi.reg_broj AND
        NOT EXISTS (
          SELECT * FROM Paket
          WHERE
            /* %JoinFKPK(Paket,Vozi," = "," AND") */
            Paket.vozac = Vozi.vozac AND
            Paket.reg_broj = Vozi.reg_broj
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Paket because Vozi exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Ponuda ON Ponuda FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Ponuda */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Paket  Ponuda on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00011dd7", PARENT_OWNER="", PARENT_TABLE="Paket"
    CHILD_OWNER="", CHILD_TABLE="Ponuda"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_39", FK_COLUMNS="IdP" */
    IF EXISTS (SELECT * FROM deleted,Paket
      WHERE
        /* %JoinFKPK(deleted,Paket," = "," AND") */
        deleted.IdP = Paket.IdP AND
        NOT EXISTS (
          SELECT * FROM Ponuda
          WHERE
            /* %JoinFKPK(Ponuda,Paket," = "," AND") */
            Ponuda.IdP = Paket.IdP
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Ponuda because Paket exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Vozi ON Vozi FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Vozi */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Vozi  Paket on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00044516", PARENT_OWNER="", PARENT_TABLE="Vozi"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Paket_Vozi", FK_COLUMNS="vozac""reg_broj" */
    IF EXISTS (
      SELECT * FROM deleted,Paket
      WHERE
        /*  %JoinFKPK(Paket,deleted," = "," AND") */
        Paket.vozac = deleted.vozac AND
        Paket.reg_broj = deleted.reg_broj
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Vozi because Paket exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Adresa  Vozi on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Adresa"
    CHILD_OWNER="", CHILD_TABLE="Vozi"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Vozi_Adresa", FK_COLUMNS="trenutna_adresa" */
    IF EXISTS (SELECT * FROM deleted,Adresa
      WHERE
        /* %JoinFKPK(deleted,Adresa," = "," AND") */
        deleted.trenutna_adresa = Adresa.IdA AND
        NOT EXISTS (
          SELECT * FROM Vozi
          WHERE
            /* %JoinFKPK(Vozi,Adresa," = "," AND") */
            Vozi.trenutna_adresa = Adresa.IdA
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Vozi because Adresa exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Vozilo  Vozi on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="Vozi"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_23", FK_COLUMNS="reg_broj" */
    IF EXISTS (SELECT * FROM deleted,Vozilo
      WHERE
        /* %JoinFKPK(deleted,Vozilo," = "," AND") */
        deleted.reg_broj = Vozilo.reg_broj AND
        NOT EXISTS (
          SELECT * FROM Vozi
          WHERE
            /* %JoinFKPK(Vozi,Vozilo," = "," AND") */
            Vozi.reg_broj = Vozilo.reg_broj
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Vozi because Vozilo exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Kurir  Vozi on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Vozi"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="vozac" */
    IF EXISTS (SELECT * FROM deleted,Kurir
      WHERE
        /* %JoinFKPK(deleted,Kurir," = "," AND") */
        deleted.vozac = Kurir.username AND
        NOT EXISTS (
          SELECT * FROM Vozi
          WHERE
            /* %JoinFKPK(Vozi,Kurir," = "," AND") */
            Vozi.vozac = Kurir.username
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Vozi because Kurir exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Vozi ON Vozi FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Vozi */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insvozac varchar(100), 
           @insreg_broj varchar(100),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Vozi  Paket on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="000586f8", PARENT_OWNER="", PARENT_TABLE="Vozi"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Paket_Vozi", FK_COLUMNS="vozac""reg_broj" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(vozac) OR
    UPDATE(reg_broj)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insvozac = inserted.vozac, 
             @insreg_broj = inserted.reg_broj
        FROM inserted
      UPDATE Paket
      SET
        /*  %JoinFKPK(Paket,@ins," = ",",") */
        Paket.vozac = @insvozac,
        Paket.reg_broj = @insreg_broj
      FROM Paket,inserted,deleted
      WHERE
        /*  %JoinFKPK(Paket,deleted," = "," AND") */
        Paket.vozac = deleted.vozac AND
        Paket.reg_broj = deleted.reg_broj
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Vozi update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Adresa  Vozi on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Adresa"
    CHILD_OWNER="", CHILD_TABLE="Vozi"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_Vozi_Adresa", FK_COLUMNS="trenutna_adresa" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(trenutna_adresa)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Adresa
        WHERE
          /* %JoinFKPK(inserted,Adresa) */
          inserted.trenutna_adresa = Adresa.IdA
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.trenutna_adresa IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Vozi because Adresa does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Vozilo  Vozi on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="Vozi"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_23", FK_COLUMNS="reg_broj" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(reg_broj)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Vozilo
        WHERE
          /* %JoinFKPK(inserted,Vozilo) */
          inserted.reg_broj = Vozilo.reg_broj
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Vozi because Vozilo does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Kurir  Vozi on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Vozi"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="vozac" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(vozac)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Kurir
        WHERE
          /* %JoinFKPK(inserted,Kurir) */
          inserted.vozac = Kurir.username
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Vozi because Kurir does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Vozilo ON Vozilo FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Vozilo */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Vozilo  Vozio on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002e2ee", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="Vozio"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_25", FK_COLUMNS="reg_broj" */
    IF EXISTS (
      SELECT * FROM deleted,Vozio
      WHERE
        /*  %JoinFKPK(Vozio,deleted," = "," AND") */
        Vozio.reg_broj = deleted.reg_broj
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Vozilo because Vozio exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Vozilo  Vozi on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="Vozi"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_23", FK_COLUMNS="reg_broj" */
    IF EXISTS (
      SELECT * FROM deleted,Vozi
      WHERE
        /*  %JoinFKPK(Vozi,deleted," = "," AND") */
        Vozi.reg_broj = deleted.reg_broj
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Vozilo because Vozi exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Magacin  Vozilo on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Magacin"
    CHILD_OWNER="", CHILD_TABLE="Vozilo"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_36", FK_COLUMNS="IdM" */
    IF EXISTS (SELECT * FROM deleted,Magacin
      WHERE
        /* %JoinFKPK(deleted,Magacin," = "," AND") */
        deleted.IdM = Magacin.IdM AND
        NOT EXISTS (
          SELECT * FROM Vozilo
          WHERE
            /* %JoinFKPK(Vozilo,Magacin," = "," AND") */
            Vozilo.IdM = Magacin.IdM
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Vozilo because Magacin exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Vozio ON Vozio FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Vozio */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Vozilo  Vozio on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00023b2e", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="Vozio"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_25", FK_COLUMNS="reg_broj" */
    IF EXISTS (SELECT * FROM deleted,Vozilo
      WHERE
        /* %JoinFKPK(deleted,Vozilo," = "," AND") */
        deleted.reg_broj = Vozilo.reg_broj AND
        NOT EXISTS (
          SELECT * FROM Vozio
          WHERE
            /* %JoinFKPK(Vozio,Vozilo," = "," AND") */
            Vozio.reg_broj = Vozilo.reg_broj
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Vozio because Vozilo exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Kurir  Vozio on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Vozio"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="username" */
    IF EXISTS (SELECT * FROM deleted,Kurir
      WHERE
        /* %JoinFKPK(deleted,Kurir," = "," AND") */
        deleted.username = Kurir.username AND
        NOT EXISTS (
          SELECT * FROM Vozio
          WHERE
            /* %JoinFKPK(Vozio,Kurir," = "," AND") */
            Vozio.username = Kurir.username
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Vozio because Kurir exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Vozio ON Vozio FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Vozio */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdVozio int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Vozilo  Vozio on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00029434", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="Vozio"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_25", FK_COLUMNS="reg_broj" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(reg_broj)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Vozilo
        WHERE
          /* %JoinFKPK(inserted,Vozilo) */
          inserted.reg_broj = Vozilo.reg_broj
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Vozio because Vozilo does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Kurir  Vozio on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Vozio"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="username" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(username)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Kurir
        WHERE
          /* %JoinFKPK(inserted,Kurir) */
          inserted.username = Kurir.username
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Vozio because Kurir does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_ZahtevZaKurira ON ZahtevZaKurira FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ZahtevZaKurira */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Korisnik  ZahtevZaKurira on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="000155e4", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="ZahtevZaKurira"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_26", FK_COLUMNS="username" */
    IF EXISTS (SELECT * FROM deleted,Korisnik
      WHERE
        /* %JoinFKPK(deleted,Korisnik," = "," AND") */
        deleted.username = Korisnik.username AND
        NOT EXISTS (
          SELECT * FROM ZahtevZaKurira
          WHERE
            /* %JoinFKPK(ZahtevZaKurira,Korisnik," = "," AND") */
            ZahtevZaKurira.username = Korisnik.username
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last ZahtevZaKurira because Korisnik exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go

USE [mn170505]
GO

ALTER TABLE [dbo].[Korisnik]  WITH NOCHECK ADD  CONSTRAINT [provera_korisnik_1980369930] CHECK  (([tip]='A' OR [tip]='B' OR [tip]='C' OR [tip]='BC'))
GO

ALTER TABLE [dbo].[Korisnik] CHECK CONSTRAINT [provera_korisnik_1980369930]
GO


USE [mn170505]
GO

ALTER TABLE [dbo].[Kupac]  WITH NOCHECK ADD  CONSTRAINT [provera_kupac_1142622547] CHECK  (([tip]='A'))
GO

ALTER TABLE [dbo].[Kupac] CHECK CONSTRAINT [provera_kupac_1142622547]
GO


USE [mn170505]
GO

ALTER TABLE [dbo].[Kurir]  WITH NOCHECK ADD  CONSTRAINT [provera_status_vozaca_2035383898] CHECK  (([status]=(0) OR [status]=(1)))
GO

ALTER TABLE [dbo].[Kurir] CHECK CONSTRAINT [provera_status_vozaca_2035383898]
GO


USE [mn170505]
GO

ALTER TABLE [dbo].[Paket]  WITH NOCHECK ADD  CONSTRAINT [provera_status_paketa_1900118600] CHECK  (([status]=(0) OR [status]=(1) OR [status]=(2) OR [status]=(3) OR [status]=(4)))
GO

ALTER TABLE [dbo].[Paket] CHECK CONSTRAINT [provera_status_paketa_1900118600]
GO


USE [mn170505]
GO

ALTER TABLE [dbo].[Paket]  WITH NOCHECK ADD  CONSTRAINT [provera_tezina] CHECK  (([tezina]>(0)))
GO

ALTER TABLE [dbo].[Paket] CHECK CONSTRAINT [provera_tezina]
GO


USE [mn170505]
GO

ALTER TABLE [dbo].[Paket]  WITH NOCHECK ADD  CONSTRAINT [provera_tip_paketa_1731358874] CHECK  (([tip_paketa]=(0) OR [tip_paketa]=(1) OR [tip_paketa]=(2) OR [tip_paketa]=(3)))
GO

ALTER TABLE [dbo].[Paket] CHECK CONSTRAINT [provera_tip_paketa_1731358874]
GO


USE [mn170505]
GO

ALTER TABLE [dbo].[Vozi]  WITH NOCHECK ADD  CONSTRAINT [provera_kapacitet] CHECK  (([kapacitet]>=(0)))
GO

ALTER TABLE [dbo].[Vozi] CHECK CONSTRAINT [provera_kapacitet]
GO


USE [mn170505]
GO

ALTER TABLE [dbo].[Vozi]  WITH NOCHECK ADD  CONSTRAINT [provera_presao] CHECK  (([presao]>=(0)))
GO

ALTER TABLE [dbo].[Vozi] CHECK CONSTRAINT [provera_presao]
GO


USE [mn170505]
GO

ALTER TABLE [dbo].[Vozi] ADD  CONSTRAINT [Default_Value_0_810552921]  DEFAULT ((0)) FOR [kapacitet]
GO


USE [mn170505]
GO

ALTER TABLE [dbo].[Vozi] ADD  CONSTRAINT [DF_Vozi_redosled]  DEFAULT ((1)) FOR [redosled]
GO


USE [mn170505]
GO

ALTER TABLE [dbo].[Vozilo]  WITH NOCHECK ADD  CONSTRAINT [provera_nosivost] CHECK  (([nosivost]>(0)))
GO

ALTER TABLE [dbo].[Vozilo] CHECK CONSTRAINT [provera_nosivost]
GO


USE [mn170505]
GO

ALTER TABLE [dbo].[Vozilo]  WITH NOCHECK ADD  CONSTRAINT [provera_potrosnja] CHECK  (([potrosnja]>(0)))
GO

ALTER TABLE [dbo].[Vozilo] CHECK CONSTRAINT [provera_potrosnja]
GO


USE [mn170505]
GO

ALTER TABLE [dbo].[Vozilo]  WITH NOCHECK ADD  CONSTRAINT [provera_tip_goriva_2143105594] CHECK  (([tip_goriva]=(0) OR [tip_goriva]=(1) OR [tip_goriva]=(2)))
GO

ALTER TABLE [dbo].[Vozilo] CHECK CONSTRAINT [provera_tip_goriva_2143105594]
GO


USE [mn170505]
GO

/****** Object:  Trigger [dbo].[promeni_tip_korisnika]    Script Date: 25.6.2022. 23:20:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[promeni_tip_korisnika]
   ON  [dbo].[Administrator]
   AFTER INSERT
AS 
BEGIN
	
	declare @kursor cursor
	declare @username varchar(100)

	set @kursor = cursor for
	select username from inserted

	open @kursor

	fetch next from @kursor into
	@username

	while @@FETCH_STATUS = 0
	begin

		if((select k.tip
			from Korisnik k
			where k.username = @username) = 'B')
		begin  
			update Korisnik 
			set Korisnik.tip = 'BC'
			where Korisnik.username = @username
			update Kurir 
			set Kurir.tip = 'BC'
			where Kurir.username = @username
			update Administrator 
			set Administrator.tip = 'BC'
			where Administrator.username = @username
			
		end
		else 
		if(ISNULL((select k.tip from Korisnik k where k.username = @username),-1) = -1)
		begin
			update Korisnik 
			set Korisnik.tip = 'C'
			where Korisnik.username = @username
			
		end
		else rollback transaction

		fetch next from @kursor into
		@username
	end
	close @kursor
	deallocate @kursor

END
GO

ALTER TABLE [dbo].[Administrator] ENABLE TRIGGER [promeni_tip_korisnika]
GO

USE [mn170505]
GO

/****** Object:  Trigger [dbo].[tD_Adresa]    Script Date: 25.6.2022. 23:22:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tD_Adresa] ON [dbo].[Adresa]
   WITH 
 EXECUTE AS CALLER  AFTER DELETE 
  
  AS

/* erwin Builtin Trigger */
/* DELETE trigger on Adresa */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Adresa  Paket on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00055e57", PARENT_OWNER="", PARENT_TABLE="Adresa"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_33", FK_COLUMNS="kranje_mesto" */
    IF EXISTS (
      SELECT * FROM deleted,Paket
      WHERE
        /*  JoinFKPK" = "," AND") */
        Paket.kranje_mesto = deleted.IdA
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Adresa because Paket exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Adresa  Paket on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Adresa"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_32", FK_COLUMNS="pocetno_mesto" */
    IF EXISTS (
      SELECT * FROM deleted,Paket
      WHERE
        /*  JoinFKPK" = "," AND") */
        Paket.pocetno_mesto = deleted.IdA
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Adresa because Paket exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Adresa  Magacin on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Adresa"
    CHILD_OWNER="", CHILD_TABLE="Magacin"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_34", FK_COLUMNS="IdA" */
    IF EXISTS (
      SELECT * FROM deleted,Magacin
      WHERE
        /*  JoinFKPK" = "," AND") */
        Magacin.IdA = deleted.IdA
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Adresa because Magacin exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Adresa  Korisnik on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Adresa"
    CHILD_OWNER="", CHILD_TABLE="Korisnik"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="IdA" */
    IF EXISTS (
      SELECT * FROM deleted,Korisnik
      WHERE
        /*  JoinFKPK" = "," AND") */
        Korisnik.IdA = deleted.IdA
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Adresa because Korisnik exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

 
 
GO

ALTER TABLE [dbo].[Adresa] ENABLE TRIGGER [tD_Adresa]
GO


USE [mn170505]
GO

/****** Object:  Trigger [dbo].[tU_Adresa]    Script Date: 25.6.2022. 23:23:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tU_Adresa] ON [dbo].[Adresa] FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Adresa */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdA int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Adresa  Vozi on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00058a7e", PARENT_OWNER="", PARENT_TABLE="Adresa"
    CHILD_OWNER="", CHILD_TABLE="Vozi"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_40", FK_COLUMNS="trenutno_mesto" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdA)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Vozi
      WHERE
        /*  %JoinFKPK(Vozi,deleted," = "," AND") */
        Vozi.trenutno_mesto = deleted.IdA
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Adresa because Vozi exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Adresa  Paket on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Adresa"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_33", FK_COLUMNS="kranje_mesto" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdA)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Paket
      WHERE
        /*  %JoinFKPK(Paket,deleted," = "," AND") */
        Paket.kranje_mesto = deleted.IdA
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Adresa because Paket exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Adresa  Paket on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Adresa"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_32", FK_COLUMNS="pocetno_mesto" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdA)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Paket
      WHERE
        /*  %JoinFKPK(Paket,deleted," = "," AND") */
        Paket.pocetno_mesto = deleted.IdA
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Adresa because Paket exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Adresa  Magacin on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Adresa"
    CHILD_OWNER="", CHILD_TABLE="Magacin"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_34", FK_COLUMNS="IdA" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdA)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdA = inserted.IdA
        FROM inserted
      UPDATE Magacin
      SET
        /*  %JoinFKPK(Magacin,@ins," = ",",") */
        Magacin.IdA = @insIdA
      FROM Magacin,inserted,deleted
      WHERE
        /*  %JoinFKPK(Magacin,deleted," = "," AND") */
        Magacin.IdA = deleted.IdA
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Adresa update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Adresa  Korisnik on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Adresa"
    CHILD_OWNER="", CHILD_TABLE="Korisnik"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="IdA" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdA)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdA = inserted.IdA
        FROM inserted
      UPDATE Korisnik
      SET
        /*  %JoinFKPK(Korisnik,@ins," = ",",") */
        Korisnik.IdA = @insIdA
      FROM Korisnik,inserted,deleted
      WHERE
        /*  %JoinFKPK(Korisnik,deleted," = "," AND") */
        Korisnik.IdA = deleted.IdA
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Adresa update because more than one row has been affected.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END
GO

ALTER TABLE [dbo].[Adresa] ENABLE TRIGGER [tU_Adresa]
GO


USE [mn170505]
GO

/****** Object:  Trigger [dbo].[tD_Grad]    Script Date: 25.6.2022. 23:23:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tD_Grad] ON [dbo].[Grad] FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Grad */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Grad  Adresa on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001030b", PARENT_OWNER="", PARENT_TABLE="Grad"
    CHILD_OWNER="", CHILD_TABLE="Adresa"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_19", FK_COLUMNS="IdG" */
    IF EXISTS (
      SELECT * FROM deleted,Adresa
      WHERE
        /*  %JoinFKPK(Adresa,deleted," = "," AND") */
        Adresa.IdG = deleted.IdG
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Grad because Adresa exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END
GO

ALTER TABLE [dbo].[Grad] ENABLE TRIGGER [tD_Grad]
GO


USE [mn170505]
GO

/****** Object:  Trigger [dbo].[tU_Grad]    Script Date: 25.6.2022. 23:23:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tU_Grad] ON [dbo].[Grad] FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Grad */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdG int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Grad  Adresa on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00016612", PARENT_OWNER="", PARENT_TABLE="Grad"
    CHILD_OWNER="", CHILD_TABLE="Adresa"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_19", FK_COLUMNS="IdG" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdG)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdG = inserted.IdG
        FROM inserted
      UPDATE Adresa
      SET
        /*  %JoinFKPK(Adresa,@ins," = ",",") */
        Adresa.IdG = @insIdG
      FROM Adresa,inserted,deleted
      WHERE
        /*  %JoinFKPK(Adresa,deleted," = "," AND") */
        Adresa.IdG = deleted.IdG
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Grad update because more than one row has been affected.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END
GO

ALTER TABLE [dbo].[Grad] ENABLE TRIGGER [tU_Grad]
GO


USE [mn170505]
GO

/****** Object:  Trigger [dbo].[vec_postoji]    Script Date: 25.6.2022. 23:23:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[vec_postoji] 
   ON  [dbo].[Grad]
   AFTER INSERT,UPDATE
AS 
BEGIN
	
	if(exists (
	    select PB
	    from Grad 
		group by PB
		having count(*) > 1
		) ) 
	begin
		rollback transaction 
		raiserror('Cannot insert city with th same PB and name',11,1)
	end
END
GO

ALTER TABLE [dbo].[Grad] ENABLE TRIGGER [vec_postoji]
GO


USE [mn170505]
GO

/****** Object:  Trigger [dbo].[tD_Korisnik]    Script Date: 25.6.2022. 23:23:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tD_Korisnik] ON [dbo].[Korisnik] FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Korisnik */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Korisnik  Paket on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00045b8a", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_20", FK_COLUMNS="vlasnik" */
    IF EXISTS (
      SELECT * FROM deleted,Paket
      WHERE
        /*  %JoinFKPK(Paket,deleted," = "," AND") */
        Paket.vlasnik = deleted.username
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Korisnik because Paket exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Korisnik  ZahtevZaKurira on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="ZahtevZaKurira"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_26", FK_COLUMNS="username" */
    DELETE ZahtevZaKurira
      FROM ZahtevZaKurira,deleted
      WHERE
        /*  %JoinFKPK(ZahtevZaKurira,deleted," = "," AND") */
        ZahtevZaKurira.username = deleted.username

    /* erwin Builtin Trigger */
    /* Korisnik  Kurir on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_20", FK_COLUMNS="username" */
    IF EXISTS (
      SELECT * FROM deleted,Kurir
      WHERE
        /*  %JoinFKPK(Kurir,deleted," = "," AND") */
        Kurir.username = deleted.username
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Korisnik because Kurir exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Korisnik  Kupac on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Kupac"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="username" */
    IF EXISTS (
      SELECT * FROM deleted,Kupac
      WHERE
        /*  %JoinFKPK(Kupac,deleted," = "," AND") */
        Kupac.username = deleted.username
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Korisnik because Kupac exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Korisnik  Administrator on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Administrator"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_21", FK_COLUMNS="username" */
    DELETE Administrator
      FROM Administrator,deleted
      WHERE
        /*  %JoinFKPK(Administrator,deleted," = "," AND") */
        Administrator.username = deleted.username


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END
GO

ALTER TABLE [dbo].[Korisnik] ENABLE TRIGGER [tD_Korisnik]
GO


USE [mn170505]
GO

/****** Object:  Trigger [dbo].[tU_Korisnik]    Script Date: 25.6.2022. 23:24:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tU_Korisnik] ON [dbo].[Korisnik] FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Korisnik */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insusername varchar(100),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Korisnik  Paket on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="0006dda0", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_20", FK_COLUMNS="vlasnik" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(username)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insusername = inserted.username
        FROM inserted
      UPDATE Paket
      SET
        /*  %JoinFKPK(Paket,@ins," = ",",") */
        Paket.vlasnik = @insusername
      FROM Paket,inserted,deleted
      WHERE
        /*  %JoinFKPK(Paket,deleted," = "," AND") */
        Paket.vlasnik = deleted.username
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Korisnik update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Korisnik  ZahtevZaKurira on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="ZahtevZaKurira"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_26", FK_COLUMNS="username" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(username)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insusername = inserted.username
        FROM inserted
      UPDATE ZahtevZaKurira
      SET
        /*  %JoinFKPK(ZahtevZaKurira,@ins," = ",",") */
        ZahtevZaKurira.username = @insusername
      FROM ZahtevZaKurira,inserted,deleted
      WHERE
        /*  %JoinFKPK(ZahtevZaKurira,deleted," = "," AND") */
        ZahtevZaKurira.username = deleted.username
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Korisnik update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Korisnik  Kurir on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_20", FK_COLUMNS="username" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(username)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insusername = inserted.username
        FROM inserted
      UPDATE Kurir
      SET
        /*  %JoinFKPK(Kurir,@ins," = ",",") */
        Kurir.username = @insusername
      FROM Kurir,inserted,deleted
      WHERE
        /*  %JoinFKPK(Kurir,deleted," = "," AND") */
        Kurir.username = deleted.username
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Korisnik update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Korisnik  Kupac on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Kupac"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="username" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(username)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insusername = inserted.username
        FROM inserted
      UPDATE Kupac
      SET
        /*  %JoinFKPK(Kupac,@ins," = ",",") */
        Kupac.username = @insusername
      FROM Kupac,inserted,deleted
      WHERE
        /*  %JoinFKPK(Kupac,deleted," = "," AND") */
        Kupac.username = deleted.username
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Korisnik update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Korisnik  Administrator on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Administrator"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_21", FK_COLUMNS="username" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(username)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insusername = inserted.username
        FROM inserted
      UPDATE Administrator
      SET
        /*  %JoinFKPK(Administrator,@ins," = ",",") */
        Administrator.username = @insusername
      FROM Administrator,inserted,deleted
      WHERE
        /*  %JoinFKPK(Administrator,deleted," = "," AND") */
        Administrator.username = deleted.username
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Korisnik update because more than one row has been affected.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END
GO

ALTER TABLE [dbo].[Korisnik] ENABLE TRIGGER [tU_Korisnik]
GO

USE [mn170505]
GO

/****** Object:  Trigger [dbo].[provera_jedinstvenosti_vozacke]    Script Date: 25.6.2022. 23:27:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[provera_jedinstvenosti_vozacke]  
   ON  [dbo].[Kurir] 
   AFTER INSERT,UPDATE
AS 
BEGIN
	
	declare @kursor cursor
	declare @username varchar(100)
	declare @broj_vozacke int
	declare @tabela TABLE(username varchar(100),reg_broj varchar(100))

	set @kursor = cursor for
	select username, broj_vozacke
	from inserted

	insert into @tabela 
	select inserted.username,inserted.broj_vozacke from inserted

	open @kursor

	fetch next from @kursor into
	@username,@broj_vozacke
	--select * from inserted

	while @@FETCH_STATUS = 0
	begin
		if(exists
			(
				select k.broj_vozacke
				from Kurir k
				where k.broj_vozacke like @broj_vozacke and k.username not in (select username from @tabela)
			)
		)
		begin
			rollback transaction
			raiserror('Courier with the same registration license already exists',11,1)
		end

		delete from @tabela where username = @username
		fetch next from @kursor into
		@username,@broj_vozacke

	end

	close @kursor
	deallocate @kursor

END
GO

ALTER TABLE [dbo].[Kurir] ENABLE TRIGGER [provera_jedinstvenosti_vozacke]
GO


USE [mn170505]
GO

/****** Object:  Trigger [dbo].[provera_kurir]    Script Date: 25.6.2022. 23:27:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER  [dbo].[provera_kurir]
   ON  [dbo].[Kurir] 
   AFTER INSERT
AS 
BEGIN
	declare @kursor cursor
	declare @username varchar(100)
	declare @tip varchar(2)

	set @kursor = cursor for
	select username,tip
	from inserted

	open @kursor

	fetch next from @kursor into
	@username,@tip

	while @@FETCH_STATUS = 0
	begin
		if(@tip != 'B') 
		begin
			rollback transaction
			raiserror('Cannot insert Kurir, type can only have value B',11,1)
			return
		end
		if( not exists(
				  select * from Korisnik k where k.username = @username and k.tip is null))
		begin
			rollback transaction
			raiserror('Cannot insert Kurir, Korisnik does not exist',11,1)
		end
		else 
		begin
			update Korisnik set Korisnik.tip = 'B' where Korisnik.username = @username
		end
		fetch next from @kursor into
		@username,@tip

	end

	close @kursor
	deallocate @kursor

END
GO

ALTER TABLE [dbo].[Kurir] ENABLE TRIGGER [provera_kurir]
GO


USE [mn170505]
GO

/****** Object:  Trigger [dbo].[tD_Kurir]    Script Date: 25.6.2022. 23:28:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tD_Kurir] ON [dbo].[Kurir] FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Kurir */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Kurir  Vozio on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001d772", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Vozio"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="username" */
    IF EXISTS (
      SELECT * FROM deleted,Vozio
      WHERE
        /*  %JoinFKPK(Vozio,deleted," = "," AND") */
        Vozio.username = deleted.username
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Kurir because Vozio exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Kurir  Vozi on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Vozi"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="vozac" */
    IF EXISTS (
      SELECT * FROM deleted,Vozi
      WHERE
        /*  %JoinFKPK(Vozi,deleted," = "," AND") */
        Vozi.vozac = deleted.username
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Kurir because Vozi exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END
GO

ALTER TABLE [dbo].[Kurir] ENABLE TRIGGER [tD_Kurir]
GO


USE [mn170505]
GO

/****** Object:  Trigger [dbo].[tU_Kurir]    Script Date: 25.6.2022. 23:28:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tU_Kurir] ON [dbo].[Kurir] FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Kurir */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insusername varchar(100),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Kurir  Vozio on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00025d46", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Vozio"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="username" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(username)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insusername = inserted.username
        FROM inserted
      UPDATE Vozio
      SET
        /*  %JoinFKPK(Vozio,@ins," = ",",") */
        Vozio.username = @insusername
      FROM Vozio,inserted,deleted
      WHERE
        /*  %JoinFKPK(Vozio,deleted," = "," AND") */
        Vozio.username = deleted.username
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Kurir update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Kurir  Vozi on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Vozi"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="vozac" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(username)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Vozi
      WHERE
        /*  %JoinFKPK(Vozi,deleted," = "," AND") */
        Vozi.vozac = deleted.username
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Kurir because Vozi exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END
GO

ALTER TABLE [dbo].[Kurir] ENABLE TRIGGER [tU_Kurir]
GO


USE [mn170505]
GO

/****** Object:  Trigger [dbo].[jedinstvenost_u_gradu]    Script Date: 25.6.2022. 23:28:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[jedinstvenost_u_gradu]
   ON [dbo].[Magacin]
   AFTER INSERT,UPDATE
AS 
BEGIN
	
	if(exists(
		select g.IdG
		from Magacin m join Grad g on g.IdG in (select a.IdG from Adresa a where a.IdA = m.IdA ) 
		group by g.IdG
		having count(*) > 1
	)
	)
	begin
		rollback transaction 
		raiserror('Cannot insert more than one stockroom in the same city.',11,1)
	end

END
GO

ALTER TABLE [dbo].[Magacin] ENABLE TRIGGER [jedinstvenost_u_gradu]
GO


USE [mn170505]
GO

/****** Object:  Trigger [dbo].[tD_Magacin]    Script Date: 25.6.2022. 23:28:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tD_Magacin] ON [dbo].[Magacin] FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Magacin */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Magacin  Vozilo on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001c4cd", PARENT_OWNER="", PARENT_TABLE="Magacin"
    CHILD_OWNER="", CHILD_TABLE="Vozilo"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_36", FK_COLUMNS="IdM" */
    IF EXISTS (
      SELECT * FROM deleted,Vozilo
      WHERE
        /*  %JoinFKPK(Vozilo,deleted," = "," AND") */
        Vozilo.IdM = deleted.IdM
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Magacin because Vozilo exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Magacin  Paket on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Magacin"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_37", FK_COLUMNS="IdM" */
    IF EXISTS (
      SELECT * FROM deleted,Paket
      WHERE
        /*  %JoinFKPK(Paket,deleted," = "," AND") */
        Paket.IdM = deleted.IdM
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Magacin because Paket exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END
GO

ALTER TABLE [dbo].[Magacin] ENABLE TRIGGER [tD_Magacin]
GO


USE [mn170505]
GO

/****** Object:  Trigger [dbo].[tU_Magacin]    Script Date: 25.6.2022. 23:28:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tU_Magacin] ON [dbo].[Magacin] FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Magacin */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdM int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Magacin  Vozilo on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0001f5f0", PARENT_OWNER="", PARENT_TABLE="Magacin"
    CHILD_OWNER="", CHILD_TABLE="Vozilo"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_36", FK_COLUMNS="IdM" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdM)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Vozilo
      WHERE
        /*  %JoinFKPK(Vozilo,deleted," = "," AND") */
        Vozilo.IdM = deleted.IdM
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Magacin because Vozilo exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Magacin  Paket on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Magacin"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_37", FK_COLUMNS="IdM" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdM)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Paket
      WHERE
        /*  %JoinFKPK(Paket,deleted," = "," AND") */
        Paket.IdM = deleted.IdM
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Magacin because Paket exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END
GO

ALTER TABLE [dbo].[Magacin] ENABLE TRIGGER [tU_Magacin]
GO


USE [mn170505]
GO

/****** Object:  Trigger [dbo].[ispravi_cenu]    Script Date: 25.6.2022. 23:28:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[ispravi_cenu] ON [dbo].[Paket]
   WITH 
 EXECUTE AS CALLER  AFTER UPDATE 
  
  AS

IF(UPDATE(tip_paketa) or UPDATE(tezina) or UPDATE(pocetno_mesto) or UPDATE(kranje_mesto))
BEGIN
	
	declare @kursor cursor
	declare @IdP int
	declare @tip_paketa tinyint
	declare @tezina decimal(10,3)
	declare @pocetak int
	declare @kraj int
	declare @ponuda int
	declare @cena decimal(10,3)
	set @kursor = cursor for
	select i.IdP,i.tip_paketa,i.tezina,i.pocetno_mesto,i.kranje_mesto
	from inserted i

	open @kursor
	fetch next from @kursor into
	@IdP,@tip_paketa,@tezina,@pocetak,@kraj

	declare @x decimal(10,3)
	declare @y decimal(10,3)
	declare @distance float
	while @@FETCH_STATUS = 0
	begin
		if((select d.status from deleted d where d.IdP = @IdP) != 0)
		begin
			RAISERROR('Package is not in the initial state anymore.',11,1)
			rollback transaction
		end
		else
		begin 
			select @ponuda = IdP
			from Ponuda p 
			where p.IdP= @IdP
			set @distance = dbo.euklidskaDistanca(@pocetak,@kraj)

			if(@distance = -1)
			begin
				rollback transaction
				RAISERROR('Both adresess do not exist',11,1)
				
				continue
			end
			set @x = case
						  when @tip_paketa = 0 then 115
						  when @tip_paketa = 1 then 175
						  when @tip_paketa = 2 then 250
						  when @tip_paketa = 3 then 350 
					 end
		    set @y = case
						  when @tip_paketa = 0 then 0
						  when @tip_paketa = 1 then 100
						  when @tip_paketa = 2 then 100
						  when @tip_paketa = 3 then 500
					end

			set @cena =   (@x + @tezina*@y) * @distance
			
			update Ponuda 
			set Ponuda.cena = cast(@cena as decimal(10,3))
			where Ponuda.IdP = @IdP


		end
		fetch next from @kursor into
		@IdP,@tip_paketa,@tezina,@pocetak,@kraj
	end
	close @kursor
	deallocate @kursor
END
GO

ALTER TABLE [dbo].[Paket] ENABLE TRIGGER [ispravi_cenu]
GO


USE [mn170505]
GO

/****** Object:  Trigger [dbo].[napravi_ponudu]    Script Date: 25.6.2022. 23:29:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[napravi_ponudu] ON [dbo].[Paket]
   WITH 
 EXECUTE AS CALLER  AFTER INSERT 
  
  AS

BEGIN
	declare @kursor cursor
	declare @IdP int
	declare @tip_paketa tinyint
	declare @tezina decimal(10,3)
	declare @pocetak int
	declare @kraj int
	declare @ponuda int
	declare @cena decimal(10,3)
	set @kursor = cursor for
	select i.IdP,i.tip_paketa,i.tezina,i.pocetno_mesto,i.kranje_mesto
	from inserted i

	open @kursor
	fetch next from @kursor into
	@IdP,@tip_paketa,@tezina,@pocetak,@kraj

	declare @x decimal(10,3)
	declare @y decimal(10,3)
	declare @distance float
	declare @IdM int
	while @@FETCH_STATUS = 0
	begin		
		
	
			select @ponuda = IdP
			from Ponuda p 
			where p.IdP= @IdP
		
			set @distance = dbo.euklidskaDistanca(@pocetak,@kraj)
		
			if(@distance = -1)
			begin
				rollback transaction
				RAISERROR('Both adresess do not exist',11,1)
				
				continue
			end
			set @x = case
						  when @tip_paketa = 0 then 115
						  when @tip_paketa = 1 then 175
						  when @tip_paketa = 2 then 250
						  when @tip_paketa = 3 then 350 
					 end
		    set @y = case
						  when @tip_paketa = 0 then 0
						  when @tip_paketa = 1 then 100
						  when @tip_paketa = 2 then 100
						  when @tip_paketa = 3 then 500
					end

			set @cena =   (@x + @tezina*@y) * @distance
		
			insert into Ponuda (IdP,cena,prihvacena)
			values(@IdP,@cena,NULL)
			
			
			if( exists(select p.pocetno_mesto from Paket p where p.IdP = @IdP and p.pocetno_mesto in (select IdA from Magacin m)))
			begin 
				update Paket 
				set IdM = (select m.IdM from Magacin m where Paket.pocetno_mesto = m.IdA)
				where Paket.IdP = @IdP
			end
		
			fetch next from @kursor into
			@IdP,@tip_paketa,@tezina,@pocetak,@kraj
		end

		close @kursor
		deallocate @kursor

		
END
GO

ALTER TABLE [dbo].[Paket] ENABLE TRIGGER [napravi_ponudu]
GO


USE [mn170505]
GO

/****** Object:  Trigger [dbo].[tD_Paket]    Script Date: 25.6.2022. 23:29:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tD_Paket] ON [dbo].[Paket] FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Paket */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Paket  Ponuda on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001027a", PARENT_OWNER="", PARENT_TABLE="Paket"
    CHILD_OWNER="", CHILD_TABLE="Ponuda"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_39", FK_COLUMNS="IdP" */
    IF EXISTS (
      SELECT * FROM deleted,Ponuda
      WHERE
        /*  %JoinFKPK(Ponuda,deleted," = "," AND") */
        Ponuda.IdP = deleted.IdP
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Paket because Ponuda exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END
GO

ALTER TABLE [dbo].[Paket] ENABLE TRIGGER [tD_Paket]
GO


USE [mn170505]
GO

/****** Object:  Trigger [dbo].[promena_statusa_paketa]    Script Date: 25.6.2022. 23:29:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[promena_statusa_paketa] ON [dbo].[Ponuda]
   WITH 
 EXECUTE AS CALLER  AFTER UPDATE 
  
  AS

if(UPDATE(prihvacena))
BEGIN
	
	declare @kursor cursor
	declare @IdP int
	declare @prihvacena int

	set @kursor = cursor for
	select IdP,prihvacena from inserted

	open @kursor
	fetch next from @kursor into 
	@IdP,@prihvacena

	while @@FETCH_STATUS = 0
	begin
		if(
			(select p.status from Paket p where p.IdP = @IdP) = 0
		)
		begin
			if(@prihvacena = 0)  update Paket set Paket.status = 4 where Paket.IdP = @IdP
			else if(@prihvacena = 1) 
				begin 
					update Paket set Paket.status = 1 where Paket.IdP = @IdP
					--WAITFOR DELAY '00:00:01'
					update Paket set Paket.Date_prihvatanja = CURRENT_TIMESTAMP where Paket.IdP = @IdP
					--ako ne postoji metoda u paketu koja ce da ga stavi u odgovarajuci magacin
					--update Paket
					--set Paket.IdM = (select IdM from Magacin where Magacin.IdA = Paket.pocetno_mesto)
					--where Paket.IdP = @IdP
				end

		end
		else
		begin
			rollback transaction
			RAISERROR('Cannot update Ponuda, the decision has already been made.',11,1)
		end
		
		fetch next from @kursor into 
		@Idp,@prihvacena
	end
	close @kursor
	deallocate @kursor
END

 
 
 
GO

ALTER TABLE [dbo].[Ponuda] ENABLE TRIGGER [promena_statusa_paketa]
GO


USE [mn170505]
GO

/****** Object:  Trigger [dbo].[provera_jedinstvenosti]    Script Date: 25.6.2022. 23:30:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[provera_jedinstvenosti] ON [dbo].[Vozi]
   WITH 
 EXECUTE AS CALLER  AFTER INSERT,UPDATE 
  
  AS

BEGIN
	
	if(exists(
		select count(*)
		from Vozi v 
		group by v.vozac
		having count(*) > 1
	) or exists(
		select count(*)
		from Vozi v 
		group by v.reg_broj
		having count(*) > 1
	)
	)
	begin
		rollback transaction
	end

END
GO

ALTER TABLE [dbo].[Vozi] ENABLE TRIGGER [provera_jedinstvenosti]
GO


USE [mn170505]
GO

/****** Object:  Trigger [dbo].[tD_Vozi]    Script Date: 25.6.2022. 23:30:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tD_Vozi] ON [dbo].[Vozi] FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Vozi */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Vozi  Paket on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00010a67", PARENT_OWNER="", PARENT_TABLE="Vozi"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_35", FK_COLUMNS="vozac""reg_broj" */
    IF EXISTS (
      SELECT * FROM deleted,Paket
      WHERE
        /*  %JoinFKPK(Paket,deleted," = "," AND") */
        Paket.vozac = deleted.vozac AND
        Paket.reg_broj = deleted.reg_broj
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Vozi because Paket exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END
GO

ALTER TABLE [dbo].[Vozi] ENABLE TRIGGER [tD_Vozi]
GO


USE [mn170505]
GO

/****** Object:  Trigger [dbo].[tU_Vozi]    Script Date: 25.6.2022. 23:30:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tU_Vozi] ON [dbo].[Vozi] FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Vozi */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insvozac varchar(100), 
           @insreg_broj int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Vozi  Paket on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="0001a73d", PARENT_OWNER="", PARENT_TABLE="Vozi"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_35", FK_COLUMNS="vozac""reg_broj" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(vozac) OR
    UPDATE(reg_broj)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insvozac = inserted.vozac, 
             @insreg_broj = inserted.reg_broj
        FROM inserted
      UPDATE Paket
      SET
        /*  %JoinFKPK(Paket,@ins," = ",",") */
        Paket.vozac = @insvozac,
        Paket.reg_broj = @insreg_broj
      FROM Paket,inserted,deleted
      WHERE
        /*  %JoinFKPK(Paket,deleted," = "," AND") */
        Paket.vozac = deleted.vozac AND
        Paket.reg_broj = deleted.reg_broj
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Vozi update because more than one row has been affected.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END
GO

ALTER TABLE [dbo].[Vozi] ENABLE TRIGGER [tU_Vozi]
GO


USE [mn170505]
GO

/****** Object:  Trigger [dbo].[provera_promena]    Script Date: 25.6.2022. 23:30:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[provera_promena]
   ON  [dbo].[Vozilo]
   AFTER UPDATE
AS 
IF( UPDATE(tip_goriva) or UPDATE(potrosnja) or UPDATE(nosivost) )
BEGIN
	if(exists(
		select i.reg_broj
		from inserted i
		where i.IdM is null
	))
	begin
		rollback transaction	
		raiserror('Cannot make a change on vehicle because it is not in Stockroom', 11,1)
	end

END
GO

ALTER TABLE [dbo].[Vozilo] ENABLE TRIGGER [provera_promena]
GO


USE [mn170505]
GO

/****** Object:  Trigger [dbo].[tD_Vozilo]    Script Date: 25.6.2022. 23:30:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tD_Vozilo] ON [dbo].[Vozilo] FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Vozilo */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Vozilo  Vozio on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001d54c", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="Vozio"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_25", FK_COLUMNS="reg_broj" */
    IF EXISTS (
      SELECT * FROM deleted,Vozio
      WHERE
        /*  %JoinFKPK(Vozio,deleted," = "," AND") */
        Vozio.reg_broj = deleted.reg_broj
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Vozilo because Vozio exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Vozilo  Vozi on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="Vozi"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_23", FK_COLUMNS="reg_broj" */
    IF EXISTS (
      SELECT * FROM deleted,Vozi
      WHERE
        /*  %JoinFKPK(Vozi,deleted," = "," AND") */
        Vozi.reg_broj = deleted.reg_broj
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Vozilo because Vozi exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END
GO

ALTER TABLE [dbo].[Vozilo] ENABLE TRIGGER [tD_Vozilo]
GO


USE [mn170505]
GO

/****** Object:  Trigger [dbo].[tU_Vozilo]    Script Date: 25.6.2022. 23:30:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tU_Vozilo] ON [dbo].[Vozilo] FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Vozilo */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insreg_broj int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Vozilo  Vozio on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="0002ab2d", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="Vozio"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_25", FK_COLUMNS="reg_broj" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(reg_broj)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insreg_broj = inserted.reg_broj
        FROM inserted
      UPDATE Vozio
      SET
        /*  %JoinFKPK(Vozio,@ins," = ",",") */
        Vozio.reg_broj = @insreg_broj
      FROM Vozio,inserted,deleted
      WHERE
        /*  %JoinFKPK(Vozio,deleted," = "," AND") */
        Vozio.reg_broj = deleted.reg_broj
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Vozilo update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Vozilo  Vozi on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="Vozi"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_23", FK_COLUMNS="reg_broj" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(reg_broj)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insreg_broj = inserted.reg_broj
        FROM inserted
      UPDATE Vozi
      SET
        /*  %JoinFKPK(Vozi,@ins," = ",",") */
        Vozi.reg_broj = @insreg_broj
      FROM Vozi,inserted,deleted
      WHERE
        /*  %JoinFKPK(Vozi,deleted," = "," AND") */
        Vozi.reg_broj = deleted.reg_broj
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Vozilo update because more than one row has been affected.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END
GO

ALTER TABLE [dbo].[Vozilo] ENABLE TRIGGER [tU_Vozilo]
GO


USE [mn170505]
GO

/****** Object:  Trigger [dbo].[postavi_kurira]    Script Date: 25.6.2022. 23:30:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[postavi_kurira] ON [dbo].[ZahtevZaKurira]
   WITH 
 EXECUTE AS CALLER  AFTER UPDATE 
  
  AS

IF(UPDATE(prihvaceno))
BEGIN
	declare @kursor cursor
	declare @username varchar(100)
	declare @br_vozacke int
	declare @status bit

	set @kursor = cursor for
	select username,br_vozacke,prihvaceno from inserted


	if((select count(*)
	   from inserted
	   group by inserted.username) > 1) 
	   begin
			rollback transaction
			raiserror('Cannot change the requset multiple times on a same user.',11,1)
	   end



	open @kursor
	fetch next from @kursor into
	@username,@br_vozacke,@status




	while @@FETCH_STATUS = 0
	begin
		if( (select d.prihvaceno from deleted d where d.username = @username) is not null)
		begin
			rollback transaction
			raiserror('Cannot change the requset multiple times on a same user.',11,1)
		end
		if(@status = 1)
		begin
			insert into Kurir
			values (@username,'B',@br_vozacke,0)

			update Korisnik
			set Korisnik.tip = 'B'
			where Korisnik.username = @username
		end
		fetch next from @kursor into
		@username,@br_vozacke,@status
	end
	close @kursor
	deallocate @kursor
END
GO

ALTER TABLE [dbo].[ZahtevZaKurira] ENABLE TRIGGER [postavi_kurira]
GO


USE [mn170505]
GO

/****** Object:  Trigger [dbo].[provera_jedinstvenosti_brojaVozacke]    Script Date: 25.6.2022. 23:31:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[provera_jedinstvenosti_brojaVozacke]
   ON  [dbo].[ZahtevZaKurira]
   AFTER UPDATE
AS 
IF(UPDATE(br_vozacke))
BEGIN
	declare @kursor cursor
	declare @username varchar(100)
	declare @br_vozacke int
	declare @table TABLE(username varchar(100))
	insert into @table
	select inserted.username
	from inserted

	set @kursor = cursor for
	select username,br_vozacke from inserted

	open @kursor
	fetch next from @kursor into
	@username,@br_vozacke

	while @@FETCH_STATUS = 0
	begin
		if(exists(
			select z.username
			from ZahtevZaKurira z
			where z.br_vozacke = @br_vozacke and z.username not in (select username from @table)
		))
		begin
			raiserror('Request with the same license plate has already been submited!',11,1)
			rollback transaction
		end
		delete from @table
		where username = @username
		fetch next from @kursor into
		@username,@br_vozacke
	end
	close @kursor
	deallocate @kursor

END
GO

ALTER TABLE [dbo].[ZahtevZaKurira] ENABLE TRIGGER [provera_jedinstvenosti_brojaVozacke]
GO


USE [mn170505]
GO

/****** Object:  Trigger [dbo].[provera_unos]    Script Date: 25.6.2022. 23:31:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[provera_unos]
   ON  [dbo].[ZahtevZaKurira]
   AFTER INSERT
AS 
BEGIN
	declare @kursor cursor
	declare @username varchar(100)
	declare @br_vozacke varchar(100)
	declare @table TABLE(username varchar(100))
	insert into @table
	select inserted.username
	from inserted

	set @kursor = cursor for
	select username,br_vozacke
	from inserted

	open @kursor

	fetch next from @kursor into
	@username,@br_vozacke

	while @@FETCH_STATUS = 0
	begin
		if(not exists
			(	
				select username from Korisnik k where k.username = @username and k.tip is null 
			)
		)
		begin
			rollback transaction
			raiserror('Request has been denied because the user is already a courier or something else',11,1)
		end
		else if(exists(
			select z.username
			from ZahtevZaKurira z
			where z.br_vozacke = @br_vozacke and z.username not in (select username from @table)
		))
		begin
			raiserror('Request with the same license plate has already been submited!',11,1)
			rollback transaction
		end
		delete from @table
		where username = @username
		fetch next from @kursor into
		@username,@br_vozacke

	end

	close @kursor
	deallocate @kursor

END
GO

ALTER TABLE [dbo].[ZahtevZaKurira] ENABLE TRIGGER [provera_unos]
GO


USE [mn170505]
GO

/****** Object:  UserDefinedFunction [dbo].[euklidskaDistanca]    Script Date: 25.6.2022. 23:35:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[euklidskaDistanca] (@pocetak int , @kraj int )  
  RETURNS decimal(10,3) 
  
AS BEGIN
	declare @distance decimal(10,3)
	declare @x1 decimal(10,3)
	declare @y1 decimal(10,3)
	declare @x2 decimal(10,3)
	declare @y2 decimal(10,3)

	select @x1 = x,@y1 = y
	from Adresa a
	where a.IdA = @pocetak
	
	select @x2 = x,@y2 = y
	from Adresa a
	where a.IdA = @kraj

	if(@x1 = NULL or @y1 = NULL or @x2 = NULL or @y2 = NULL)
	begin
		return -1
	end
	
	set @distance = SQRT(SQUARE(cast(@x1 as float) - cast(@x2 as float)) +
						 SQUARE(cast(@y1 as float) - cast(@y2 as float)))

	RETURN @distance

END
GO







