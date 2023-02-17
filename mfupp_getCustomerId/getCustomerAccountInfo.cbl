      $set sourceformat"variable"
       program-id. "getCustomerAccountInfo".
       working-storage section.
       exec sql include sqlca end-exec.

       exec sql begin declare section end-exec.
       01 ws-customer-id           pic 9(9).
       01 ws-max-credit            pic 9(9).
       exec sql end declare section end-exec.

       linkage section.
       01 lnk-lastname             pic x(40).
       01 lnk-customer-id          pic 9(9).
       01 lnk-max-credit           pic 9(9).
       01 lnk-account-active       pic x.
       procedure division using lnk-lastname,
                                lnk-customer-id,
                                lnk-max-credit,
                                lnk-account-active.

           *> setup
           call "LoginPrompt"
           if return-code not equal 0
               goback returning 2
           end-if

           *> get customer id, from customer name
           call "getCustomerId" using
               by reference lnk-lastname,
               by reference lnk-customer-id
           end-call

           *> the customer is not found, we have no limit or
           *> account is not active
           if lnk-customer-id equal 0
               move 0 to lnk-max-credit
               move "n" to lnk-account-active
               goback returning 1
           end-if

           *> lookup the credit limit
           call "getCustomerCreditLimit" using
               by reference lnk-customer-id
               by reference lnk-max-credit
           end-call
           move "y" to lnk-account-active
           goback returning 0.


       credit-limit section.
       entry "getCustomerCreditLimit" using
               by reference lnk-customer-id
               by reference lnk-max-credit.

           move lnk-customer-id to ws-customer-id

           EXEC SQL
               SELECT ActiveCreditLimit INTO :ws-max-credit
                   FROM CreditInformation
                WHERE Id = :ws-customer-id
           END-EXEC

           *> did it work?, if so return the authors last name
           *> otherwise return spaces
           if SQLCODE equal 0
               move ws-customer-id to lnk-max-credit
           else
               move 0 to lnk-max-credit
           end-if
           goback returning 0.

       login-prompt section.
       entry "LoginPrompt".
           EXEC SQL
               CONNECT WITH PROMPT
           END-EXEC
           goback returning SQLCODE.
       end program getCustomerAccountInfo.
