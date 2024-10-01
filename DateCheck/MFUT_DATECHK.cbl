      *****************************************************************
      *                                                               *
      * Copyright 2010-2024 Rocket Software, Inc. or its affiliates.  *
      * All Rights Reserved.                                          *
      *                                                               *
      * This software may be used, modified, and distributed          *
      * (provided this notice is included without modification)       *
      * solely for internal demonstration purposes with other         *
      * Rocket® products, and is otherwise subject to the EULA at     *
      * https://www.rocketsoftware.com/company/trust/agreements.      *
      *                                                               *
      * THIS SOFTWARE IS PROVIDED "AS IS" AND ALL IMPLIED WARRANTIES, *
      * INCLUDING THE IMPLIED WARRANTIES OF MERCHANTABILITY AND       *
      * FITNESS FOR A PARTICULAR PURPOSE, SHALL NOT APPLY.            *
      *                                                               *
      * TO THE EXTENT PERMITTED BY LAW, IN NO EVENT WILL              *
      * ROCKET SOFTWARE HAVE ANY LIABILITY WHATSOEVER IN CONNECTION   *
      * WITH THIS SOFTWARE.                                           *
      *                                                               *
      *****************************************************************

      *****************************************************************
      * This is a unit test that ensures the datachk program works
      * as expected
      *****************************************************************
      $set nestcall ans85
       copy "mfunit_prototypes.cpy".

      ****************************************************************
      *                                                              *
      *                      MFUT_DATECHK.CBL                        *
      *                                                              *
      * MFUT_DATECHK is a test program for the subprogram "DATECHK". *
      *                                                              *
      ****************************************************************

       identification division.
       program-id. MFUT_DATECHK.
       environment division.
       configuration section.
       data division.
       working-storage section.
       01 input-date                   pic x(10).
       01  output-date.
           02  day-name                pic xxx.
           02  day-no                  pic xx.
           02  month-name              pic xxx.
           02  year-no                 pic xxxx.
           02  days-since-jan-1-1900   pic x(8).

       01 tc-fail-count                binary-long.

       78 tc-usa     value  "U".
       78 tc-uk      value  "E".

       01 tc-msg-grp.
           03                         pic x(10) value "Test case ".
           03 tc-count                pic 999.
           03                         pic x(12) value " Failed -> ".
           03 tc-msg                  pic x(40).
           03                         pic x value x"0".

       procedure division.
           move 0 to tc-count tc-fail-count

           initialize output-date
           move "13/01/2000" to input-date, tc-msg
           call "datechk" using by reference input-date
                                by reference tc-usa
                                by reference output-date
           end-call
           perform expect-fail

           initialize output-date
           move "13/01/2000" to input-date, tc-msg
           call "datechk" using by reference input-date
                                by reference tc-uk
                                by reference output-date
           end-call
           perform expect-pass

           *> invalid year
           initialize output-date
           move "13/01/a000" to input-date, tc-msg
           call "datechk" using by reference input-date
                                by reference tc-uk
                                by reference output-date
           end-call
           perform expect-fail

           *> invalid month
           initialize output-date
           move "00/01/2000" to input-date, tc-msg
           call "datechk" using by reference input-date
                                by reference tc-uk
                                by reference output-date
           end-call
           perform expect-fail

           display "INFO: Test case count        : " tc-count
           display "INFO: Failed test case count : " tc-fail-count
           goback returning tc-fail-count.
        end-of-main section.

       expect-pass section.
           add 1 to tc-count
           if day-name equal spaces
               add 1 to tc-fail-count
               perform dump-output-values
               call MFU-ASSERT-FAIL-Z using
                   by reference tc-msg-grp
               end-call
            end-if
            .

        expect-fail section.
           add 1 to tc-count
           if day-name not equal spaces and
              day-no not equal spaces
               add 1 to tc-fail-count
               perform dump-output-values
               call MFU-ASSERT-FAIL-Z using
                   by reference tc-msg-grp
               end-call
            end-if
            .

         dump-output-values section.
           exhibit named tc-count input-date day-name
           exhibit named day-no month-name year-no days-since-jan-1-1900
           display "----------"
         .


       *> include the actual source code that we want to test.
       copy "datechk.cbl".

       end program MFUT_DATECHK.
