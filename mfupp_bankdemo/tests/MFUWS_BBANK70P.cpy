       copy "mfunit".
       01 TEST-DFHCOMMAEA           PIC X(6144).

       77 TEST-BANK-SCR70-AMOUNT-R  PIC X(7) JUSTIFIED  RIGHT.
       77 TEST-BANK-SCR70-RATE-R    PIC X(7) JUSTIFIED RIGHT.
       77 TEST-BANK-SCR70-TERM-R    PIC X(5) JUSTIFIED RIGHT.

       01 mfu-dd-AMOUNT             MFU-DD-VALUE EXTERNAL.
       01 mfu-dd-RATE               MFU-DD-VALUE EXTERNAL.
       01 mfu-dd-TERM               MFU-DD-VALUE EXTERNAL.
       01 mfu-dd-EXPECTED_RESULT    MFU-DD-VALUE EXTERNAL.

       01 TEST-LINE-COUNTER         pic 99.
       01 TEST-LINE-TOTAL         pic 99.