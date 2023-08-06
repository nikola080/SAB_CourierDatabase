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







