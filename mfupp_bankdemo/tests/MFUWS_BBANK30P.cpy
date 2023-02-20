       copy "mfunit.cpy".
       77 TEST-WS-SRV-AMT-9            PIC 9(7)v99.
       77 TEST-WS-SRV-AMT-9-X          PIC 9(9) 
                                       redefines TEST-WS-SRV-AMT-9.

       77 TEST-WS-SRV-AMT-D            PIC 9(3).99.
       77 TEST-WS-SRV-RES-D            PIC 9(3).99.

      *> data driven externals
       01 mfu-dd-WS-SRV-AMT            is MFU-DD-VALUE external.
       01 mfu-dd-EXP-RESULT            is MFU-DD-VALUE external.