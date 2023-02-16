      *>----------------------------------------------------------------
      *>
      *> A set of tests for the "fizzbuzz" example
      *>
      *> Objective:
      *>  Tests for fizz, buzz, baz, fizzbazz and normal number
      *>
      *>----------------------------------------------------------------
       Entry "MFUT_FIZZBUZZ".
           Move 3 To CURRENT-NUMBER
           Perform Process-Number
           display CURRENT-NUMBER " IS " CURRENT-RESULT
           If CURRENT-RESULT Not Equal "FIZZ"
               Call "MFU_ASSERT_FAIL_Z" using z"3 should be FIZZ"
           End-If

           Move 5 To CURRENT-NUMBER
           Perform Process-Number
           display CURRENT-NUMBER " IS " CURRENT-RESULT
           If CURRENT-RESULT Not Equal "BUZZ"
               CALL "MFU_ASSERT_FAIL_Z" using z"5 should be BUZZ"
           End-If

           Move 14 To CURRENT-NUMBER
           Perform Process-Number
           display CURRENT-NUMBER " IS " CURRENT-RESULT
           If CURRENT-RESULT Not Equal "BAZ"
               Call "MFU_ASSERT_FAIL_Z" using z"14 should be BAZ"
           End-If

           Move 15 To CURRENT-NUMBER
           Perform Process-Number
           display CURRENT-NUMBER " IS " CURRENT-RESULT
           If CURRENT-RESULT Not Equal "FIZZBUZZ"
               Call "MFU_ASSERT_FAIL_Z" using z"15 should be FIZZBUZZ"
           End-If

           Move 2 To CURRENT-NUMBER
           Perform Process-Number
           display CURRENT-NUMBER " IS " CURRENT-RESULT
           If CURRENT-RESULT Not Equal "0002"
               Call "MFU_ASSERT_FAIL_Z" using
                   z"2 should be 2 (not FIZZ, BUZZ, BAZ or FIZZBUZZ)"
           End-If
           Goback.