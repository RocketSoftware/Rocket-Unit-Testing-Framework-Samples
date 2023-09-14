
# Generate without default CICS ids:

```SHELL
   cobmfurun -gems -gems:skip-default-cid CICSHello.mfupp-et 
```

# Test Case (MFUT_CICSHello.cpy):

```COBOL
               PERFORM mfupp--CICSHELLO
               IF WS-MESSAGE-T EQUAL SPACES
                   DISPLAY "FAIL - 1"
                   GOBACK RETURNING 1
               END-IF

               IF FUNCTION REVERSE(WS-MESSAGE-T) EQUAL "Hello"
                   DISPLAY "FAIL - 2"
                   GOBACK RETURNING 1
               END-IF
               display "PASS - (REVERSED) WS-MESSAGE-T="
                   FUNCTION REVERSE(WS-MESSAGE-T)
```

# Mock - MFUM_CICSHello.cpy:

```COBOL

    *> remove warning messages

    *> in SET-HELLO
    MOVE "Hello" to WS-MESSAGE-R(4:)
```
