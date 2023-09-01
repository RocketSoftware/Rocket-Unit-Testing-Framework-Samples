      ****************************************************************
      *<CR_S_T_B\>
      *
      * Copyright (C) Open Text 1984 - 2019 or one of its affiliates.
      * The only warranties for products and services of Open Text and
      * its affiliates and licensors ("Open Text") are set forth in 
      * the express warranty statements accompanying such products and
      * services. Nothing herein should be construed as constituting an 
      * additional warranty. Open Text shall not be liable for technical 
      * or editorial errors or omissions contained herein. 
      * The information contained herein is subject to change without notice.
      * Contains Confidential Information. Except as specifically indicated 
      * otherwise, a valid license is required for possession, use or copying.
      * Consistent with FAR 12.211 and 12.212, Commercial Computer Software, 
      * Computer Software Documentation, and Technical Data for Commercial 
      * Items are licensed to the U.S. Government under vendor's standard 
      * commercial license.
      *
      *<CR_S_T_E\>
      ****************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID.    MFJDEMUT.

      ****************************************************************
      ***  PROGRAM: MFJDEMUT
      ***  CONTROL: MFJDEM??.JCL (MULTIPLE)
      ***
      ***  DESC:    READS SYSUT1 AND DISPLAYS THE RECORDS
      ***           COPIES SYSUT1 TO SYSUT2 (CAN BE DUMMIED)
      ***           CREATES AN EMPTY SYSUT2 IF SYSUT1 IS DUMMIED
      ***
      ***  INPUTS : PARM DATA
      ***           SYSUT1 FILE
      ***
      ***  OUTPUTS: DISPLAYED MESSAGES
      ***           DISPLAYED PARM DATA
      ***           DISPLAYED SYSUT1 RECORDS (TO SYSOUT DD)
      ***           SYSUT2 COPY OF SYSUT1 (EMPTY IF SYSUT1 DUMMIED)
      ***
      ***  NOTES:   DATA DOES NOT GET AUTOMATICALLY CONVERTED FOR
      ***           THE PROGRAM EXCEPT FOR 'PARM=' AND 'SYSIN DD *'
      ****************************************************************

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           SELECT SYSUT1-FILE   ASSIGN TO  UT-S-SYSUT1
               ORGANIZATION  IS SEQUENTIAL
               FILE STATUS   IS SYSUT1-STATUS.

           SELECT SYSUT2-FILE   ASSIGN TO  UT-S-SYSUT2
               ORGANIZATION  IS SEQUENTIAL
               FILE STATUS   IS SYSUT2-STATUS.

       DATA DIVISION.
       FILE SECTION.

       FD  SYSUT1-FILE.
       01  SYSUT1-BUFFER               PIC  X(80).

       FD  SYSUT2-FILE.
       01  SYSUT2-BUFFER               PIC  X(80).

       WORKING-STORAGE SECTION.

       01  PROGRAM-FIELDS.
           05  WS-RCODE                PIC  9(04) COMP.
           05  SYSUT1-STATUS           PIC  X(02).
           05  SYSUT1-OPEN-SW          PIC  X(01).
           05  SYSUT1-CNT              PIC S9(05) COMP-3.
           05  SYSUT2-STATUS           PIC  X(02).
           05  SYSUT2-OPEN-SW          PIC  X(01).
           05  SYSUT2-CNT              PIC S9(05) COMP-3.
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
           MOVE 0                      TO SYSUT1-CNT.
           MOVE 0                      TO SYSUT2-CNT.

           DISPLAY ' '                                    UPON SYSOUT.
           DISPLAY ' '                                    UPON CONSOLE.
           IF PARM-LEN = 0
               DISPLAY 'MFJDEMUT PARM: (NONE)'            UPON SYSOUT
               DISPLAY 'MFJDEMUT PARM: (NONE)'            UPON CONSOLE
           ELSE
               DISPLAY 'MFJDEMUT PARM: ' PARM-DATA        UPON SYSOUT
               DISPLAY 'MFJDEMUT PARM: ' PARM-DATA        UPON CONSOLE.

           PERFORM 9100-OPEN-FILES   THRU 9100-EXIT.

           IF SYSUT1-OPEN-SW = 'Y'
           AND SYSUT2-OPEN-SW = 'Y'
               DISPLAY ' '                                UPON SYSOUT
               DISPLAY 'SYSUT1 FILE LISTING:'             UPON SYSOUT
               DISPLAY '--------------------'             UPON SYSOUT
               PERFORM 1000-PROCESS-FILES THRU 1000-EXIT
                 UNTIL SYSUT1-STATUS NOT = '00'
                   OR  SYSUT2-STATUS NOT = '00'.

           PERFORM 9110-CLOSE-FILES  THRU 9110-EXIT.

           DISPLAY ' '                                    UPON SYSOUT.
           DISPLAY ' '                                    UPON CONSOLE.
           MOVE SYSUT1-CNT             TO DISPLAY-CNT.
           DISPLAY 'SYSUT1 RECORDS INPUT =  ' DISPLAY-CNT UPON SYSOUT.
           DISPLAY 'SYSUT1 RECORDS INPUT =  ' DISPLAY-CNT UPON CONSOLE.
           MOVE SYSUT2-CNT             TO DISPLAY-CNT.
           DISPLAY 'SYSUT2 RECORDS OUTPUT = ' DISPLAY-CNT UPON SYSOUT.
           DISPLAY 'SYSUT2 RECORDS OUTPUT = ' DISPLAY-CNT UPON CONSOLE.

           DISPLAY ' '                                    UPON SYSOUT.
           DISPLAY ' '                                    UPON CONSOLE.
           DISPLAY 'MFJDEMUT PROGRAM ENDED'               UPON SYSOUT.
           DISPLAY 'MFJDEMUT PROGRAM ENDED'               UPON CONSOLE.
           DISPLAY ' '                                    UPON SYSOUT.
           DISPLAY ' '                                    UPON CONSOLE.

           MOVE WS-RCODE               TO RETURN-CODE.
           GOBACK.

       1000-PROCESS-FILES.

           READ SYSUT1-FILE          INTO WORK-BUFFER.

           IF SYSUT1-STATUS = '00'
               ADD 1                   TO SYSUT1-CNT
               DISPLAY WORK-BUFFER                        UPON SYSOUT
           ELSE
               IF SYSUT1-STATUS = '10'
                   GO TO 1000-EXIT
               ELSE
                   MOVE 'SYSUT1'       TO FILEERR-DDNAME
                   MOVE 'READ '        TO FILEERR-ACTION
                   MOVE SYSUT1-STATUS  TO FILEERR-STATUS
                   PERFORM 9900-FILE-ERR  THRU 9900-EXIT
                   GO TO 1000-EXIT.

           WRITE SYSUT2-BUFFER       FROM WORK-BUFFER

           IF SYSUT2-STATUS = '00'
               ADD 1                   TO SYSUT2-CNT
           ELSE
               MOVE 'SYSUT2'           TO FILEERR-DDNAME
               MOVE 'WRITE'            TO FILEERR-ACTION
               MOVE SYSUT2-STATUS      TO FILEERR-STATUS
               PERFORM 9900-FILE-ERR THRU 9900-EXIT.

       1000-EXIT.
           EXIT.

       9100-OPEN-FILES.

           OPEN INPUT SYSUT1-FILE.

           IF SYSUT1-STATUS = '00'
               MOVE 'Y'                TO SYSUT1-OPEN-SW
           ELSE
               MOVE 'SYSUT1'           TO FILEERR-DDNAME
               MOVE 'OPEN '            TO FILEERR-ACTION
               MOVE SYSUT1-STATUS      TO FILEERR-STATUS
               PERFORM 9900-FILE-ERR THRU 9900-EXIT
               GO TO 9100-EXIT.

           OPEN OUTPUT SYSUT2-FILE.

           IF SYSUT2-STATUS = '00'
               MOVE 'Y'                TO SYSUT2-OPEN-SW
           ELSE
               MOVE 'SYSUT2'           TO FILEERR-DDNAME
               MOVE 'OPEN '            TO FILEERR-ACTION
               MOVE SYSUT2-STATUS      TO FILEERR-STATUS
               PERFORM 9900-FILE-ERR THRU 9900-EXIT.

       9100-EXIT.
           EXIT.

       9110-CLOSE-FILES.

           IF SYSUT1-OPEN-SW = 'Y'
               CLOSE SYSUT1-FILE
               IF SYSUT1-STATUS = '00'
                   MOVE 'N'            TO SYSUT1-OPEN-SW
               ELSE
                   MOVE 'SYSUT1'       TO FILEERR-DDNAME
                   MOVE 'CLOSE'        TO FILEERR-ACTION
                   MOVE SYSUT1-STATUS  TO FILEERR-STATUS
                   PERFORM 9900-FILE-ERR  THRU 9900-EXIT.

           IF SYSUT2-OPEN-SW = 'Y'
               CLOSE SYSUT2-FILE
               IF SYSUT2-STATUS = '00'
                   MOVE 'N'            TO SYSUT2-OPEN-SW
               ELSE
                   MOVE 'SYSUT2'       TO FILEERR-DDNAME
                   MOVE 'CLOSE'        TO FILEERR-ACTION
                   MOVE SYSUT2-STATUS  TO FILEERR-STATUS
                   PERFORM 9900-FILE-ERR  THRU 9900-EXIT.

       9110-EXIT.
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
