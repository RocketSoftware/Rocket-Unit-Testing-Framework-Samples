# CICS COMMAREA

```SHELL
   cobmfurun -gems UPDCUSTID.mfupp-et 
```

```COBOL
      *> ADD TO MFUWS_UPDCUSTID.cpy
       01 TST-SEND-COUNT           PIC 9 VALUE 0.

      *> ADD TO TEST CASE
        ENTRY "MFUT_UPDCUSTID".
            PERFORM mfupp--init-cics

            MOVE "ABORT" TO DFHCOMMAREA
            PERFORM send-maint-message-for-customer-id-update
            MOVE "MAINTENANCE" TO DFHCOMMAREA
            PERFORM send-maint-message-for-customer-id-update

            PERFORM mfupp--end-cics

            IF TST-SEND-COUNT EQUAL 0
                DISPLAY "FAIL - NO CICS SEND TEXT DONE"
                GOBACK RETURNING 1
            END-IF
            GOBACK.

      *> INC counter in MOCK's for EXEC SEND
      ADD 1 TO TST-SEND-COUNT
```