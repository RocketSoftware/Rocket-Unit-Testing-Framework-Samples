       program-id. "MFUT_TestSalesComm".                                        
       working-storage section.
       copy "mfunit.cpy".
       01 mfu-dd-Sales-RepName           is MFU-DD-VALUE external.
       01 mfu-dd-In-Sales                is MFU-DD-VALUE external.
       01 mfu-dd-Exp-Out-Commission      is MFU-DD-VALUE external.
       procedure division.
           perform display-dd-info.
           goback returning MFU-PASS-RETURN-CODE.
 
       display-dd-info section.
           display MFU-DD-DIAG-MSG(1:MFU-DD-DIAG-MSG-LENGTH)
           display ' Sales-RepName = ' mfu-dd-Sales-RepName          
           display ' In-Sales = ' mfu-dd-In-Sales               
           display ' Exp-Out-Commission = ' mfu-dd-Exp-Out-Commission     
           .
       entry "MFUM_TestSalesComm"
           move "csv:TestData.csv" to MFU-MD-TESTDATA
           goback.
