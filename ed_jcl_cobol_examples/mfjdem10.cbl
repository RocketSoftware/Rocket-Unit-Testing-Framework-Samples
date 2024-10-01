      *****************************************************************
      *                                                               *
      * Copyright 2010-2024 Rocket Software, Inc. or its affiliates.  *
      * All Rights Reserved.                                          *
      *                                                               *
      * This software may be used, modified, and distributed          *
      * (provided this notice is included without modification)       *
      * solely for internal demonstration purposes with other         *
      * Rocket® products, and is otherwise subject to the EULA at     *
      * https://www.rocketsoftware.com/company/trust/agreements.      *
      *                                                               *
      * THIS SOFTWARE IS PROVIDED "AS IS" AND ALL IMPLIED WARRANTIES, *
      * INCLUDING THE IMPLIED WARRANTIES OF MERCHANTABILITY AND       *
      * FITNESS FOR A PARTICULAR PURPOSE, SHALL NOT APPLY.            *
      *                                                               *
      * TO THE EXTENT PERMITTED BY LAW, IN NO EVENT WILL              *
      * ROCKET SOFTWARE HAVE ANY LIABILITY WHATSOEVER IN CONNECTION   *
      * WITH THIS SOFTWARE.                                           *
      *                                                               *
      *****************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID.    MFJDEM10.

      ****************************************************************
      ***  PROGRAM: MFJDEM10
      ***  CONTROL: MFJDEM10.JCL
      ***
      ***  DESC:    READS A VSAM KSDS AND DISPLAYS THE RECORDS
      ***           A PARM OF 'ALT1' OR' ALT2' CAN BE SPECIFIED
      ***           TO INDICATE THAT INPUT RECORDS ARE TO BE READ
      ***           USING AN ALTERNATE KEY PROCESSING SEQUENCE
      ***
      ***  INPUTS:  PARM DATA
      ***           VSAM KSDS
      ***
      ***  OUTPUTS: DISPLAYED MESSAGES
      ***           DISPLAYED PARM DATA
      ***           DISPLAYED VSAM KSDS RECORDS (TO SYSOUT DD)
      ***
      ***  NOTES:   DATA DOES NOT GET AUTOMATICALLY CONVERTED FOR
      ***           THE PROGRAM EXCEPT FOR 'PARM=' AND 'SYSIN DD *'
      ****************************************************************

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           SELECT KSDS-FILE     ASSIGN TO  KSDSFILE
               ORGANIZATION  IS INDEXED
               ACCESS        IS SEQUENTIAL
               RECORD KEY    IS KSDS-KEY
               ALTERNATE KEY IS KSDS-ALTKEY1
               ALTERNATE KEY IS KSDS-ALTKEY2 WITH DUPLICATES
               FILE STATUS   IS KSDS-STATUS.

       DATA DIVISION.
       FILE SECTION.

       FD  KSDS-FILE.
       01  KSDS-RECORD.
           05  KSDS-KEY                PIC  X(20).
           05  KSDS-DATA.
               10  KSDS-ALTKEY1        PIC  X(10).
               10  KSDS-ALTKEY2        PIC  X(10).
               10  FILLER              PIC  X(40).

       WORKING-STORAGE SECTION.

       01  PROGRAM-FIELDS.
           05  WS-RCODE                PIC  9(04) COMP.
           05  KSDS-STATUS             PIC  X(02).
           05  KSDS-OPEN-SW            PIC  X(01).
           05  KSDS-CNT                PIC S9(05) COMP-3.
           05  DISPLAY-CNT             PIC ZZ,ZZ9.
           05  FILEERR-MESSAGE         PIC  X(40).
           05  FILEERR-DDNAME          PIC  X(08).
           05  FILEERR-ACTION          PIC  X(08).
           05  FILEERR-STATUS.
               10  FILEERR-STATUS1     PIC  X(01).
               10  FILEERR-STATUS2     PIC  X(01).
               10  FILEERR-STATUSX2N   PIC  9(03).
           05  XSTATUS.
               10  FILLER              PIC  X(01) VALUE  LOW-VALUES.
               10  XSTATUS-2           PIC  X(01).
           05  FILLER        REDEFINES XSTATUS.
               10  XSTATUS-2N          PIC  9(04) COMP.

       01  WORK-BUFFER                 PIC  X(80).

       LINKAGE SECTION.

       01  PARM.
           05  PARM-LEN                PIC  9(04) COMP.
           05  PARM-DATA.
               10  PARM-DATA-BYTE      PIC  X(01) OCCURS  0 TO 100
                                                  DEPENDING ON PARM-LEN.

       PROCEDURE DIVISION           USING PARM.

       0000-MAINLINE.

           MOVE 0                      TO WS-RCODE.
           MOVE 0                      TO KSDS-CNT.

           DISPLAY ' '                                    UPON SYSOUT.
           DISPLAY ' '                                    UPON CONSOLE.
           IF PARM-LEN = 0
               DISPLAY 'MFJDEM10 PARM: (NONE)'            UPON SYSOUT
               DISPLAY 'MFJDEM10 PARM: (NONE)'            UPON CONSOLE
           ELSE
               DISPLAY 'MFJDEM10 PARM: ' PARM-DATA        UPON SYSOUT
               DISPLAY 'MFJDEM10 PARM: ' PARM-DATA        UPON CONSOLE.

           PERFORM 9100-OPEN-FILES   THRU 9100-EXIT.

           IF KSDS-OPEN-SW = 'Y'
               DISPLAY ' '                                UPON SYSOUT
               DISPLAY 'KSDSFILE LISTING:'                UPON SYSOUT
               DISPLAY '-----------------'                UPON SYSOUT
               PERFORM 1000-PROCESS-FILES THRU 1000-EXIT
                 UNTIL KSDS-STATUS NOT = '00'.

           PERFORM 9110-CLOSE-FILES  THRU 9200-EXIT.

           DISPLAY ' '                                    UPON SYSOUT.
           DISPLAY ' '                                    UPON CONSOLE.
           MOVE KSDS-CNT               TO DISPLAY-CNT.
           DISPLAY 'KSDSFILE RECORDS READ = ' DISPLAY-CNT UPON SYSOUT.
           DISPLAY 'KSDSFILE RECORDS READ = ' DISPLAY-CNT UPON CONSOLE.

           DISPLAY ' '                                    UPON SYSOUT.
           DISPLAY ' '                                    UPON CONSOLE.
           DISPLAY 'MFJDEM10 PROGRAM ENDED'               UPON SYSOUT.
           DISPLAY 'MFJDEM10 PROGRAM ENDED'               UPON CONSOLE.
           DISPLAY ' '                                    UPON SYSOUT.
           DISPLAY ' '                                    UPON CONSOLE.

           MOVE WS-RCODE               TO RETURN-CODE.
           GOBACK.

       1000-PROCESS-FILES.

           READ KSDS-FILE            INTO WORK-BUFFER.

           IF KSDS-STATUS = ('00' OR '02')
               MOVE '00'               TO KSDS-STATUS
               ADD 1                   TO KSDS-CNT
               DISPLAY WORK-BUFFER                        UPON SYSOUT
           ELSE
               IF KSDS-STATUS = '10'
                   GO TO 1000-EXIT
               ELSE
                   MOVE 'KSDSFILE'     TO FILEERR-DDNAME
                   MOVE 'READ '        TO FILEERR-ACTION
                   MOVE KSDS-STATUS    TO FILEERR-STATUS
                   PERFORM 9900-FILE-ERR  THRU 9900-EXIT.

       1000-EXIT.
           EXIT.

       9100-OPEN-FILES.

           OPEN INPUT KSDS-FILE.

           IF KSDS-STATUS = '00'
               MOVE 'Y'                TO KSDS-OPEN-SW
           ELSE
               MOVE 'KSDSFILE'         TO FILEERR-DDNAME
               MOVE 'OPEN '            TO FILEERR-ACTION
               MOVE KSDS-STATUS        TO FILEERR-STATUS
               PERFORM 9900-FILE-ERR THRU 9900-EXIT
               GO TO 9100-EXIT.

           IF PARM-LEN = 0
           OR PARM-DATA NOT = ('ALT1' AND 'ALT2')
               GO TO 9100-EXIT.

           MOVE LOW-VALUES             TO KSDS-RECORD.

           IF PARM-DATA = 'ALT1'
               START KSDS-FILE KEY GREATER KSDS-ALTKEY1
           ELSE
               START KSDS-FILE KEY GREATER KSDS-ALTKEY2.

           IF KSDS-STATUS NOT = '00'
               MOVE 'KSDSFILE'         TO FILEERR-DDNAME
               MOVE 'START'            TO FILEERR-ACTION
               MOVE KSDS-STATUS        TO FILEERR-STATUS
               PERFORM 9900-FILE-ERR THRU 9900-EXIT.

       9100-EXIT.
           EXIT.

       9110-CLOSE-FILES.

           IF KSDS-OPEN-SW = 'Y'
               CLOSE KSDS-FILE
               IF KSDS-STATUS = '00'
                   MOVE 'N'            TO KSDS-OPEN-SW
               ELSE
                   MOVE 'KSDSFILE'     TO FILEERR-DDNAME
                   MOVE 'CLOSE'        TO FILEERR-ACTION
                   MOVE KSDS-STATUS    TO FILEERR-STATUS
                   PERFORM 9900-FILE-ERR  THRU 9900-EXIT.

       9200-EXIT.
           EXIT.

       9900-FILE-ERR.

           MOVE 16                     TO WS-RCODE.

           IF FILEERR-STATUS1 = '9'
               MOVE FILEERR-STATUS2    TO XSTATUS-2
               MOVE '9/'               TO FILEERR-STATUS
               MOVE XSTATUS-2N         TO FILEERR-STATUSX2N.

           MOVE SPACES                 TO FILEERR-MESSAGE.
           STRING FILEERR-DDNAME          DELIMITED BY ' '
                  ' '                     DELIMITED BY SIZE
                  FILEERR-ACTION          DELIMITED BY ' '
                  ' ERROR, FILE STATUS = ' DELIMITED BY SIZE
                  FILEERR-STATUS          DELIMITED BY ' '
             INTO FILEERR-MESSAGE.

           DISPLAY ' '                                    UPON SYSOUT.
           DISPLAY ' '                                    UPON CONSOLE.
           DISPLAY FILEERR-MESSAGE                        UPON SYSOUT.
           DISPLAY FILEERR-MESSAGE                        UPON CONSOLE.

       9900-EXIT.
           EXIT.
           