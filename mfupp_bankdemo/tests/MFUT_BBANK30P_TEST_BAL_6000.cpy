       ENTRY "MFUT_BBANK30P_TEST_BAL_6000".
           MOVE "000006000" TO WS-SRV-BAL
           PERFORM CALC-SERVICE-CHARGE THRU
                   CALC-SERVICE-CHARGE-EXIT

           IF WS-SRV-AMT NOT EQUAL 25.00
               DISPLAY "Fail - " WS-SRV-AMT " not 25"        
               EXIT PROGRAM RETURNING 1
           END-IF

           EXHIBIT named WS-SRV-AMT
           GOBACK.
