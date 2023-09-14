      *> Update the customer with information given current operating
      *>  Mode, ie: MAINTENANCE, ABORT or NORMAL 
       Program-Id. UPDCUSTID.

       Environment Division.
       Configuration Section.

       Data Division.
       Working-Storage Section.
       01 WS-InMode                Pic x(60).
       01 WS-MSG-MAINTENANCE       pic x(80)
         value "CUSTOMER UPDATE MAINTENANCE MODE ACTIVE (RETRY LATER)". 
       01 WS-MSG-ABORT       pic x(80)
         value "CUSTOMER UPDATE ABORTED".           
       01 WS-MSG-NORMAL       pic x(80)
         value "CUSTOMER UPDATE OKAY".           
       Linkage Section.
       01  DFHCOMMAREA.
         05  Filler                Pic X(1)
             Occurs 1 To 32767 Times Depending On EIBCALEN.       
       Procedure Division.
       send-maint-message-for-customer-id-update section.
           Move Spaces to WS-InMode
           Move DFHCOMMAREA(1:EIBCALEN) TO WS-InMode
           evaluate WS-InMode
               when "MAINTENANCE"
                   EXEC CICS
                       SEND TEXT FROM(WS-MSG-MAINTENANCE)
                       ERASE
                       FREEKB
                   END-EXEC
               when "ABORT"
                   EXEC CICS
                       SEND TEXT FROM(WS-MSG-ABORT)
                       ERASE
                       FREEKB
                   END-EXEC
               when "NORMAL"
                   EXEC CICS
                       SEND TEXT FROM(WS-MSG-NORMAL)
                       ERASE
                       FREEKB
                   END-EXEC                   
           end-evaluate
           .

       leave-now section.
           Goback.

       End Program UPDCUSTID.
