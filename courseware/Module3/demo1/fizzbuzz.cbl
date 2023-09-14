      $set sourceformat"variable" 
       Program-Id. fizzbuzz.
       Working-Storage Section.
       01 Current-Number   Pic 9999.
       01 Current-Result   Pic x(10).
       01 Args             Pic x(128).
       01 Starting-Numberx Pic x(10).
       01 Ending-Numberx   Pic x(10).
       01 Starting-Number  Pic 9999.
       01 Ending-Number    Pic 9999.

       Procedure Division.
           Display spaces upon crt

           Move Spaces To Starting-Numberx, Ending-NumberX
           Move 1 To Starting-Number
           Move 100 To Ending-Number
           Accept Args From COMMAND-LINE

           Unstring Args Delimited By Space
               Into Starting-Number, Ending-Numberx
           End-Unstring

           If Starting-Numberx Not Equal Spaces
               Move Function numval(Starting-Numberx) To Starting-Number
           End-If

           If Ending-Numberx Not Equal Spaces
               Move Function numval(Ending-Numberx) To Ending-Number
           End-If

           Perform Varying Current-Number From Starting-Number By 1 
                           Until Current-Number > Ending-Number

               Perform Process-Number
               Display Current-Result
           End-Perform

      *>     stop "Press return to continue"
           Goback.

       Process-Number Section.
           Evaluate True
               When Function mod(Current-Number,15) Equal 0
               		Move "FIZZBUZZ" To Current-Result
               When Function Mod(Current-Number,7) Equal 0
               		Move "BAZ" To Current-Result
               When Function Mod(Current-Number,5) Equal 0
               		Move "BUZZ" To Current-Result
               When Function mod(Current-Number, 3) Equal 0
               		Move "FIZZ" To Current-Result
               When Other
               		Move Current-Number To Current-Result
           End-Evaluate    
       .

       End Program fizzbuzz.
