       IDENTIFICATION DIVISION.
       PROGRAM-ID. CICSHello.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-MESSAGE-O        PIC X(80) VALUE SPACES.
       01 WS-MESSAGE-R        PIC X(80) VALUE SPACES.
       01 WS-MESSAGE-T        PIC X(80) VALUE SPACES.
       LINKAGE SECTION.
       PROCEDURE DIVISION.
          MOVE 'ENTER MESSAGE TO BE REVERSED' TO WS-MESSAGE-O
      ********************************************************
      * SENDING DATA FROM PROGRAM TO SCREEN                  *
      ********************************************************
          EXEC CICS SEND TEXT
             FROM (WS-MESSAGE-O)
             FREEKB
             ERASE
             WAIT
          END-EXEC
      ********************************************************
      * GETTING INPUT FROM USER                              *
      ********************************************************
          EXEC CICS SEND CONTROL CURSOR(81) END-EXEC
          EXEC CICS RECEIVE
             INTO(WS-MESSAGE-R)
          END-EXEC

          MOVE FUNCTION REVERSE(WS-MESSAGE-R(4:76)) To WS-MESSAGE-T
          EXEC CICS SEND TEXT
             ERASE
             FROM (WS-MESSAGE-T)
          END-EXEC
      ********************************************************
      * COMMAND TO TERMINATE THE TRANSACTION                 *
      ********************************************************
          EXEC CICS RETURN
          END-EXEC.
