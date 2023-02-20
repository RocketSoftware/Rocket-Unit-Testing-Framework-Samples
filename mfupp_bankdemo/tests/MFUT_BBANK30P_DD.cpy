       ENTRY "MFUT_BBANK30P".     

           *> convert pic x to 9
           MOVE FUNCTION numval-c(mfu-dd-WS-SRV-AMT) 
                TO TEST-WS-SRV-AMT-9

           MOVE TEST-WS-SRV-AMT-9-X TO WS-SRV-BAL

           *> perform the service calculation
           PERFORM CALC-SERVICE-CHARGE THRU
                   CALC-SERVICE-CHARGE-EXIT

           *> use a friendly display field
           MOVE WS-SRV-AMT TO TEST-WS-SRV-AMT-9
           MOVE TEST-WS-SRV-AMT-9 TO TEST-WS-SRV-AMT-D
           MOVE FUNCTION numval-c(mfu-dd-EXP-RESULT) 
                TO TEST-WS-SRV-RES-D

           IF WS-SRV-AMT NOT EQUAL FUNCTION numval-c(mfu-dd-EXP-RESULT)
               DISPLAY "Fail - " TEST-WS-SRV-AMT-D " NOT EQUAL " 
                                 TEST-WS-SRV-RES-D
               EXIT PROGRAM RETURNING 1
           END-IF

           DISPLAY "PASS - " TEST-WS-SRV-AMT-D " EQUAL " 
                             TEST-WS-SRV-RES-D
                                        
           GOBACK.

       ENTRY "MFUM_BBANK30P".   
           MOVE "csv:$MFU_DS/BBANK30P_DD.csv" TO MFU-MD-TESTDATA
           GOBACK.                
