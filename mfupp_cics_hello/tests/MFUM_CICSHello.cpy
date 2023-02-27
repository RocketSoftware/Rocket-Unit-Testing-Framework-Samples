           mock-exec-metadata-for-cicshello SECTION.
           ENTRY "MFUM_CICSHELLO".
               MOVE "Test Case for program: CICSHELLO"
                 TO MFU-MD-TESTCASE-DESCRIPTION.
               MOVE "CICSHELLO-EXEC"  TO MFU-MD-EXEC-CONTROLLER.
               GOBACK.

           mock-exec-handler-for-cicshello SECTION.
           ENTRY "CICSHELLO-EXEC" USING
                   BY REFERENCE lnk-program,
                   BY VALUE lnk-program-len
                   BY VALUE lnk-exec-style
                   BY REFERENCE lnk-exec-info.

               EVALUATE lnk-exec-style
               WHEN MFU-PP-MOCK-EXEC-CICS
                    PERFORM handle-mock-cics-statement-cicshello
                    GOBACK
               WHEN MFU-PP-MOCK-EXEC-SQL
                    PERFORM handle-mock-sql-statement-cicshello
                    GOBACK
               END-EVALUATE
               DISPLAY "WARNING: UNKNOWN MOCK STYLE"
               GOBACK.


           handle-mock-cics-statement-cicshello SECTION.
               EVALUATE TRUE
               WHEN MFU-PP-MOCK-EXEC-FUNCTION
                        EQUAL "SEND"
                    AND MFU-PP-MOCK-EXEC-ID
                        EQUAL "CID-SEND-981C6992"
                            PERFORM MOCK-CID-SEND-981C6992
               WHEN MFU-PP-MOCK-EXEC-FUNCTION
                        EQUAL "SEND"
                    AND MFU-PP-MOCK-EXEC-ID
                        EQUAL "CID-SEND-EA84590D"
                            PERFORM MOCK-CID-SEND-EA84590D
               WHEN MFU-PP-MOCK-EXEC-FUNCTION
                        EQUAL "RECEIVE"
                    AND MFU-PP-MOCK-EXEC-ID
                        EQUAL "CID-RECEIVE-DA452AE7"
                            PERFORM MOCK-CID-RECEIVE-DA452AE7
               WHEN MFU-PP-MOCK-EXEC-FUNCTION
                        EQUAL "SEND"
                    AND MFU-PP-MOCK-EXEC-ID
                        EQUAL "CID-SEND-901C5ABF"
                            PERFORM MOCK-CID-SEND-901C5ABF
               WHEN MFU-PP-MOCK-EXEC-FUNCTION
                        EQUAL "RETURN"
                    AND MFU-PP-MOCK-EXEC-ID
                        EQUAL "CID-RETURN-5766F889"
                            PERFORM MOCK-CID-RETURN-5766F889
               WHEN OTHER
                    DISPLAY "WARNING: UNEXPECTED EXEC CICS Statement"
                    MOVE MFU-PP-ACTION-DO-NOTHING to RETURN-CODE
                    EXHIBIT NAMED MFU-PP-MOCK-EXEC-PARAMS
                    EXHIBIT NAMED MFU-PP-MOCK-EXEC-CRC
               END-EVALUATE
           .

      *>
      *> Mock implementation for EXEC CICS
      *>
      *>  SEND TEXT FROM (WS-MESSAGE-O) FREEKB ERASE WAIT
      *>
      *> Variable:
      *>    WS-MESSAGE-O
      *>
           MOCK-CID-SEND-981C6992 SECTION.
               IF MFU-PP-MOCK-EXEC-CRC NOT EQUAL "981C6992"
                   DISPLAY "CICS Statement changed (981C6992)"
               END-IF

      *>         MOVE SPACES TO WS-MESSAGE-O

               MOVE MFU-PP-ACTION-DO-NOTHING TO RETURN-CODE
           .
      *>
      *> Mock implementation for EXEC CICS
      *>
      *>  SEND CONTROL CURSOR(81)
      *>
           MOCK-CID-SEND-EA84590D SECTION.
               IF MFU-PP-MOCK-EXEC-CRC NOT EQUAL "EA84590D"
                   DISPLAY "CICS Statement changed (EA84590D)"
               END-IF

               MOVE "Hello" to WS-MESSAGE-R(4:)
               MOVE MFU-PP-ACTION-DO-NOTHING TO RETURN-CODE
           .
      *>
      *> Mock implementation for EXEC CICS
      *>
      *>  RECEIVE INTO(WS-MESSAGE-R)
      *>
      *> Variable:
      *>    WS-MESSAGE-R
      *>
           MOCK-CID-RECEIVE-DA452AE7 SECTION.
               IF MFU-PP-MOCK-EXEC-CRC NOT EQUAL "DA452AE7"
                   DISPLAY "CICS Statement changed (DA452AE7)"
               END-IF

      *>         MOVE SPACES TO WS-MESSAGE-R

               MOVE MFU-PP-ACTION-DO-NOTHING TO RETURN-CODE
           .
      *>
      *> Mock implementation for EXEC CICS
      *>
      *>  SEND TEXT ERASE FROM (WS-MESSAGE-T)
      *>
      *> Variable:
      *>    WS-MESSAGE-T
      *>
           MOCK-CID-SEND-901C5ABF SECTION.
               IF MFU-PP-MOCK-EXEC-CRC NOT EQUAL "901C5ABF"
                   DISPLAY "CICS Statement changed (901C5ABF)"
               END-IF

      *>         MOVE SPACES TO WS-MESSAGE-T

               MOVE MFU-PP-ACTION-DO-NOTHING TO RETURN-CODE
           .
      *>
      *> Mock implementation for EXEC CICS
      *>
      *>  RETURN
      *>
           MOCK-CID-RETURN-5766F889 SECTION.
               IF MFU-PP-MOCK-EXEC-CRC NOT EQUAL "5766F889"
                   DISPLAY "CICS Statement changed (5766F889)"
               END-IF

               MOVE MFU-PP-ACTION-DO-NOTHING TO RETURN-CODE
           .
           handle-mock-sql-statement-cicshello SECTION.
               DISPLAY "WARNING: UNEXPECTED EXEC SQL Statement".
