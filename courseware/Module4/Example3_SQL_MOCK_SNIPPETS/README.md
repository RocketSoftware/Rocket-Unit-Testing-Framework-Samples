# Example 23

## Code Generation

 - add temporary directives to mfupp.dir to generate the exec report
 - use "cobmfurun" -gems or "cobmfurun -generate-exec-mock-snippet​"

### tests/MFUPD_ScanEmployeeTable.cpy

```COBOL
    ENTRY "MFUT_SCANEMPLOYEETABLE".
        PERFORM 50-FETCH-UPDATE
        IF BEST-COM EQUAL 0
            DISPLAY "FAIL – BEST-COM NOT UPDATED"
            GOBACK RETURNING 1
        END-IF
        DISPLAY "PASS"
        GOBACK.
       

    *> THIS TO THE MOCK FOR THE "EXEC SQL FETCH"
           MOVE 1 TO COM-NULL-IND
           MOVE 0 TO BEST-COM
           MOVE 12345 TO COM
           GOBACK.
```

### tests/MFUWS_ScanEmployeeTable.cpy

```COBOL
           copy "mfunit.cpy".
```