
       ENTRY "MFUT_BBANK70P_NO_AMOUNT".
           SET ADDRESS OF DFHCOMMAREA TO address of TEST-DFHCOMMAEA
           MOVE "MBANK70" TO BANK-LAST-MAPSET
.
           MOVE SPACES TO WS-CALC-WORK-AMOUNT
           MOVE spaces to TEST-BANK-SCR70-AMOUNT-R
           MOVE spaces to TEST-BANK-SCR70-RATE-R
           MOVE spaces to TEST-BANK-SCR70-TERM-R

           MOVE WS-BANK-DATA TO DFHCOMMAREA(1:LENGTH OF WS-BANK-DATA)

           CALL "BBANK70P"
           
           IF BANK-ERROR-MSG EQUAL SPACES 
               DISPLAY "FAIL : BANK-ERROR-MSG should contain a error"
               GOBACK RETURNING 1
           END-IF
           DISPLAY "PASS"
           GOBACK.
