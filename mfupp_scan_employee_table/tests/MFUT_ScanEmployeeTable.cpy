           mock-exectestcase-for-scanemployeetable section.
           ENTRY "MFUT_SCANEMPLOYEETABLE".
               PERFORM load-json
               SET QUIET-MODE TO TRUE
               MOVE 0 TO TOTAL-PAYRATE, TOTAL-DISP-RATE, BEST-COM
               PERFORM 100-MAIN THROUGH 100-EXIT
               MOVE TOTAL-PAYRATE TO TOTAL-DISP-RATE

               EXHIBIT NAMED TOTAL-DISP-RATE
               EXHIBIT NAMED BEST-COM
               IF TOTAL-PAYRATE EQUAL 0
                   DISPLAY "FAIL - No employees scanned"
                   GOBACK RETURNING 1
               END-iF
               GOBACK.

            ENTRY "MFUS_SCANEMPLOYEETABLE".
               GOBACK.

           ENTRY "MFUE_SCANEMPLOYEETABLE".
               GOBACK.

           load-json SECTION.
               SET scp-183B273D TO NULL
               CALL "MFUGETF" USING
                   BY REFERENCE z"$MFU_DS/183B273D.json"
                   BY REFERENCE scp-183B273D
                   BY REFERENCE scps-183B273D
               END-CALL
               IF RETURN-CODE EQUAL 0
                   SET ADDRESS OF lnk-json-string TO scp-183B273D
                   JSON PARSE
                       lnk-json-string(1:scps-183B273D)
                       INTO sg-183B273D
                       WITH DETAIL
                       NAME OF
                         SQLCA--SQLCODE OF mfupp--s-183B273D
                              IS "SQLCA--SQLCODE"
                         SQLCA--SQLERRM OF mfupp--s-183B273D
                              IS "SQLCA--SQLERRM"
                         SQLCA--SQLSTATE OF mfupp--s-183B273D
                              IS "SQLCA--SQLSTATE"
                   END-JSON
                   FREE scp-183B273D
                   SET scp-183B273D TO NULL
               END-IF

               SET scp-C53D3605 TO NULL
               CALL "MFUGETF" USING
                   BY REFERENCE z"$MFU_DS/C53D3605.json"
                   BY REFERENCE scp-C53D3605
                   BY REFERENCE scps-C53D3605
               END-CALL
               IF RETURN-CODE EQUAL 0
                   SET ADDRESS OF lnk-json-string TO scp-C53D3605
                   JSON PARSE
                       lnk-json-string(1:scps-C53D3605)
                       INTO sg-C53D3605
                       WITH DETAIL
                       NAME OF
                         SQLCA--SQLCODE OF mfupp--s-C53D3605
                              IS "SQLCA--SQLCODE"
                         SQLCA--SQLERRM OF mfupp--s-C53D3605
                              IS "SQLCA--SQLERRM"
                         SQLCA--SQLSTATE OF mfupp--s-C53D3605
                              IS "SQLCA--SQLSTATE"
                   END-JSON
                   FREE scp-C53D3605
                   SET scp-C53D3605 TO NULL
               END-IF

               SET scp-12E7DB53 TO NULL
               CALL "MFUGETF" USING
                   BY REFERENCE z"$MFU_DS/12E7DB53.json"
                   BY REFERENCE scp-12E7DB53
                   BY REFERENCE scps-12E7DB53
               END-CALL
               IF RETURN-CODE EQUAL 0
                   SET ADDRESS OF lnk-json-string TO scp-12E7DB53
                   JSON PARSE
                       lnk-json-string(1:scps-12E7DB53)
                       INTO sg-12E7DB53
                       WITH DETAIL
                       NAME OF
                         SQLCA--SQLCODE OF mfupp--s-12E7DB53
                              IS "SQLCA--SQLCODE"
                         SQLCA--SQLERRM OF mfupp--s-12E7DB53
                              IS "SQLCA--SQLERRM"
                         SQLCA--SQLSTATE OF mfupp--s-12E7DB53
                              IS "SQLCA--SQLSTATE"
                   END-JSON
                   FREE scp-12E7DB53
                   SET scp-12E7DB53 TO NULL
               END-IF
               SET scp-A9076EE4 TO NULL
               CALL "MFUGETF" USING
                   BY REFERENCE z"$MFU_DS/A9076EE4.json"
                   BY REFERENCE scp-A9076EE4
                   BY REFERENCE scps-A9076EE4
               END-CALL
               IF RETURN-CODE EQUAL 0
                   SET ADDRESS OF lnk-json-string TO scp-A9076EE4
                   JSON PARSE
                       lnk-json-string(1:scps-A9076EE4)
                       INTO sg-A9076EE4
                       WITH DETAIL
                       NAME OF
                         SQLCA--SQLCODE OF mfupp--s-A9076EE4
                              IS "SQLCA--SQLCODE"
                         SQLCA--SQLERRM OF mfupp--s-A9076EE4
                              IS "SQLCA--SQLERRM"
                         SQLCA--SQLSTATE OF mfupp--s-A9076EE4
                              IS "SQLCA--SQLSTATE"
                         mfupp--ENO OF mfupp--s-A9076EE4
                              is "ENO"
                         mfupp--LNAME OF mfupp--s-A9076EE4
                              is "LNAME"
                         mfupp--FNAME OF mfupp--s-A9076EE4
                              is "FNAME"
                         mfupp--STREET OF mfupp--s-A9076EE4
                              is "STREET"
                         mfupp--CITY OF mfupp--s-A9076EE4
                              is "CITY"
                         mfupp--ST OF mfupp--s-A9076EE4
                              is "ST"
                         mfupp--ZIP OF mfupp--s-A9076EE4
                              is "ZIP"
                         mfupp--DEPT OF mfupp--s-A9076EE4
                              is "DEPT"
                         mfupp--PAYRATE OF mfupp--s-A9076EE4
                              is "PAYRATE"
                         mfupp--COM OF mfupp--s-A9076EE4
                              is "COM"
                         mfupp--COM-NULL-IND OF mfupp--s-A9076EE4
                              is "COM-NULL-IND"
                   END-JSON
                   FREE scp-A9076EE4
                   SET scp-A9076EE4 TO NULL
               END-IF

               SET scp-573DE08D TO NULL
               CALL "MFUGETF" USING
                   BY REFERENCE z"$MFU_DS/573DE08D.json"
                   BY REFERENCE scp-573DE08D
                   BY REFERENCE scps-573DE08D
               END-CALL
               IF RETURN-CODE EQUAL 0
                   SET ADDRESS OF lnk-json-string TO scp-573DE08D
                   JSON PARSE
                       lnk-json-string(1:scps-573DE08D)
                       INTO sg-573DE08D
                       WITH DETAIL
                       NAME OF
                         SQLCA--SQLCODE OF mfupp--s-573DE08D
                              IS "SQLCA--SQLCODE"
                         SQLCA--SQLERRM OF mfupp--s-573DE08D
                              IS "SQLCA--SQLERRM"
                         SQLCA--SQLSTATE OF mfupp--s-573DE08D
                              IS "SQLCA--SQLSTATE"
                         mfupp--ENO OF mfupp--s-573DE08D
                              is "ENO"
                         mfupp--LNAME OF mfupp--s-573DE08D
                              is "LNAME"
                         mfupp--FNAME OF mfupp--s-573DE08D
                              is "FNAME"
                         mfupp--STREET OF mfupp--s-573DE08D
                              is "STREET"
                         mfupp--CITY OF mfupp--s-573DE08D
                              is "CITY"
                         mfupp--ST OF mfupp--s-573DE08D
                              is "ST"
                         mfupp--ZIP OF mfupp--s-573DE08D
                              is "ZIP"
                         mfupp--DEPT OF mfupp--s-573DE08D
                              is "DEPT"
                         mfupp--PAYRATE OF mfupp--s-573DE08D
                              is "PAYRATE"
                         mfupp--COM OF mfupp--s-573DE08D
                              is "COM"
                         mfupp--COM-NULL-IND OF mfupp--s-573DE08D
                              is "COM-NULL-IND"
                   END-JSON
                   FREE scp-573DE08D
                   SET scp-573DE08D TO NULL
               END-IF

               SET scp-88BF5219 TO NULL
               CALL "MFUGETF" USING
                   BY REFERENCE z"$MFU_DS/88BF5219.json"
                   BY REFERENCE scp-88BF5219
                   BY REFERENCE scps-88BF5219
               END-CALL
               IF RETURN-CODE EQUAL 0
                   SET ADDRESS OF lnk-json-string TO scp-88BF5219
                   JSON PARSE
                       lnk-json-string(1:scps-88BF5219)
                       INTO sg-88BF5219
                       WITH DETAIL
                       NAME OF
                         SQLCA--SQLCODE OF mfupp--s-88BF5219
                              IS "SQLCA--SQLCODE"
                         SQLCA--SQLERRM OF mfupp--s-88BF5219
                              IS "SQLCA--SQLERRM"
                         SQLCA--SQLSTATE OF mfupp--s-88BF5219
                              IS "SQLCA--SQLSTATE"
                   END-JSON
                   FREE scp-88BF5219
                   SET scp-88BF5219 TO NULL
               END-IF

           .
