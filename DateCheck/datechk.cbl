      ******************************************************************
      *
      * Copyright (C) 2010-2022 Micro Focus or one of its affiliates.
      *
      * The only warranties for products and services of Micro Focus and
      * its affiliates and licensors ("Micro Focus") are set forth in
      * the express warranty statements accompanying such products and
      * services. Nothing herein should be construed as constituting an
      * additional warranty. Micro Focus shall not be liable for
      * technical or editorial errors or omissions contained herein. The
      * information contained herein is subject to change without
      * notice.
      *
      * This sample code is supplied for demonstration purposes only
      * on an "as is" basis and is for use at your own risk.
      *
      ******************************************************************

       identification division.
       program-id. datechk.
      ********************************************************
      *    This subprogram validates dates input in either   *
      *      EUROPEAN or USA format. The result is returned  *
      *      as day-name, day, month-name, year.             *
      *    The program also calculates days since 1:1:1900   *
      ********************************************************
       data division.
       working-storage section.
       01  days-in-month-table         pic x(26)
                       value "31283130313031313031303129".
       01  filler redefines days-in-month-table.
           03 days-in-month            pic 99          occurs 13.
       01  month-name-table            pic x(36)
                       value "JANFEBMARAPRMAYJUNJULAUGSEPOCTNOVDEC".
       01  filler redefines month-name-table.
           03 short-month-name         pic xxx         occurs 12.
       01  day-names                   pic x(21)
                       value "MONTUEWEDTHUFRISATSUN".
       01  filler redefines day-names.
           03 day-of-the-week          pic xxx         occurs 7.
       01  leap-year-indicator         pic 9.
           88  leap-year   value 0.
       01  subscript                   pic 99.
           88  february    value 2.
       01  quotient                    pic 9999.
       01  working-date.
           03  work-day                pic 99.
           03  work-month              pic 99.
           03  work-year               pic 9999.
       01  julian-calculation.
           03  days-to-1900            pic 9(8).
           03  extra-leap-days         pic 99.
           03  days-to-date            pic 9(8).
           03  total-days              pic 9(8).
           03  current-date-integer    pic 9(8).
       01  end-of-19th-century         pic 99999999.

       linkage section.

       01  input-date.
           03 input-day-or-month       pic 99.
           03 filler                   pic x.
           03 input-month-or-day       pic 99.
           03 filler                   pic x.
           03 input-year               pic 9999.

       01  usa-or-uk                   pic x.
           88  usa     value  "U".
           88  uk      value  "E".

       01  output-date.
           02  day-name                pic xxx.
           02  day-no                  pic xx.
           02  month-name              pic xxx.
           02  full-year-no.
               03  cent-no             pic xx.
               03  year-no             pic xx.
           02  days-since-jan-1-1900   pic x(8).

       procedure division using input-date, usa-or-uk, output-date.
       date-check section.
       prepare.
           if uk move input-day-or-month to work-day
                 move input-month-or-day to work-month
           else  move "U" to usa-or-uk
                 move input-day-or-month to work-month
                 move input-month-or-day to work-day
           end-if
           move input-year to work-year.
           move spaces to day-name
           move 0 TO days-since-jan-1-1900 total-days
           move work-day to day-no
           move work-month to month-name
           move work-year to full-year-no.

           if input-year not numeric
               move spaces to year-no
           else
               if work-year = 0
                   move 1 to leap-year-indicator
               else
                   divide work-year by 4 giving quotient
                                       remainder leap-year-indicator
               end-if
               if work-month is less than 1 or greater than 12
                   move spaces to month-name
               else
                   move work-month to subscript
                   move short-month-name (subscript) to month-name
                   if leap-year and february
                       move 13 to subscript
                   end-if
                   if   work-day is less than 1
                     or greater than days-in-month (subscript)
                       move spaces to day-no
                   else
                       perform calc-1900
                   end-if
               end-if
           end-if
           exit program.

      * Calculate days since start of century.
       calc-1900                 .
           move input-year to current-date-integer(1:4)
           move work-month to current-date-integer(5:2)
           move work-day to current-date-integer(7:2)
           move "18991231" to end-of-19th-century
           compute days-to-date =
           function integer-of-date(current-date-integer)
           compute days-to-1900 =
                   function integer-of-date(end-of-19th-century)
           subtract days-to-1900 from days-to-date giving total-days
           move total-days to days-since-jan-1-1900
           subtract 1 from total-days
           divide total-days by 7 giving quotient remainder subscript.
           add 1 to subscript.
           move day-of-the-week (subscript) to day-name.


       end program datechk.
