
       ENTRY "MFUT_BBANK70P_AMOUNT".
           SET ADDRESS OF DFHCOMMAREA TO address of TEST-DFHCOMMAEA
           MOVE "MBANK70"TO BANK-LAST-MAPSET

           *> convert the pic x fields to 9 fields using a right
           *> justified pic x field and then replacing leading zeros
           MOVE "123456"       TO TEST-BANK-SCR70-AMOUNT-R
           INSPECT TEST-BANK-SCR70-AMOUNT-R 
               REPLACING LEADING " " BY "0"

           MOVE "10.00"        TO TEST-BANK-SCR70-RATE-R
           INSPECT TEST-BANK-SCR70-RATE-R 
               REPLACING LEADING " " BY "0"

           MOVE "60"           TO TEST-BANK-SCR70-TERM-R 
           INSPECT TEST-BANK-SCR70-TERM-R 
               REPLACING LEADING " " BY "0"

           *> move the formatted pic x fields to map fields
           MOVE TEST-BANK-SCR70-AMOUNT-R TO BANK-SCR70-AMOUNT
           MOVE TEST-BANK-SCR70-RATE-R TO BANK-SCR70-RATE
           MOVE TEST-BANK-SCR70-TERM-R TO BANK-SCR70-TERM
           
           *> copy the bank area to commarea, as the first thing the
           *> BBANK70P does is to move it back
           MOVE WS-BANK-DATA TO DFHCOMMAREA(1:LENGTH OF WS-BANK-DATA)
           
           CALL "BBANK70P"

           *> we are back from the program, did we have any errrors?
           IF BANK-ERROR-MSG NOT EQUAL SPACES 
               DISPLAY "FAIL : " BANK-ERROR-MSG
               GOBACK RETURNING 1
           END-IF

           *> is it what we expected it to be?
           IF FUNCTION trim(WS-CALC-WORK-PAYMENT)  NOT EQUAL "$2623.07"
               DISPLAY "FAIL : Payment is " WS-CALC-WORK-PAYMENT
               GOBACK RETURNING 1
           END-IF

           DISPLAY "PASS"
           *> finished with no errors!
           GOBACK.
