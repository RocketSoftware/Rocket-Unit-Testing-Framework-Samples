       program-id. "MFUT_TestSalesComm".                                        
       working-storage section.
       copy "mfunit.cpy".
       01 mfu-dd-Sales-RepName           is MFU-DD-VALUE external.
       01 mfu-dd-In-Sales                is MFU-DD-VALUE external.
       01 mfu-dd-Exp-Out-Commission      is MFU-DD-VALUE external.

       01 ws-In-Sales              pic 9(18)v9(9).
       01 ws-Out-Commission        pic 9(18)v9(9).
       01 ws-Out-Commission-disp   pic z(18).9(9) blank when zero.

       01 ws-sales-rep-name        pic x(40).

       01 ws-total-In-Sales        pic 9(18)v9(9) value 0.
       01 ws-total-Out-Commission  pic 9(18)v9(9) value 0.

       01 ws-fail-count            binary-long value 0.
       01 p                        procedure-pointer.

       procedure division.
           move mfu-dd-Sales-RepName to ws-sales-rep-name
           move function numval(mfu-dd-In-Sales) to ws-in-Sales
           move 0 to ws-out-Commission ws-fail-count
           call "CalcSalesComm" using ws-sales-rep-name, 
                                      ws-In-Sales, 
                                      ws-out-Commission
           end-call

           move ws-out-Commission to ws-Out-Commission-disp
           if ws-out-Commission  not equal function numval(mfu-dd-Exp-Out-Commission)
               display "FAIL: Test - Unexpected commision "
                        ws-Out-Commission-disp 
                        ", expected "
                        mfu-dd-Exp-Out-Commission
               end-display       
               perform display-dd-info

               move 1 to ws-fail-count
           else
               display "PASS: Test - " mfu-dd-Sales-RepName
           end-if
           goback returning ws-fail-count.
       .
 
       display-dd-info section.
           display MFU-DD-DIAG-MSG(1:MFU-DD-DIAG-MSG-LENGTH)
           display ' Sales-RepName = ' mfu-dd-Sales-RepName          
           display ' In-Sales = ' mfu-dd-In-Sales               
           display ' Exp-Out-Commission = ' mfu-dd-Exp-Out-Commission     
           .

       metadata-setup section.
       entry "MFUM_TestSalesComm"
           move "csv:TestData.csv" to MFU-MD-TESTDATA
        *>    move "Sales-RepName = MR A"  to MFU-MD-DD-CSV-FILT-COND
            move "mfudd.line.count eq 2"  to MFU-MD-DD-CSV-FILT-COND
           goback.

       testcase-setup-entrypoint section.
       entry "MFUDS_TestSalesComm".
            set p to entry "CalcSalesComm"
            call "CalcSalesCommInit"
            goback.

       testcase-teardown-entrypoint section.
       entry "MFUDE_TestSalesComm".
            call "CalcSalesCommFinished"
            goback.