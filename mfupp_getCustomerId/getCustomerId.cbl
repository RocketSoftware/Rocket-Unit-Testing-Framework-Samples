      $set sourceformat"variable"
       program-id. getCustomerId.
       working-storage section.
       exec sql include sqlca end-exec.

       exec sql begin declare section end-exec.
           01 ws-lastname              pic x(40).
           01 ws-customer-id           pic 9(9).
       exec sql end declare section end-exec.

       linkage section.
       01 lnk-lastname             pic x(40).
       01 lnk-customer-id          pic 9(9).
       procedure division using lnk-lastname,
                                lnk-customer-id.
        start-of-code.
           EXEC SQL
               SELECT Id INTO :ws-customer-id FROM customers
                WHERE LastName = :ws-lastname
           END-EXEC

           *> did it work?, if so return the authors last name
           *> otherwise return spaces
           if SQLCODE equal 0
               move ws-lastname to lnk-lastname
           else
               move spaces to lnk-lastname
           end-if
           goback.

       end program getCustomerId.
