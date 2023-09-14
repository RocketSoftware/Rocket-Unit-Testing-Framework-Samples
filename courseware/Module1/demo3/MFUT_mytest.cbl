      $set sourceformat"variable"
        program-id. "MFUT_mytest".
        working-storage section.
        copy "mfunit.cpy".
        01 p                        procedure-pointer.

        01 ws-In-Sales              pic 9(18)v9(9).
        01 ws-Out-Commission        pic 9(18)v9(9).
        01 ws-Out-Commission-disp   pic z(18).9(9) blank when zero.

        01 ws-total-In-Sales        pic 9(18)v9(9) value 0.
        01 ws-total-Out-Commission  pic 9(18)v9(9) value 0.

        01 ws-sales-rep-name        pic x(40).
        01 ws-fail-count            binary-long value 0.
        procedure division.

      $region TestCase: mytest - Sales of 2000
            move all "A" to ws-sales-rep-name
            move 2000 to ws-in-Sales
            move 0 to ws-out-Commission
            call "CalcSalesComm" using ws-sales-rep-name, 
                                   ws-In-Sales, 
                                   ws-out-Commission
            end-call
            move ws-out-Commission to ws-Out-Commission-disp
            if ws-out-Commission not equal 200
                display "FAIL: Test 1 - Unexpected commision "
                        ws-Out-Commission-disp ", expected 200"
                add 1 to ws-fail-count
            else
                display "PASS: Test 1 - " ws-Out-Commission-disp
            end-if
      $end-region
            
      $region TestCase: mytest - Sales of 2100
            move all "B" to ws-sales-rep-name
            move 2100 to ws-in-Sales
            move 0 to ws-out-Commission
            call "CalcSalesComm" using ws-sales-rep-name, 
                                   ws-In-Sales, 
                                   ws-out-Commission
            end-call
            move ws-out-Commission to ws-Out-Commission-disp
            if ws-out-Commission not equal 208
                display "FAIL: Test 2 - Unexpected commision "
                        ws-Out-Commission-disp ", expected 208"
                add 1 to ws-fail-count
            else
                display "PASS: Test 2 - " ws-Out-Commission-disp
            end-if
      $end-region

      $region TestCase: mytest - Check total commission
            call "CalcSalesGetTotal" using ws-total-Out-Commission
            *> add 1 to ws-total-Out-Commission
            move ws-total-Out-Commission to ws-Out-Commission-disp
            if ws-total-Out-Commission not equal 408
                display "FAIL: total commission calculated is invalid"
                display "  Got, " ws-Out-Commission-disp 
                        ", Expected 408"
                add 1 to ws-fail-count
            else
                display "PASS: Test 3 - overall commission total"
            end-if
      $end-region

            goback returning ws-fail-count.


        testcase-setup-entrypoint section.
        entry "MFUS_mytest".
            set p to entry "CalcSalesComm"
            call "CalcSalesCommInit"
            goback.


        testcase-teardown-entrypoint section.
        entry "MFUE_mytest".
            call "CalcSalesCommFinished"
            goback.

        testcase-metadata-entrypoint section.
        entry "MFUM_mytest".
            move "My First Unit Test"            to MFU-MD-TESTCASE-DESCRIPTION
​            move 10000                           to MFU-MD-TIMEOUT-IN-MS
            move MFU-MD-TESTCASE-PRIORITY-HIGH   to MFU-MD-TESTCASE-PRIORITY
            move "smoke,myfirsttest,pass"        to MFU-MD-TRAITS
            goback.

        end program "MFUT_mytest".