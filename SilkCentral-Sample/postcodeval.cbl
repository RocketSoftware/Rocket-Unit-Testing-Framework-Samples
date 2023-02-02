        $set sourceformat"variable"
         program-id. MFUT_POSTCODEVAL.
         working-storage section.
         copy "mfunit.cpy".

         01 test-fail-count     binary-long value 0.
         01 ws-postcode         pic x(20) .
         01                     redefines ws-postcode.
            03 ws-postcode-p1   pic xx.

         01 ws-spaces-count     binary-long.
         *> Testcase POSTCODEVAL
         procedure division.
             move 0 to ws-spaces-count

             *> this is not really a postcode validator..
             accept ws-postcode from environment "Postcode"
             inspect ws-postcode tallying ws-spaces-count for trailing spaces
             if ws-spaces-count equals length of ws-postcode
                  call "MFU_ASSERT_FAIL_Z" using
                    by reference z"POSTCODE is empty"
                  end-call
                  add 1 to test-fail-count
             end-if

             if ws-postcode-p1 not equals "RG"
                  exhibit named "Unexpected area code : " ws-postcode-p1
                  call "MFU_ASSERT_FAIL_Z" using
                    by reference z"Bad postcode"
                  end-call
                  add 1 to test-fail-count
              end-if

             if ws-postcode equals "RG7 5TQ"
                  exhibit named "Sorry don't like area code : " ws-postcode
                  call "MFU_ASSERT_FAIL_Z" using
                    by reference z"Bad postcode - just don't like it!"
                  end-call
                  add 1 to test-fail-count
             end-if

             goback returning test-fail-count.

         *> Startup for testcase POSTCODEVAL
         entry "MFUS_POSTCODEVAL".
              *> Open any files
              goback.

         *> Teardown for testcase POSTCODEVAL
         entry "MFUE_POSTCODEVAL".
              *> Close any files/delete any temp files
              goback.

         end program.
