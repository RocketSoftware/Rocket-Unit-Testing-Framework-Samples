       copy "mfunit.cpy".
       01 scj-183B273D pic x(1024) VALUE SPACES.
       01 scjc-183B273D BINARY-LONG VALUE 0.
       01 scp-183B273D POINTER.
       01 scps-183B273D pic 9(9) comp-5.
       01 sg-183B273D.
       02 sc-183B273D binary-long value 0.
       02 mfupp--s-183B273D OCCURS 0 TO 128 DEPENDING ON sc-183B273D.
        03 mfupp--sqlca.
         05 SQLCA--SQLCODE       PIC S9(9) COMP-5.
         05 SQLCA--SQLERRM.
          49 SQLCA--SQLERRML    PIC S9(4) COMP-5.
          49 SQLCA--SQLERRMC    PIC X(70).
         05 SQLCA--SQLSTATE      PIC X(5).
       01 scj-C53D3605 pic x(1024) VALUE SPACES.
       01 scjc-C53D3605 BINARY-LONG VALUE 0.
       01 scp-C53D3605 POINTER.
       01 scps-C53D3605 pic 9(9) comp-5.
       01 sg-C53D3605.
       02 sc-C53D3605 binary-long value 0.
       02 mfupp--s-C53D3605 OCCURS 0 TO 128 DEPENDING ON sc-C53D3605.
        03 mfupp--sqlca.
         05 SQLCA--SQLCODE       PIC S9(9) COMP-5.
         05 SQLCA--SQLERRM.
          49 SQLCA--SQLERRML    PIC S9(4) COMP-5.
          49 SQLCA--SQLERRMC    PIC X(70).
         05 SQLCA--SQLSTATE      PIC X(5).
       01 scj-12E7DB53 pic x(1024) VALUE SPACES.
       01 scjc-12E7DB53 BINARY-LONG VALUE 0.
       01 scp-12E7DB53 POINTER.
       01 scps-12E7DB53 pic 9(9) comp-5.
       01 sg-12E7DB53.
       02 sc-12E7DB53 binary-long value 0.
       02 mfupp--s-12E7DB53 OCCURS 0 TO 128 DEPENDING ON sc-12E7DB53.
        03 mfupp--sqlca.
         05 SQLCA--SQLCODE       PIC S9(9) COMP-5.
         05 SQLCA--SQLERRM.
          49 SQLCA--SQLERRML    PIC S9(4) COMP-5.
          49 SQLCA--SQLERRMC    PIC X(70).
         05 SQLCA--SQLSTATE      PIC X(5).
       01 scj-A9076EE4 pic x(8064) VALUE SPACES.
       01 scjc-A9076EE4 BINARY-LONG VALUE 0.
       01 scp-A9076EE4 POINTER.
       01 scps-A9076EE4 pic 9(9) comp-5.
       01 sg-A9076EE4.
       02 sc-A9076EE4 binary-long value 0.
       02 mfupp--s-A9076EE4 OCCURS 0 TO 128 DEPENDING ON sc-A9076EE4.
        03 mfupp--sqlca.
         05 SQLCA--SQLCODE       PIC S9(9) COMP-5.
         05 SQLCA--SQLERRM.
          49 SQLCA--SQLERRML    PIC S9(4) COMP-5.
          49 SQLCA--SQLERRMC    PIC X(70).
         05 SQLCA--SQLSTATE      PIC X(5).
        03 mfupp--ENO PIC S9(4) COMP.
        03 mfupp--LNAME PIC X(10).
        03 mfupp--FNAME PIC X(10).
        03 mfupp--STREET PIC X(20).
        03 mfupp--CITY PIC X(15).
        03 mfupp--ST PIC XX.
        03 mfupp--ZIP PIC X(5).
        03 mfupp--DEPT PIC X(4).
        03 mfupp--PAYRATE PIC S9(13)V99 COMP-3.
        03 mfupp--COM PIC S9V99 COMP-3.
        03 mfupp--COM-NULL-IND PIC S9(4) COMP.
       01 scj-573DE08D pic x(8064) VALUE SPACES.
       01 scjc-573DE08D BINARY-LONG VALUE 0.
       01 scp-573DE08D POINTER.
       01 scps-573DE08D pic 9(9) comp-5.
       01 sg-573DE08D.
       02 sc-573DE08D binary-long value 0.
       02 mfupp--s-573DE08D OCCURS 0 TO 128 DEPENDING ON sc-573DE08D.
        03 mfupp--sqlca.
         05 SQLCA--SQLCODE       PIC S9(9) COMP-5.
         05 SQLCA--SQLERRM.
          49 SQLCA--SQLERRML    PIC S9(4) COMP-5.
          49 SQLCA--SQLERRMC    PIC X(70).
         05 SQLCA--SQLSTATE      PIC X(5).
        03 mfupp--ENO PIC S9(4) COMP.
        03 mfupp--LNAME PIC X(10).
        03 mfupp--FNAME PIC X(10).
        03 mfupp--STREET PIC X(20).
        03 mfupp--CITY PIC X(15).
        03 mfupp--ST PIC XX.
        03 mfupp--ZIP PIC X(5).
        03 mfupp--DEPT PIC X(4).
        03 mfupp--PAYRATE PIC S9(13)V99 COMP-3.
        03 mfupp--COM PIC S9V99 COMP-3.
        03 mfupp--COM-NULL-IND PIC S9(4) COMP.
       01 scj-88BF5219 pic x(1024) VALUE SPACES.
       01 scjc-88BF5219 BINARY-LONG VALUE 0.
       01 scp-88BF5219 POINTER.
       01 scps-88BF5219 pic 9(9) comp-5.
       01 sg-88BF5219.
       02 sc-88BF5219 binary-long value 0.
       02 mfupp--s-88BF5219 OCCURS 0 TO 128 DEPENDING ON sc-88BF5219.
        03 mfupp--sqlca.
         05 SQLCA--SQLCODE       PIC S9(9) COMP-5.
         05 SQLCA--SQLERRM.
          49 SQLCA--SQLERRML    PIC S9(4) COMP-5.
          49 SQLCA--SQLERRMC    PIC X(70).
         05 SQLCA--SQLSTATE      PIC X(5).
