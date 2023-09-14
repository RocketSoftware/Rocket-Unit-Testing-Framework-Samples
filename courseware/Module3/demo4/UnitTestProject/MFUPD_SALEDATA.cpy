       entry "MFUT_SALEDATA_SORT_BY_NAME".
           perform add-some-fake-testdata
           display "Before: " sales-name(1)
           perform sort-by-name-routine
           display "After: " sales-name(1)
           If sales-name(1) equal "Albert Jones"
               display "sort-by-name-routine worked"
           else
               display "sort-by-name-routine failed"
               goback returning MFU-FAIL-RETURN-CODE
           end-if
           goback returning MFU-PASS-RETURN-CODE.

       entry "MFUT_SALEDATA_SORT_BY_REGION".
           perform add-some-fake-testdata
           display "Before: " sales-name(1)
           perform sort-by-region-routine
           display "After: " sales-name(1)
           If sales-name(2) equal "Albert Jones"
               display "sort-by-region-routine worked"
           else
               display "sort-by-region-routine failed"
               goback returning MFU-FAIL-RETURN-CODE
           end-if
           goback returning MFU-PASS-RETURN-CODE.

       entry "MFUT_SALEDATA_SORT_BY_STATE".
           perform add-some-fake-testdata
           display "Before: " sales-name(1)
           perform sort-by-state-routine
           display "After: " sales-name(1)
           If sales-name(1) equal "Alex Williams"
               display "sort-by-state-routine worked"
           else
               display "sort-by-state-routine failed"
               goback returning MFU-FAIL-RETURN-CODE
           end-if
           goback returning MFU-PASS-RETURN-CODE.

       add-some-fake-testdata section.
           move 1 to indx
           move "Zoey Smith" to sales-name(indx)
           move "AA" to sales-region(indx)
           move "ZZ" to sales-state(indx)
           add 1 to number-of-records

           add 1 to indx
           move "Albert Jones" to sales-name(indx)
           move "ZZ" to sales-region(indx)
           move "BB" to sales-state(indx)
           add 1 to number-of-records

           add 1 to indx
           move "Alex Williams" to sales-name(indx)
           move "ZZ" to sales-region(indx)
           move "AA" to sales-state(indx)
           add 1 to number-of-records
           .