           mock-exec-metadata-for-scanemployeetable SECTION.
           ENTRY "MFUM_SCANEMPLOYEETABLE".
               MOVE "Test Case for program: SCANEMPLOYEETABLE"
                 TO MFU-MD-TESTCASE-DESCRIPTION.
               MOVE "SCANEMPLOYEETABLE-EXEC"  TO MFU-MD-EXEC-CONTROLLER.
               GOBACK.

           mock-exec-handler-for-scanemployeetable SECTION.
           ENTRY "SCANEMPLOYEETABLE-EXEC" USING
                   BY REFERENCE lnk-program,
                   BY VALUE lnk-program-len
                   BY VALUE lnk-exec-style
                   BY REFERENCE lnk-exec-info.

               EVALUATE lnk-exec-style
               WHEN MFU-PP-MOCK-EXEC-CICS
                    PERFORM handle-mock-cics-statement-scanemployeetable
                    GOBACK
               WHEN MFU-PP-MOCK-EXEC-SQL
                    PERFORM handle-mock-sql-statement-scanemployeetable
                    GOBACK
               END-EVALUATE
               DISPLAY "WARNING: UNKNOWN MOCK STYLE"
               GOBACK.

           handle-mock-sql-statement-scanemployeetable SECTION.
               EVALUATE TRUE
               WHEN MFU-PP-MOCK-EXEC-FUNCTION
                        EQUAL "CONNECT"
                    AND MFU-PP-MOCK-EXEC-ID
                        EQUAL "SID-CONNECT-183B273D"
                            PERFORM MOCK-SID-CONNECT-183B273D
               WHEN MFU-PP-MOCK-EXEC-FUNCTION
                        EQUAL "DECLARE"
                    AND MFU-PP-MOCK-EXEC-ID
                        EQUAL "SID-DECLARE-C53D3605"
                            PERFORM MOCK-SID-DECLARE-C53D3605
               WHEN MFU-PP-MOCK-EXEC-FUNCTION
                        EQUAL "OPEN"
                    AND MFU-PP-MOCK-EXEC-ID
                        EQUAL "SID-OPEN-12E7DB53"
                            PERFORM MOCK-SID-OPEN-12E7DB53
               WHEN MFU-PP-MOCK-EXEC-FUNCTION
                        EQUAL "FETCH"
                    AND MFU-PP-MOCK-EXEC-ID
                        EQUAL "SID-FETCH-A9076EE4"
                            PERFORM MOCK-SID-FETCH-A9076EE4
               WHEN MFU-PP-MOCK-EXEC-FUNCTION
                        EQUAL "FETCH"
                    AND MFU-PP-MOCK-EXEC-ID
                        EQUAL "SID-FETCH-573DE08D"
                            PERFORM MOCK-SID-FETCH-573DE08D
               WHEN MFU-PP-MOCK-EXEC-FUNCTION
                        EQUAL "CLOSE"
                    AND MFU-PP-MOCK-EXEC-ID
                        EQUAL "SID-CLOSE-88BF5219"
                            PERFORM MOCK-SID-CLOSE-88BF5219
               WHEN OTHER
                    DISPLAY "WARNING: UNEXPECTED EXEC SQL Statement"
                    MOVE MFU-PP-ACTION-DO-NOTHING to RETURN-CODE
                    EXHIBIT NAMED MFU-PP-MOCK-EXEC-PARAMS
                    EXHIBIT NAMED MFU-PP-MOCK-EXEC-CRC
               END-EVALUATE
           .

      *>
      *> Mock implementation for EXEC SQL
      *>
      *>  CONNECT TO 'test'
      *>
           MOCK-SID-CONNECT-183B273D SECTION.
               IF MFU-PP-MOCK-EXEC-CRC NOT EQUAL "183B273D"
                   DISPLAY "SQL Statement changed (183B273D)"
               END-IF

               ADD 1 TO scjc-183B273D
               MOVE SQLCA--SQLCODE
                   OF mfupp--s-183B273D(scjc-183B273D)
                   TO SQLCODE
               MOVE SQLCA--SQLERRM
                   OF mfupp--s-183B273D(scjc-183B273D)
                   TO SQLERRM
               MOVE SQLCA--SQLSTATE
                   OF mfupp--s-183B273D(scjc-183B273D)
                   TO SQLSTATE
               MOVE MFU-PP-ACTION-DO-NOTHING TO RETURN-CODE
           .
      *>
      *> Mock implementation for EXEC SQL
      *>
      *>  DECLARE EMPTBL CURSOR FOR SELECT * FROM emptable ORDER BY LNAME
      *>
           MOCK-SID-DECLARE-C53D3605 SECTION.
               IF MFU-PP-MOCK-EXEC-CRC NOT EQUAL "C53D3605"
                   DISPLAY "SQL Statement changed (C53D3605)"
               END-IF

               ADD 1 TO scjc-C53D3605
               MOVE SQLCA--SQLCODE
                   OF mfupp--s-C53D3605(scjc-C53D3605)
                   TO SQLCODE
               MOVE SQLCA--SQLERRM
                   OF mfupp--s-C53D3605(scjc-C53D3605)
                   TO SQLERRM
               MOVE SQLCA--SQLSTATE
                   OF mfupp--s-C53D3605(scjc-C53D3605)
                   TO SQLSTATE

               MOVE MFU-PP-ACTION-DO-NOTHING TO RETURN-CODE
           .
      *>
      *> Mock implementation for EXEC SQL
      *>
      *>  OPEN EMPTBL
      *>
           MOCK-SID-OPEN-12E7DB53 SECTION.
               IF MFU-PP-MOCK-EXEC-CRC NOT EQUAL "12E7DB53"
                   DISPLAY "SQL Statement changed (12E7DB53)"
               END-IF

               ADD 1 TO scjc-12E7DB53
               MOVE SQLCA--SQLCODE
                   OF mfupp--s-12E7DB53(scjc-12E7DB53)
                   TO SQLCODE
               MOVE SQLCA--SQLERRM
                   OF mfupp--s-12E7DB53(scjc-12E7DB53)
                   TO SQLERRM
               MOVE SQLCA--SQLSTATE
                   OF mfupp--s-12E7DB53(scjc-12E7DB53)
                   TO SQLSTATE

               MOVE MFU-PP-ACTION-DO-NOTHING TO RETURN-CODE
           .
      *>
      *> Mock implementation for EXEC SQL
      *>
      *>  FETCH EMPTBL INTO :ENO, :LNAME, :FNAME, :STREET, :CITY, :ST, :ZIP, :DEPT, :PAYRATE, :COM, :COM-NULL-IND
      *>
           MOCK-SID-FETCH-A9076EE4 SECTION.
               IF MFU-PP-MOCK-EXEC-CRC NOT EQUAL "A9076EE4"
                   DISPLAY "SQL Statement changed (A9076EE4)"
               END-IF

               ADD 1 TO scjc-A9076EE4
               MOVE SQLCA--SQLCODE
                   OF mfupp--s-A9076EE4(scjc-A9076EE4)
                   TO SQLCODE
               MOVE SQLCA--SQLERRM
                   OF mfupp--s-A9076EE4(scjc-A9076EE4)
                   TO SQLERRM
               MOVE SQLCA--SQLSTATE
                   OF mfupp--s-A9076EE4(scjc-A9076EE4)
                   TO SQLSTATE
               MOVE MFUPP--ENO
                   OF mfupp--s-A9076EE4(scjc-A9076EE4)
                   TO ENO
               MOVE MFUPP--LNAME
                   OF mfupp--s-A9076EE4(scjc-A9076EE4)
                   TO LNAME
               MOVE MFUPP--FNAME
                   OF mfupp--s-A9076EE4(scjc-A9076EE4)
                   TO FNAME
               MOVE MFUPP--STREET
                   OF mfupp--s-A9076EE4(scjc-A9076EE4)
                   TO STREET
               MOVE MFUPP--CITY
                   OF mfupp--s-A9076EE4(scjc-A9076EE4)
                   TO CITY
               MOVE MFUPP--ST
                   OF mfupp--s-A9076EE4(scjc-A9076EE4)
                   TO ST
               MOVE MFUPP--ZIP
                   OF mfupp--s-A9076EE4(scjc-A9076EE4)
                   TO ZIP
               MOVE MFUPP--DEPT
                   OF mfupp--s-A9076EE4(scjc-A9076EE4)
                   TO DEPT
               MOVE MFUPP--PAYRATE
                   OF mfupp--s-A9076EE4(scjc-A9076EE4)
                   TO PAYRATE
               MOVE MFUPP--COM
                   OF mfupp--s-A9076EE4(scjc-A9076EE4)
                   TO COM
               MOVE MFUPP--COM-NULL-IND
                   OF mfupp--s-A9076EE4(scjc-A9076EE4)
                   TO COM-NULL-IND

               MOVE MFU-PP-ACTION-DO-NOTHING TO RETURN-CODE
           .
      *>
      *> Mock implementation for EXEC SQL
      *>
      *>  FETCH EMPTBL INTO :ENO,:LNAME,:FNAME,:STREET,:CITY, :ST,:ZIP,:DEPT,:PAYRATE, :COM :COM-NULL-IND
      *>
           MOCK-SID-FETCH-573DE08D SECTION.
               IF MFU-PP-MOCK-EXEC-CRC NOT EQUAL "573DE08D"
                   DISPLAY "SQL Statement changed (573DE08D)"
               END-IF

               ADD 1 TO scjc-573DE08D
               MOVE SQLCA--SQLCODE
                   OF mfupp--s-573DE08D(scjc-573DE08D)
                   TO SQLCODE
               MOVE SQLCA--SQLERRM
                   OF mfupp--s-573DE08D(scjc-573DE08D)
                   TO SQLERRM
               MOVE SQLCA--SQLSTATE
                   OF mfupp--s-573DE08D(scjc-573DE08D)
                   TO SQLSTATE
               MOVE MFUPP--ENO
                   OF mfupp--s-573DE08D(scjc-573DE08D)
                   TO ENO
               MOVE MFUPP--LNAME
                   OF mfupp--s-573DE08D(scjc-573DE08D)
                   TO LNAME
               MOVE MFUPP--FNAME
                   OF mfupp--s-573DE08D(scjc-573DE08D)
                   TO FNAME
               MOVE MFUPP--STREET
                   OF mfupp--s-573DE08D(scjc-573DE08D)
                   TO STREET
               MOVE MFUPP--CITY
                   OF mfupp--s-573DE08D(scjc-573DE08D)
                   TO CITY
               MOVE MFUPP--ST
                   OF mfupp--s-573DE08D(scjc-573DE08D)
                   TO ST
               MOVE MFUPP--ZIP
                   OF mfupp--s-573DE08D(scjc-573DE08D)
                   TO ZIP
               MOVE MFUPP--DEPT
                   OF mfupp--s-573DE08D(scjc-573DE08D)
                   TO DEPT
               MOVE MFUPP--PAYRATE
                   OF mfupp--s-573DE08D(scjc-573DE08D)
                   TO PAYRATE
               MOVE MFUPP--COM
                   OF mfupp--s-573DE08D(scjc-573DE08D)
                   TO COM
               MOVE MFUPP--COM-NULL-IND
                   OF mfupp--s-573DE08D(scjc-573DE08D)
                   TO COM-NULL-IND

               MOVE MFU-PP-ACTION-DO-NOTHING to RETURN-CODE
           .
      *>
      *> Mock implementation for EXEC SQL
      *>
      *>  CLOSE EMPTBL
      *>
           MOCK-SID-CLOSE-88BF5219 SECTION.
               IF MFU-PP-MOCK-EXEC-CRC NOT EQUAL "88BF5219"
                   DISPLAY "SQL Statement changed (88BF5219)"
               END-IF
               ADD 1 TO scjc-88BF5219
               MOVE SQLCA--SQLCODE
                   OF mfupp--s-88BF5219(scjc-88BF5219)
                   TO SQLCODE
               MOVE SQLCA--SQLERRM
                   OF mfupp--s-88BF5219(scjc-88BF5219)
                   TO SQLERRM
               MOVE SQLCA--SQLSTATE
                   OF mfupp--s-88BF5219(scjc-88BF5219)
                   TO SQLSTATE

               MOVE MFU-PP-ACTION-DO-NOTHING TO RETURN-CODE
           .

           handle-mock-cics-statement-scanemployeetable SECTION.
               DISPLAY "WARNING: UNEXPECTED EXEC CICS Statement".
