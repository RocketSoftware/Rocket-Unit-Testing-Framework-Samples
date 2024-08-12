      $set sourceformat"variable" 
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ScanEmployeeTable. 
       WORKING-STORAGE SECTION. 
       
       EXEC SQL 
         INCLUDE emprec
       END-EXEC. 
       
       01 DISP-RATE    PIC $$$,$$$,$$9.99.
       01 DISP-COM     PIC Z.99.
       01 DISP-CODE    PIC ----9.
       01 COM-NULL-IND PIC S9(4) COMP.
       
       01 TOTAL-PAYRATE PIC S9(19)V99 COMP-3.
       01 TOTAL-DISP-RATE PIC $$,$$$,$$$,$$9.99.
       01 BEST-COM      PIC S9V99 COMP-3.

       EXEC SQL 
         INCLUDE SQLCA 
       END-EXEC. 
       
       01               PIC X VALUE SPACES.
        88 QUIET-MODE   value "Y", FALSE " ".

       LOCAL-STORAGE SECTION.
       LINKAGE SECTION.

       PROCEDURE DIVISION. 

       000-TOP.
           PERFORM 100-MAIN THROUGH 100-EXIT
           GOBACK.

       100-MAIN.
           EXEC SQL CONNECT TO 'test' END-EXEC
           MOVE SQLCODE TO DISP-CODE
           IF SQLCODE < 0
               DISPLAY 'ERROR: Unable to open test connection'
               EXHIBIT NAMED DISP-CODE "/" SQLERRMC
               EXIT PARAGRAPH
           END-IF           
           MOVE 0 to TOTAL-PAYRATE BEST-COM

      * declare cursor for select 
           EXEC SQL
               DECLARE EMPTBL CURSOR FOR
               SELECT * 
                 FROM emptable
               ORDER BY LNAME
           END-EXEC
       
      * open cursor
           EXEC SQL
               OPEN EMPTBL
           END-EXEC 
           MOVE SQLCODE TO DISP-CODE
           IF SQLCODE < 0
               DISPLAY 'ERROR: Unable to open employee table'
               EXHIBIT NAMED DISP-CODE "/" SQLERRMC
               EXIT PARAGRAPH
           END-IF

           IF NOT QUIET-MODE
               DISPLAY 'Please waiting processing employee table'
               DISPLAY ' '
           END-IF

      * fetch a data item 
           INITIALIZE EMP-TABLE
           PERFORM 100-TRAVERSE
           GOBACK
           .
       
       100-TRAVERSE. 
           MOVE SQLCODE TO DISP-CODE
       
      * loop until no more data
           PERFORM UNTIL SQLCODE < 0 OR SQLCODE = 100  
               PERFORM DISPLAY-RECORD
               PERFORM 50-FETCH-UPDATE
           END-PERFORM  
       
           PERFORM DISPLAY-STATS

           IF NOT QUIET-MODE
               DISPLAY 'All records in the employee table have been selected'
               DISPLAY ' '
           END-IF
           .

       50-FETCH-UPDATE.
           EXEC SQL 
             FETCH EMPTBL INTO 
               :ENO,:LNAME,:FNAME,:STREET,:CITY, 
               :ST,:ZIP,:DEPT,:PAYRATE, 
               :COM :COM-NULL-IND 
           END-EXEC 

           IF COM-NULL-IND >= 0 AND COM > BEST-COM
               MOVE COM TO BEST-COM
           END-IF                  
           ADD PAYRATE TO TOTAL-PAYRATE           
           MOVE SQLCODE TO DISP-CODE 
           .

       CLOSE-LOOP.
      * close the cursor
           EXEC SQL 
               CLOSE EMPTBL 
           END-EXEC. 
       100-EXIT. 


       DISPLAY-RECORD.
           IF QUIET-MODE
               EXIT PARAGRAPH
           END-IF
           MOVE PAYRATE TO DISP-RATE
           MOVE COM TO DISP-COM

           DISPLAY 'Department           : ' DEPT 
           DISPLAY 'Last name            : ' LNAME 
           DISPLAY 'First name           : ' FNAME 
           DISPLAY 'Street               : ' STREET 
           DISPLAY 'City                 : ' CITY 
           DISPLAY 'State                : ' ST 
           DISPLAY 'Zip code             : ' ZIP 
           DISPLAY 'Payrate              : ' 
               FUNCTION trim(DISP-RATE, leading)

           IF COM-NULL-IND < 0 
               DISPLAY ' Commission is null' 
           ELSE 
               DISPLAY ' Commission          : ' DISP-COM
           END-IF 
           DISPLAY " "
       .

       DISPLAY-STATS.
           IF QUIET-MODE
               EXIT PARAGRAPH
           END-IF       
           DISPLAY ' Stats:'
           MOVE TOTAL-PAYRATE TO TOTAL-DISP-RATE
           DISPLAY '  Total Payrate      : ' 
               FUNCTION trim(TOTAL-DISP-RATE, leading)
           MOVE BEST-COM TO DISP-COM
           DISPLAY '  Best Commission    : ' DISP-COM
       .
