      $set sourceformat"variable"
       program-id. "MFUT_TESTCUSTOMER".


       working-storage section.
       copy "mfunit.cpy".

       01 ws-lastname              pic x(40).
       01 ws-customer-id           pic 9(9).
       01 ws-max-credit-limit      pic 9(9).
       01 ws-account-active        pic x.
       local-storage section.
       linkage section.
      $region Mock Linkage
       01 lnk-program-to-mock      pic x(MFU-PP-CONTROLLER-PRG-SIZE).
       01 lnk-program-to-mock-len  binary-long.

       01 lnk-redirect-to          pic x(MFU-PP-REDIRECT-PRG-SIZE).
       01 lnk-redirect-to-len      binary-long.

       01 lnk-who                  pic x(MFU-PP-REDIRECT-PRG-SIZE).
       01 lnk-who-len              binary-long.
      $end-region

       01 lnk-lastname             pic x(40).
       01 lnk-customer-id          pic 9(9).
       01 lnk-max-credit           pic 9(9).
       procedure division.
      *> test-case 1 - Do we have a smith?
           move "Smith" to ws-lastname
           display "TestCase 1 : Do we have a 'Smith'?"
           move 0 to ws-customer-id
           call "getCustomerAccountInfo" using
               by reference ws-lastname
               by reference ws-customer-id
               by reference ws-max-credit-limit
               by reference ws-account-active
           end-call
           perform show-customer-info
           if ws-customer-id not equal 42
               exhibit named ws-customer-id
               goback returning 10
           end-if

           *> test-case 2 - Do we have a jones?
           move "Jones" to ws-lastname
           display "TestCase 2 : Do we have a 'Jones'?"
           move 0 to ws-customer-id
           call "getCustomerAccountInfo" using
               by reference ws-lastname
               by reference ws-customer-id
               by reference ws-max-credit-limit
               by reference ws-account-active
           end-call
           perform show-customer-info
           if ws-customer-id not equal 21
               exhibit named ws-customer-id
               goback returning 20
           end-if

           *> test-case 3 - Do we have a Blobby? (we don't)
           move "Blobby" to ws-lastname
           display "TestCase 3 : Blobby is no longer with us"
           move 0 to ws-customer-id
           call "getCustomerAccountInfo" using
               by reference ws-lastname
               by reference ws-customer-id
               by reference ws-max-credit-limit
               by reference ws-account-active
           end-call
           perform show-customer-info
           if ws-customer-id not equal 0
               exhibit named ws-customer-id
               goback returning 30
           end-if

           display "ALL Passed"
           goback returning 0.

       show-customer-info section.
           display " Customer          : " ws-lastname
           display " Internal Id       : " ws-customer-id
           display " Max Credit Limit  : " ws-max-credit-limit
           display " Account active?   : " ws-account-active
           .

       test-customer-startup section.
       entry "MFUM_TESTCUSTOMER".
           move "MOCK-CONTROLLER" to MFU-MD-PP-CONTROLLER
           move "MOCK-REDIRECTOR" to MFU-MD-PP-REDIRECTOR
           goback.

      $region Mock Handler
       *>---------------------------------------------------------------
       *> Controller entry-point used to decide what action to take
       *>---------------------------------------------------------------
       entry "MOCK-CONTROLLER" using by reference lnk-program-to-mock
                                     by value lnk-program-to-mock-len
                                     .
           evaluate function upper-case(
                       lnk-program-to-mock(1:lnk-program-to-mock-len))
               when "LOGINPROMPT@GETCUSTOMERACCOUNTINFO"
                   display " => LoginPrompt is being stubbed out"
                   goback returning MFU-PP-ACTION-GOBACK
               when "GETCUSTOMERID"
                   display " => getCustomerId is being redirected"
                   goback returning MFU-PP-ACTION-REDIRECT
               when "GETCUSTOMERCREDITLIMIT@GETCUSTOMERACCOUNTINFO"
                   display " => getCustomerCreditLimit@"
                            "getCustomerAccountInfo is being redirected"
                   goback returning MFU-PP-ACTION-REDIRECT
               when "GETCUSTOMERACCOUNTINFO"
                   display " => getCustomerAccountInfo is ignored"
                   goback returning MFU-PP-ACTION-DO-NOTHING
               when other
                   display "INFO: Should this be mocked? "
                    lnk-program-to-mock(1:lnk-program-to-mock-len)
                   goback returning MFU-PP-ACTION-DO-NOTHING
           end-evaluate

           goback returning MFU-PP-ACTION-DO-NOTHING.


       *>---------------------------------------------------------------
       *> Program redirector entry-point used to decide where to send
       *>  mocked program too.
       *>---------------------------------------------------------------
       entry "MOCK-REDIRECTOR" using by reference lnk-redirect-to
                                     by value lnk-redirect-to-len
                                     by reference lnk-who
                                     by value lnk-who-len.

           *> default: just pre-prepend MOCK in the name... lazy..
           string "MOCK-" delimited by size
                   lnk-who(1:lnk-who-len) delimited by size
                   into lnk-redirect-to(1:lnk-redirect-to-len)
           end-string
           inspect lnk-redirect-to(1:lnk-redirect-to-len)
               replacing all "@" by "-"

           goback.
      $end-region

      $region Mock getCustomerId
       entry "MOCK-getCustomerId" using lnk-lastname,
                                        lnk-customer-id
                                   .
           move 0 to lnk-customer-id
           evaluate lnk-lastname
               when "Smith"        move 42 to lnk-customer-id
               when "Jones"        move 21 to lnk-customer-id
           end-evaluate
           
           goback.
      $end-region

      $region Mock getCustomerCreditLimit in getCustomerAccountInf
       entry "MOCK-getCustomerCreditLimit-getCustomerAccountInfo" using
               by reference lnk-customer-id
               by reference lnk-max-credit.

           evaluate lnk-customer-id
               when 42     move 12345 to lnk-max-credit
               when 21     move 54321 to lnk-max-credit
           goback.

      $end-region

       end program.
