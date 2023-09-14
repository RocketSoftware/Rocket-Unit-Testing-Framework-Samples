       Entry "MFUM_CHK_BESTCOM"
           MOVE "BESTCOM-EXEC" TO MFU-MD-EXEC-CONTROLLER
           GOBACK.

       Entry "MFUT_CHK_BESTCOM"
           PERFORM 50-FETCH-UPDATE
           IF BEST-COM EQUAL 0
               DISPLAY "FAIL – BEST-COM NOT UPDATED"
               GOBACK RETURNING 1
           END-IF
           DISPLAY "PASS"
           GOBACK.
       
       Entry "BESTCOM-EXEC".
           MOVE 1 TO COM-NULL-IND
           MOVE 0 TO BEST-COM
           MOVE 12345 TO COM
           GOBACK.