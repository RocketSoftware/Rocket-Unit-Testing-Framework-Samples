           ENTRY "MFUT_BBANK70P_HELP".
               SET ADDRESS OF DFHCOMMAREA TO address of TEST-DFHCOMMAEA
               SET BANK-AID-PFK01 TO TRUE
               SET BANK-HELP-INACTIVE TO TRUE

               MOVE WS-BANK-DATA TO 
                   DFHCOMMAREA(1:LENGTH OF WS-BANK-DATA)
        
               CALL "BBANK70P"
    
               EVALUATE TRUE
                   WHEN BANK-HELP-NOT-FOUND
                       DISPLAY "FAIL : NO HELP FOUND"
                       MOVE 2 TO RETURN-CODE
                       GOBACK
                   WHEN BANK-HELP-FOUND
                       CONTINUE
                   WHEN OTHER
                       DISPLAY "FAIL : HELP01O-FOUND NOT SETUP"
                       MOVE 3 TO RETURN-CODE
                       GOBACK
               END-EVALUATE 

      * Help screen is present, but lets check the lines to see if it
      * looks reasonable via a simple line content check
               MOVE 0 TO TEST-LINE-TOTAL
               PERFORM VARYING TEST-LINE-COUNTER FROM 1 BY 1
                               UNTIL TEST-LINE-COUNTER > 19
                   IF HELP01O-LINE(TEST-LINE-COUNTER) NOT EQUAL SPACES
                       ADD 1 TO TEST-LINE-TOTAL
                   END-IF
               END-PERFORM 
               
      * At least two lines on the screen should be present
               IF TEST-LINE-TOTAL < 2
                   DISPLAY "FAIL : HELP DOES NOT CONTAIN ANY HELP"
                   MOVE 3 TO RETURN-CODE
               END-IF

               DISPLAY "Help screen has " TEST-LINE-TOTAL
                       " lines present"
               GOBACK.

      ******************************************************************
           ENTRY "MFUM_BBANK70P_HELP".
               MOVE "BANK70EXEC" TO MFU-MD-EXEC-CONTROLLER
               GOBACK.

      ******************************************************************
           ENTRY "BANK70EXEC" USING
                   BY REFERENCE lnk-program,
                   BY VALUE lnk-program-len
                   BY VALUE lnk-exec-style
                   BY REFERENCE lnk-exec-info.

      * Is this a CICS statement?
               EVALUATE lnk-exec-style
                   WHEN MFU-PP-MOCK-EXEC-CICS
                       *> only one EXEC LINK is present in this
                       *> test case, so this is simple
                       EVALUATE MFU-PP-MOCK-EXEC-FUNCTION
                           WHEN "LINK"
                               PERFORM MOCKUP-FAKE-HELP
                       END-EVALUATE
               END-EVALUATE 

               MOVE MFU-PP-ACTION-DO-NOTHING TO RETURN-CODE
               GOBACK
               .

       DISPLAY-EXEC-INFO SECTION.
           DISPLAY "BANK70EXEC: EXEC in "
                   lnk-program(1:lnk-program-len)

           DISPLAY "BANK70EXEC: MOCK FOR EXEC CICS"
           DISPLAY "  [" FUNCTION trim(MFU-PP-MOCK-EXEC-FUNCTION)
                   "]"
           DISPLAY "  [" 
                   FUNCTION trim(MFU-PP-MOCK-EXEC-PARAMS, 
                               TRAILING) 
                   "]"
           .
                   
       MOCKUP-FAKE-HELP SECTION.
      * CLEAR HELP SCREEN
           PERFORM VARYING TEST-LINE-COUNTER FROM 1 BY 1
                               UNTIL TEST-LINE-COUNTER > 19
               MOVE SPACES TO HELP01O-LINE(TEST-LINE-COUNTER)
           END-PERFORM

      * Fake up the found flag and a couple of lines of data
           SET HELP-FOUND TO TRUE
           MOVE "Fake test help data" TO HELP01O-LINE(1)
           MOVE "Fake test help datafor the second time" 
               TO HELP01O-LINE(2)
           .
