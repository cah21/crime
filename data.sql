/*==============================================================*/
/* DBMS name:      ORACLE Version 10g                           */
/* Created on:     02/03/2017 09:27:33                          */
/*==============================================================*/



-- Type package declaration
create or replace package PDTypes  
as
    TYPE ref_cursor IS REF CURSOR;
end;

-- Integrity package declaration
create or replace package IntegrityPackage AS
 procedure InitNestLevel;
 function GetNestLevel return number;
 procedure NextNestLevel;
 procedure PreviousNestLevel;
 end IntegrityPackage;
/

-- Integrity package definition
create or replace package body IntegrityPackage AS
 NestLevel number;

-- Procedure to initialize the trigger nest level
 procedure InitNestLevel is
 begin
 NestLevel := 0;
 end;


-- Function to return the trigger nest level
 function GetNestLevel return number is
 begin
 if NestLevel is null then
     NestLevel := 0;
 end if;
 return(NestLevel);
 end;

-- Procedure to increase the trigger nest level
 procedure NextNestLevel is
 begin
 if NestLevel is null then
     NestLevel := 0;
 end if;
 NestLevel := NestLevel + 1;
 end;

-- Procedure to decrease the trigger nest level
 procedure PreviousNestLevel is
 begin
 NestLevel := NestLevel - 1;
 end;

 end IntegrityPackage;
/


drop trigger TIB_CELLULE
/

drop trigger TIB_CRIME
/

drop trigger TIB_DETENU
/

drop trigger TIB_ETABLISSEMENT
/

drop trigger TIB_SECTION
/

drop trigger TIB_TRIBUNAL
/

alter table CELLULE
   drop constraint FK_CELLULE_APPARTIEN_SECTION
/

alter table DETENU
   drop constraint FK_DETENU_DANS_CELLULE
/

alter table JUGER
   drop constraint FK_JUGER_JUGER_TRIBUNAL
/

alter table JUGER
   drop constraint FK_JUGER_JUGER2_CRIME
/

alter table PEINE
   drop constraint FK_PEINE_PEINE_DETENU
/

alter table PEINE
   drop constraint FK_PEINE_PEINE2_TRIBUNAL
/

alter table SECTION
   drop constraint FK_SECTION_APPARTIEN_ETABLISS
/

drop index APPARTIENTCELLULE_FK
/

drop table CELLULE cascade constraints
/

drop table CRIME cascade constraints
/

drop index DANS_FK
/

drop table DETENU cascade constraints
/

drop table ETABLISSEMENT cascade constraints
/

drop index JUGER2_FK
/

drop index JUGER_FK
/

drop table JUGER cascade constraints
/

drop index PEINE2_FK
/

drop index PEINE_FK
/

drop table PEINE cascade constraints
/

drop index APPARTIENT_FK
/

drop table SECTION cascade constraints
/

drop table TRIBUNAL cascade constraints
/

drop sequence S_CELLULE
/

drop sequence S_CRIME
/

drop sequence S_DETENU
/

drop sequence S_ETABLISSEMENT
/

drop sequence S_SECTION
/

drop sequence S_TRIBUNAL
/

create sequence S_CELLULE
/

create sequence S_CRIME
/

create sequence S_DETENU
/

create sequence S_ETABLISSEMENT
/

create sequence S_SECTION
/

create sequence S_TRIBUNAL
/

/*==============================================================*/
/* Table: CELLULE                                               */
/*==============================================================*/
create table CELLULE  (
   IDCELLULE            NUMBER(6)                       not null,
   IDSECTION            NUMBER(6)                       not null,
   NUMEROCELLULE        VARCHAR2(60),
   CAPACITEMAX          INTEGER,
   constraint PK_CELLULE primary key (IDCELLULE)
)
/

/*==============================================================*/
/* Index: APPARTIENTCELLULE_FK                                  */
/*==============================================================*/
create index APPARTIENTCELLULE_FK on CELLULE (
   IDSECTION ASC
)
/

/*==============================================================*/
/* Table: CRIME                                                 */
/*==============================================================*/
create table CRIME  (
   IDCRIME              NUMBER(6)                       not null,
   CATEGORIE            INTEGER,
   INTITULE             VARCHAR2(60),
   "DATE"               DATE,
   constraint PK_CRIME primary key (IDCRIME)
)
/

/*==============================================================*/
/* Table: DETENU                                                */
/*==============================================================*/
create table DETENU  (
   ID                   NUMBER(6)                       not null,
   IDCELLULE            NUMBER(6)                       not null,
   NOMTRIBUNAL          VARCHAR2(60),
   PRENOM               VARCHAR2(60),
   DATENAISSANCE        DATE,
   CIN                  NUMBER,
   ADRESSE              VARCHAR2(60),
   constraint PK_DETENU primary key (ID)
)
/

/*==============================================================*/
/* Index: DANS_FK                                               */
/*==============================================================*/
create index DANS_FK on DETENU (
   IDCELLULE ASC
)
/

/*==============================================================*/
/* Table: ETABLISSEMENT                                         */
/*==============================================================*/
create table ETABLISSEMENT  (
   IDETABLISSEMENT      NUMBER(6)                       not null,
   NOMETABLISSEMENT     VARCHAR2(60),
   DATECREATION         DATE,
   VILLE                VARCHAR2(60),
   ADRESSE              VARCHAR2(60),
   TEL                  NUMBER,
   constraint PK_ETABLISSEMENT primary key (IDETABLISSEMENT)
)
/

/*==============================================================*/
/* Table: JUGER                                                 */
/*==============================================================*/
create table JUGER  (
   IDTRIBUNAL           NUMBER(6)                       not null,
   IDCRIME              NUMBER(6)                       not null,
   DATE_JUGEMENT        DATE,
   constraint PK_JUGER primary key (IDTRIBUNAL, IDCRIME)
)
/

/*==============================================================*/
/* Index: JUGER_FK                                              */
/*==============================================================*/
create index JUGER_FK on JUGER (
   IDTRIBUNAL ASC
)
/

/*==============================================================*/
/* Index: JUGER2_FK                                             */
/*==============================================================*/
create index JUGER2_FK on JUGER (
   IDCRIME ASC
)
/

/*==============================================================*/
/* Table: PEINE                                                 */
/*==============================================================*/
create table PEINE  (
   ID                   NUMBER(6)                       not null,
   IDTRIBUNAL           NUMBER(6)                       not null,
   DATE_SENTENCE        DATE,
   DUREEPEINE           INTEGER,
   constraint PK_PEINE primary key (ID, IDTRIBUNAL)
)
/

/*==============================================================*/
/* Index: PEINE_FK                                              */
/*==============================================================*/
create index PEINE_FK on PEINE (
   ID ASC
)
/

/*==============================================================*/
/* Index: PEINE2_FK                                             */
/*==============================================================*/
create index PEINE2_FK on PEINE (
   IDTRIBUNAL ASC
)
/

/*==============================================================*/
/* Table: SECTION                                               */
/*==============================================================*/
create table SECTION  (
   IDSECTION            NUMBER(6)                       not null,
   IDETABLISSEMENT      NUMBER(6)                       not null,
   NOMSECTION           VARCHAR2(60),
   constraint PK_SECTION primary key (IDSECTION)
)
/

/*==============================================================*/
/* Index: APPARTIENT_FK                                         */
/*==============================================================*/
create index APPARTIENT_FK on SECTION (
   IDETABLISSEMENT ASC
)
/

/*==============================================================*/
/* Table: TRIBUNAL                                              */
/*==============================================================*/
create table TRIBUNAL  (
   IDTRIBUNAL           NUMBER(6)                       not null,
   NOMTRIBUNAL          VARCHAR2(60),
   VILLE                VARCHAR2(60),
   ADRESSE              VARCHAR2(60),
   constraint PK_TRIBUNAL primary key (IDTRIBUNAL)
)
/

alter table CELLULE
   add constraint FK_CELLULE_APPARTIEN_SECTION foreign key (IDSECTION)
      references SECTION (IDSECTION)
/

alter table DETENU
   add constraint FK_DETENU_DANS_CELLULE foreign key (IDCELLULE)
      references CELLULE (IDCELLULE)
/

alter table JUGER
   add constraint FK_JUGER_JUGER_TRIBUNAL foreign key (IDTRIBUNAL)
      references TRIBUNAL (IDTRIBUNAL)
/

alter table JUGER
   add constraint FK_JUGER_JUGER2_CRIME foreign key (IDCRIME)
      references CRIME (IDCRIME)
/

alter table PEINE
   add constraint FK_PEINE_PEINE_DETENU foreign key (ID)
      references DETENU (ID)
/

alter table PEINE
   add constraint FK_PEINE_PEINE2_TRIBUNAL foreign key (IDTRIBUNAL)
      references TRIBUNAL (IDTRIBUNAL)
/

alter table SECTION
   add constraint FK_SECTION_APPARTIEN_ETABLISS foreign key (IDETABLISSEMENT)
      references ETABLISSEMENT (IDETABLISSEMENT)
/


create trigger TIB_CELLULE before insert
on CELLULE for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "IDCELLULE" uses sequence S_CELLULE
    select S_CELLULE.NEXTVAL INTO :new.IDCELLULE from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_CRIME before insert
on CRIME for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "IDCRIME" uses sequence S_CRIME
    select S_CRIME.NEXTVAL INTO :new.IDCRIME from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_DETENU before insert
on DETENU for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "ID" uses sequence S_DETENU
    select S_DETENU.NEXTVAL INTO :new.ID from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_ETABLISSEMENT before insert
on ETABLISSEMENT for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "IDETABLISSEMENT" uses sequence S_ETABLISSEMENT
    select S_ETABLISSEMENT.NEXTVAL INTO :new.IDETABLISSEMENT from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_SECTION before insert
on SECTION for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "IDSECTION" uses sequence S_SECTION
    select S_SECTION.NEXTVAL INTO :new.IDSECTION from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_TRIBUNAL before insert
on TRIBUNAL for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "IDTRIBUNAL" uses sequence S_TRIBUNAL
    select S_TRIBUNAL.NEXTVAL INTO :new.IDTRIBUNAL from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/

