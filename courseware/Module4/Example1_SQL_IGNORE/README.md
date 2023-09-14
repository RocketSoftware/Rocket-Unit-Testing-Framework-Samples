# Example 1

## Ignore EXEC SQL statement

### tests/MFUPD_ScanEmployeeTable.cpy

```COBOL
           Entry "MFUT_CHK_BESTCOM"
               MOVE 1 TO COM-NULL-IND
               MOVE 0 TO BEST-COM
               MOVE 12345 TO COM
               PERFORM 50-FETCH-UPDATE
               IF BEST-COM EQUAL 0
                   DISPLAY "FAIL – BEST-COM NOT UPDATED"
                   GOBACK RETURNING 1
               END-IF
               DISPLAY "PASS"
               GOBACK.
```