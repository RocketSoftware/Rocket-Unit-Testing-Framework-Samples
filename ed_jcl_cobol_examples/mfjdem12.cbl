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
       PROGRAM-ID.    MFJDEM12.

      ****************************************************************
      ***  PROGRAM: MFJDEM12.CBL
      ***  CONTROL: MFJDEM12.JCL
      ***
      ***  DESC   : WRITES REPORT FILES USING THE VARIOUS OPTIONS
      ***
      ***  INPUTS : PARM DATA
      ***
      ***  OUTPUTS: DISPLAYED MESSAGES
      ***           DISPLAYED PARM DATA
      ***           DISPLAYED COPY OF REPORTS (TO SYSOUT DD)
      ***
      ***           RPTADVA REPORT - WRITE AFTER  ADVANCING
      ***           RPTADVB REPORT - WRITE BEFORE ADVANCING
      ***           RPTLINA REPORT - WRITE AFTER  ADVANCING (LINAGE)
      ***           RPTLINB REPORT - WRITE BEFORE ADVANCING (LINAGE)
      ***           RPTFBM  REPORT - WRITE AFTER  MOVING MACHINE CODE
      ****************************************************************

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.

           C01 IS C-01 C02 IS C-02 C03 IS C-03 C04 IS C-04
           C05 IS C-05 C06 IS C-06 C07 IS C-07 C08 IS C-08
           C09 IS C-09 C10 IS C-10 C11 IS C-11 C12 IS C-12
           S01 IS S-01 S02 IS S-02.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           SELECT RPTADVA-FILE  ASSIGN TO  UT-S-RPTADVA.
           SELECT RPTADVB-FILE  ASSIGN TO  UT-S-RPTADVB.
           SELECT RPTLINA-FILE  ASSIGN TO  UT-S-RPTLINA.
           SELECT RPTLINB-FILE  ASSIGN TO  UT-S-RPTLINB.
           SELECT RPTFBM-FILE   ASSIGN TO  UT-S-RPTFBM.

       DATA DIVISION.
       FILE SECTION.

       FD  RPTADVA-FILE.
       01  RPTADVA-REC                 PIC X(132).

       FD  RPTADVB-FILE.
       01  RPTADVB-REC                 PIC X(132).

       FD  RPTLINA-FILE
           LINAGE 10.
       01  RPTLINA-REC                 PIC X(132).

       FD  RPTLINB-FILE
           LINAGE 10.
       01  RPTLINB-REC                 PIC X(132).

       FD  RPTFBM-FILE.
       01  RPTFBM-REC                  PIC X(133).

       WORKING-STORAGE SECTION.

       01  PROGRAM-FIELDS.
           05  I                       PIC  9(04) COMP.
           05  ADV-FIELDS.
               10  ADV-CC-CNT          PIC  9(04) COMP   VALUE  8.
               10  ADV-CC-TABLE        PIC  X(24) VALUE
                   '"0""1""2""3""4""5""6""7"'.
               10  ADV-CCT       REDEFINES ADV-CC-TABLE  OCCURS 8.
                   15  FILLER          PIC  X(01).
                   15  ADV-CC          PIC  9(01).
                   15  FILLER          PIC  X(01).
           05  FBM-FIELDS.
               10  FBM-CC-CNT          PIC  9(04) COMP   VALUE  6.
               10  FBM-CC-TABLE        PIC  X(06) VALUE
                   X'890109111989'.
               10  FILLER        REDEFINES FBM-CC-TABLE  OCCURS 6.
                   15  FBM-CC          PIC  X(01).
               10  FBM-CC-TEXT         PIC  X(18) VALUE
                   'x89x01x09x11x19x89'.
               10  FILLER        REDEFINES FBM-CC-TEXT   OCCURS 6.
                   15  FBM-CCT         PIC  X(03).

       01  WS-LINE.
           05  WS-LINE-CC              PIC  X(01) VALUE  '_'.
           05  WS-LINE-TXT.
               10  FILLER              PIC  X(04).
               10  WS-LINE-TNUM        PIC  9(02).
               10  FILLER              PIC  X(27).
               10  WS-LINE-TCC         PIC  X(03).
           05  FILLER                  PIC  X(93) VALUE  SPACES.
           05  FILLER                  PIC  X(03) VALUE  '--|'.

       LINKAGE SECTION.

       01  PARM.
           05  PARM-LEN                PIC  9(04) COMP.
           05  PARM-DATA.
               10  PARM-DATA-BYTE      PIC  X(01) OCCURS  0 TO 100
                                                  DEPENDING ON PARM-LEN.

       PROCEDURE DIVISION           USING PARM.

       0000-MAINLINE.

           DISPLAY ' '                                    UPON SYSOUT.
           DISPLAY ' '                                    UPON CONSOLE.
           IF PARM-LEN = 0
               DISPLAY 'MFJDEM12 PARM: (NONE)'            UPON SYSOUT
               DISPLAY 'MFJDEM12 PARM: (NONE)'            UPON CONSOLE
           ELSE
               DISPLAY 'MFJDEM12 PARM: ' PARM-DATA        UPON SYSOUT
               DISPLAY 'MFJDEM12 PARM: ' PARM-DATA        UPON CONSOLE.

           PERFORM 1000-RPTADVA      THRU 1000-EXIT.
           PERFORM 2000-RPTADVB      THRU 2000-EXIT.
           PERFORM 3000-RPTLINA      THRU 3000-EXIT.
           PERFORM 4000-RPTLINB      THRU 4000-EXIT.
           PERFORM 5000-RPTFBM       THRU 5000-EXIT.

           DISPLAY ' '                                    UPON SYSOUT.
           DISPLAY ' '                                    UPON CONSOLE.
           DISPLAY 'MFJDEM12 PROGRAM ENDED'               UPON SYSOUT.
           DISPLAY 'MFJDEM12 PROGRAM ENDED'               UPON CONSOLE.
           DISPLAY ' '                                    UPON SYSOUT.
           DISPLAY ' '                                    UPON CONSOLE.

           GOBACK.

       1000-RPTADVA.

           DISPLAY ' '                                    UPON SYSOUT.
           DISPLAY ' '                                    UPON CONSOLE.
           DISPLAY 'WRITING RPTADVA REPORT'               UPON SYSOUT.
           DISPLAY 'WRITING RPTADVA REPORT'               UPON CONSOLE.

           OPEN OUTPUT RPTADVA-FILE.

           MOVE 'LINE00: WRITE AFTER  ADVANCING   "?"' TO  WS-LINE-TXT.

           ADD 1                       TO WS-LINE-TNUM.
           MOVE 'PAG'                  TO WS-LINE-TCC.
           DISPLAY '        '             WS-LINE-TXT     UPON SYSOUT.
           WRITE RPTADVA-REC FROM WS-LINE AFTER  ADVANCING   PAGE.

           PERFORM 1100-RPTADVA-WRITE THRU 1100-EXIT
               VARYING I FROM 1 BY 1 UNTIL I > ADV-CC-CNT.

           ADD 1                       TO WS-LINE-TNUM.
           MOVE 'PAG'                  TO WS-LINE-TCC.
           DISPLAY '        '             WS-LINE-TXT     UPON SYSOUT.
           WRITE RPTADVA-REC FROM WS-LINE AFTER  ADVANCING   PAGE.

           ADD 1                       TO WS-LINE-TNUM.
           MOVE 'C01'                  TO WS-LINE-TCC.
           DISPLAY '        '             WS-LINE-TXT     UPON SYSOUT.
           WRITE RPTADVA-REC FROM WS-LINE AFTER  ADVANCING   C-01.

           ADD 1                       TO WS-LINE-TNUM.
           MOVE 'C02'                  TO WS-LINE-TCC.
           DISPLAY '        '             WS-LINE-TXT     UPON SYSOUT.
           WRITE RPTADVA-REC FROM WS-LINE AFTER  ADVANCING   C-02.

           ADD 1                       TO WS-LINE-TNUM.
           MOVE 'C03'                  TO WS-LINE-TCC.
           DISPLAY '        '             WS-LINE-TXT     UPON SYSOUT.
           WRITE RPTADVA-REC FROM WS-LINE AFTER  ADVANCING   C-03.

           ADD 1                       TO WS-LINE-TNUM.
           MOVE 'C04'                  TO WS-LINE-TCC.
           DISPLAY '        '             WS-LINE-TXT     UPON SYSOUT.
           WRITE RPTADVA-REC FROM WS-LINE AFTER  ADVANCING   C-04.

           ADD 1                       TO WS-LINE-TNUM.
           MOVE 'C12'                  TO WS-LINE-TCC.
           DISPLAY '        '             WS-LINE-TXT     UPON SYSOUT.
           WRITE RPTADVA-REC FROM WS-LINE AFTER  ADVANCING   C-12.

           ADD 1                       TO WS-LINE-TNUM.
           MOVE 'S01'                  TO WS-LINE-TCC.
           DISPLAY '        '             WS-LINE-TXT     UPON SYSOUT.
           WRITE RPTADVA-REC FROM WS-LINE AFTER  ADVANCING   S-01.

           CLOSE RPTADVA-FILE.

       1000-EXIT.
           EXIT.

       1100-RPTADVA-WRITE.

           ADD 1                       TO WS-LINE-TNUM.
           MOVE ADV-CCT (I)            TO WS-LINE-TCC.
           DISPLAY '        '             WS-LINE-TXT     UPON SYSOUT.
           WRITE RPTADVA-REC FROM WS-LINE AFTER  ADVANCING   ADV-CC (I).

       1100-EXIT.
           EXIT.

       2000-RPTADVB.

           DISPLAY ' '                                    UPON SYSOUT.
           DISPLAY ' '                                    UPON CONSOLE.
           DISPLAY 'WRITING RPTADVB REPORT'               UPON SYSOUT.
           DISPLAY 'WRITING RPTADVB REPORT'               UPON CONSOLE.

           OPEN OUTPUT RPTADVB-FILE.

           MOVE 'LINE00: WRITE BEFORE ADVANCING   "?"' TO  WS-LINE-TXT.

           ADD 1                       TO WS-LINE-TNUM.
           MOVE 'PAG'                  TO WS-LINE-TCC.
           DISPLAY '        '             WS-LINE-TXT     UPON SYSOUT.
           WRITE RPTADVB-REC FROM WS-LINE BEFORE ADVANCING   PAGE.

           PERFORM 2100-RPTADVB-WRITE THRU 2100-EXIT
               VARYING I FROM 1 BY 1 UNTIL I > ADV-CC-CNT.

           ADD 1                       TO WS-LINE-TNUM.
           MOVE 'PAG'                  TO WS-LINE-TCC.
           DISPLAY '        '             WS-LINE-TXT     UPON SYSOUT.
           WRITE RPTADVB-REC FROM WS-LINE BEFORE ADVANCING   PAGE.

           ADD 1                       TO WS-LINE-TNUM.
           MOVE 'C01'                  TO WS-LINE-TCC.
           DISPLAY '        '             WS-LINE-TXT     UPON SYSOUT.
           WRITE RPTADVB-REC FROM WS-LINE BEFORE ADVANCING   C-01.

           ADD 1                       TO WS-LINE-TNUM.
           MOVE 'C02'                  TO WS-LINE-TCC.
           DISPLAY '        '             WS-LINE-TXT     UPON SYSOUT.
           WRITE RPTADVB-REC FROM WS-LINE BEFORE ADVANCING   C-02.

           ADD 1                       TO WS-LINE-TNUM.
           MOVE 'C03'                  TO WS-LINE-TCC.
           DISPLAY '        '             WS-LINE-TXT     UPON SYSOUT.
           WRITE RPTADVB-REC FROM WS-LINE BEFORE ADVANCING   C-03.

           ADD 1                       TO WS-LINE-TNUM.
           MOVE 'C04'                  TO WS-LINE-TCC.
           DISPLAY '        '             WS-LINE-TXT     UPON SYSOUT.
           WRITE RPTADVB-REC FROM WS-LINE BEFORE ADVANCING   C-04.

           ADD 1                       TO WS-LINE-TNUM.
           MOVE 'C12'                  TO WS-LINE-TCC.
           DISPLAY '        '             WS-LINE-TXT     UPON SYSOUT.
           WRITE RPTADVB-REC FROM WS-LINE BEFORE ADVANCING   C-12.

           ADD 1                       TO WS-LINE-TNUM.
           MOVE 'S01'                  TO WS-LINE-TCC.
           DISPLAY '        '             WS-LINE-TXT     UPON SYSOUT.
           WRITE RPTADVB-REC FROM WS-LINE BEFORE ADVANCING   S-01.

           CLOSE RPTADVB-FILE.

       2000-EXIT.
           EXIT.

       2100-RPTADVB-WRITE.

           ADD 1                       TO WS-LINE-TNUM.
           MOVE ADV-CCT (I)            TO WS-LINE-TCC.
           DISPLAY '        '             WS-LINE-TXT     UPON SYSOUT.
           WRITE RPTADVB-REC FROM WS-LINE BEFORE ADVANCING   ADV-CC (I).

       2100-EXIT.
           EXIT.

       3000-RPTLINA.

           DISPLAY ' '                                    UPON SYSOUT.
           DISPLAY ' '                                    UPON CONSOLE.
           DISPLAY 'WRITING RPTLINA REPORT'               UPON SYSOUT.
           DISPLAY 'WRITING RPTLINA REPORT'               UPON CONSOLE.

           OPEN OUTPUT RPTLINA-FILE.

           MOVE 'LINE00: WRITE AFTER  LINEAGE ADV "?"' TO  WS-LINE-TXT.

           ADD 1                       TO WS-LINE-TNUM.
           MOVE 'PAG'                  TO WS-LINE-TCC.
           DISPLAY '        '             WS-LINE-TXT     UPON SYSOUT.
           WRITE RPTLINA-REC FROM WS-LINE AFTER  ADVANCING   PAGE.

           PERFORM 3100-RPTLINA-WRITE THRU 3100-EXIT
               VARYING I FROM 1 BY 1 UNTIL I > ADV-CC-CNT.

           ADD 1                       TO WS-LINE-TNUM.
           MOVE 'PAG'                  TO WS-LINE-TCC.
           DISPLAY '        '             WS-LINE-TXT     UPON SYSOUT.
           WRITE RPTLINA-REC FROM WS-LINE AFTER  ADVANCING   PAGE.

           PERFORM 3200-RPTLINA-WRITE THRU 3200-EXIT 10 TIMES.

           CLOSE RPTLINA-FILE.

       3000-EXIT.
           EXIT.

       3100-RPTLINA-WRITE.

           ADD 1                       TO WS-LINE-TNUM.
           MOVE ADV-CCT (I)            TO WS-LINE-TCC.
           DISPLAY '        '             WS-LINE-TXT     UPON SYSOUT.
           WRITE RPTLINA-REC FROM WS-LINE AFTER  ADVANCING   ADV-CC (I)
              AT EOP DISPLAY '    EOP RPTLINA REPORT'.

       3100-EXIT.
           EXIT.

       3200-RPTLINA-WRITE.

           ADD 1                       TO WS-LINE-TNUM.
           MOVE ' 1 '                  TO WS-LINE-TCC.
           DISPLAY '        '             WS-LINE-TXT     UPON SYSOUT.
           WRITE RPTLINA-REC FROM WS-LINE AFTER  ADVANCING   1
              AT EOP DISPLAY '    EOP RPTLINA REPORT'.

       3200-EXIT.
           EXIT.

       4000-RPTLINB.

           DISPLAY ' '                                    UPON SYSOUT.
           DISPLAY ' '                                    UPON CONSOLE.
           DISPLAY 'WRITING RPTLINB REPORT'               UPON SYSOUT.
           DISPLAY 'WRITING RPTLINB REPORT'               UPON CONSOLE.

           OPEN OUTPUT RPTLINB-FILE.

           MOVE 'LINE00: WRITE BEFORE LINEAGE ADV "?"' TO  WS-LINE-TXT.

           ADD 1                       TO WS-LINE-TNUM.
           MOVE 'PAG'                  TO WS-LINE-TCC.
           DISPLAY '        '             WS-LINE-TXT     UPON SYSOUT.
           WRITE RPTLINB-REC FROM WS-LINE BEFORE ADVANCING   PAGE.

           PERFORM 4100-RPTLINB-WRITE THRU 4100-EXIT
               VARYING I FROM 1 BY 1 UNTIL I > ADV-CC-CNT.

           ADD 1                       TO WS-LINE-TNUM.
           MOVE 'PAG'                  TO WS-LINE-TCC.
           DISPLAY '        '             WS-LINE-TXT     UPON SYSOUT.
           WRITE RPTLINB-REC FROM WS-LINE BEFORE ADVANCING   PAGE.

           PERFORM 4200-RPTLINB-WRITE THRU 4200-EXIT 10 TIMES.

           CLOSE RPTLINB-FILE.

       4000-EXIT.
           EXIT.

       4100-RPTLINB-WRITE.

           ADD 1                       TO WS-LINE-TNUM.
           MOVE ADV-CCT (I)            TO WS-LINE-TCC.
           DISPLAY '        '             WS-LINE-TXT     UPON SYSOUT.
           WRITE RPTLINB-REC FROM WS-LINE BEFORE ADVANCING   ADV-CC (I)
              AT EOP DISPLAY '    EOP RPTLINA REPORT'.

       4100-EXIT.
           EXIT.

       4200-RPTLINB-WRITE.

           ADD 1                       TO WS-LINE-TNUM.
           MOVE ' 1 '                  TO WS-LINE-TCC.
           DISPLAY '        '             WS-LINE-TXT     UPON SYSOUT.
           WRITE RPTLINB-REC FROM WS-LINE BEFORE ADVANCING   1
              AT EOP DISPLAY '    EOP RPTLINA REPORT'.

       4200-EXIT.
           EXIT.

       5000-RPTFBM.

           DISPLAY ' '                                    UPON SYSOUT.
           DISPLAY ' '                                    UPON CONSOLE.
           DISPLAY 'WRITING RPTFBM  REPORT'               UPON SYSOUT.
           DISPLAY 'WRITING RPTFBM  REPORT'               UPON CONSOLE.

           OPEN OUTPUT RPTFBM-FILE.

           MOVE 'LINE00: WRITE AFTER  MOVING FBM  "?"' TO  WS-LINE-TXT.

           PERFORM 5100-RPTFBM-WRITE THRU 5100-EXIT
               VARYING I FROM 1 BY 1 UNTIL I > FBM-CC-CNT.

           CLOSE RPTFBM-FILE.

       5000-EXIT.
           EXIT.

       5100-RPTFBM-WRITE.

           ADD 1                       TO WS-LINE-TNUM.
           MOVE FBM-CCT (I)            TO WS-LINE-TCC.
           DISPLAY '        '             WS-LINE-TXT     UPON SYSOUT.
           MOVE FBM-CC  (I)            TO WS-LINE-CC.
           WRITE RPTFBM-REC  FROM WS-LINE.

       5100-EXIT.
           EXIT.
           