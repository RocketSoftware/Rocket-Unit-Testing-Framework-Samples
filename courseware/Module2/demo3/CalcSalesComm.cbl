        program-id. "CalcSalesComm".
        file-control.
            select my-report assign to "MyReport.txt"
                    organization  is line sequential.
        file section.
        fd my-report.
        01 my-report-record     pic x(70).
        working-storage section.
        78 BAND-A               value 2000.

        01 ws-sales-record      pic x(70).
        01 redefines            ws-sales-record.
            03                       pic x(5).
            03 ws-sales-rep-name     pic x(40).
            03                       pic x.
            03 ws-sales-Commission   pic Z(17)9.9(2).

        01 ws-total-In-Sales         pic 9(18)v9(9) value 0.
        01 ws-total-Out-Commission   pic 9(18)v9(9) value 0.

        linkage section.
        01 Lnk-Sales-RepName         pic x(40).
        01 lnk-In-Sales              pic 9(18)v9(9).
        01 lnk-Out-Commission        pic 9(18)v9(9).
        01 lnk-Out-Total-Commission  pic 9(18)v9(9).
        procedure division using Lnk-Sales-RepName, 
                                 Lnk-In-Sales, 
                                 lnk-Out-Commission.

        calc-and-write-record section.
            if Lnk-In-Sales <= BAND-A
                multiply Lnk-In-Sales by 0.10 giving lnk-Out-Commission
            else
                compute lnk-Out-Commission = (BAND-A *.10) + 
                                        (Lnk-In-Sales - BAND-A) * 0.08
            end-if
            
            add lnk-Out-Commission to ws-total-Out-Commission

            move spaces to ws-sales-record
            move Lnk-Sales-RepName to ws-sales-rep-name
            move lnk-Out-Commission to ws-sales-Commission
            write my-report-record from ws-sales-record
            goback.

        open-file-write-header section.
            move 0 to ws-total-Out-Commission

            *> delete file my-report
            open output my-report

            write my-report-record from "Sales Commission Report"
            write my-report-record from "======================="
            write my-report-record from spaces
            .

        close-file section.
            write my-report-record from spaces
            write my-report-record from all "="
            move spaces to ws-sales-record
            move ws-total-Out-Commission to ws-sales-Commission
            write my-report-record from ws-sales-record
            close my-report
            .
        
      $region Entry-Points to access close-file,open-file-write-header
        all-eps section.

        entry "CalcSalesCommInit".
            perform open-file-write-header
            goback.

        entry "CalcSalesCommFinished".
            perform close-file
            goback.

        entry "CalcSalesGetTotal" using lnk-Out-Total-Commission.
            move ws-total-Out-Commission to lnk-Out-Total-Commission
            goback.
            
      $end-region

        end program "CalcSalesComm".