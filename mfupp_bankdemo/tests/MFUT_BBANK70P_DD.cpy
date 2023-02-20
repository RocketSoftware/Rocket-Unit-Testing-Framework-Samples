       ENTRY "MFUT_BBANK70P_DD".                                          
           SET ADDRESS OF DFHCOMMAREA TO address of TEST-DFHCOMMAEA
           MOVE "MBANK70"TO BANK-LAST-MAPSET

           *> convert the pic x fields to 9 fields using a right
           *> justified pic x field and then replacing leading zeros
           MOVE mfu-dd-AMOUNT(1:LENGTH OF TEST-BANK-SCR70-AMOUNT-R)
                 TO TEST-BANK-SCR70-AMOUNT-R
           INSPECT TEST-BANK-SCR70-AMOUNT-R 
               REPLACING LEADING " " BY "0"

           MOVE mfu-dd-RATE(1:LENGTH OF TEST-BANK-SCR70-RATE-R)         
               TO TEST-BANK-SCR70-RATE-R
           INSPECT TEST-BANK-SCR70-RATE-R 
               REPLACING LEADING " " BY "0"

           MOVE mfu-dd-TERM(1:LENGTH OF TEST-BANK-SCR70-TERM-R)          
               TO TEST-BANK-SCR70-TERM-R 
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

           IF mfu-dd-EXPECTED_RESULT(1:1) EQUAL "$"
               *> we are back from the program, did we have any errrors?
               IF BANK-ERROR-MSG NOT EQUAL SPACES 
                   DISPLAY "FAIL : " BANK-ERROR-MSG
                   GOBACK RETURNING 1
               END-IF

               *> is it what we expected it to be?
               IF FUNCTION trim(WS-CALC-WORK-PAYMENT)
                  NOT EQUAL mfu-dd-EXPECTED_RESULT
                   DISPLAY "FAIL : Payment is " WS-CALC-WORK-PAYMENT
                   PERFORM display-dd-info
                   GOBACK RETURNING 2
               END-IF
           ELSE 
               IF mfu-dd-EXPECTED_RESULT NOT EQUAL BANK-ERROR-MSG
                   DISPLAY "FAIL : Expected Error: " 
                               mfu-dd-EXPECTED_RESULT
                   DISPLAY " GOT : " BANK-ERROR-MSG
                   GOBACK RETURNING 3
               END-IF
           END-IF
           DISPLAY "PASS - " mfu-dd-EXPECTED_RESULT
           GOBACK RETURNING MFU-PASS-RETURN-CODE.
 
       display-dd-info SECTION.
           DISPLAY MFU-DD-DIAG-MSG(1:MFU-DD-DIAG-MSG-LENGTH)
           DISPLAY ' AMOUNT = ' mfu-dd-AMOUNT                 
           DISPLAY ' RATE   = ' mfu-dd-RATE                   
           DISPLAY ' TERM   = ' mfu-dd-TERM     
           IF mfu-dd-EXPECTED_RESULT(1:1) equal "$"              
               DISPLAY ' EXPECTED_RESULT (VALUE) = ' 
                   mfu-dd-EXPECTED_RESULT
           ELSE
               DISPLAY ' EXPECTED_RESULT (ERROR MSG) = ' 
                   mfu-dd-EXPECTED_RESULT
           END-IF                   
           .

       meta-data SECTION.
       ENTRY "MFUM_BBANK70P_DD"
           MOVE "csv:$MFU_DS/BBANK70P_DD.csv" TO MFU-MD-TESTDATA
           GOBACK.
