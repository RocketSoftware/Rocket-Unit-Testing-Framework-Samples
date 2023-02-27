           mock-exectestcase-for-cicshello SECTION.
           ENTRY "MFUT_CICSHELLO".
               PERFORM mfupp--CICSHELLO
               IF WS-MESSAGE-T EQUAL SPACES
                   DISPLAY "FAIL - 1"
                   GOBACK RETURNING 1
               END-IF

               IF FUNCTION REVERSE(WS-MESSAGE-T) EQUAL "Hello"
                   DISPLAY "FAIL - 2"
                   GOBACK RETURNING 1
               END-IF
               display "(REVERSED) WS-MESSAGE-T=" 
                   FUNCTION REVERSE(WS-MESSAGE-T)
               GOBACK.

           ENTRY "MFUS_CICSHELLO".
               GOBACK.

           ENTRY "MFUE_CICSHELLO".
               GOBACK.
