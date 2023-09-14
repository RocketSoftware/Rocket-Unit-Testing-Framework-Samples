      $SET ANS85 MF
       input-output section.
       file-control.

       select sales-data assign to "saledata.asc"
           organization sequential.

       fd sales-data
           label records are standard.
       01 sales-data-record.
           03 sales-loc-state          pic x(2).
           03 sales-rep                pic x(20).
           03 sales-office             pic x(4).

       working-storage section.
           copy "ds-cntrl.mf".
           copy "saledata.cpb".

       01 action-code                  pic 9.
           78 exit-program                     value 1.
           78 sort-by-name                     value 2.
           78 sort-by-region                   value 3.
           78 sort-by-state                    value 4.

       01 end-of-file-flag              pic 9.
           88 end-of-file                      value 1.

       01 end-of-actions-flag           pic 9.
           88 end-of-actions                   value 1.

       01 sales-rec            occurs 100 times.
           03 sales-rec-name               pic x(20).
           03 sales-rec-region             pic x(4).
           03 sales-rec-state              pic x(2).

       01 indx                     pic 99   comp-5.

       01 array-max                pic 99   comp-5 value 100.

       procedure division.

       main-process.
           perform program-initialize
           perform call-screen-manager
           perform process-actions until end-of-actions
           stop run.

       program-initialize.
           initialize ds-control-block
           initialize data-block
           move ds-new-set to ds-control
           move data-block-version-no to
                 ds-data-block-version-no
           move version-no to ds-version-no
           move "saledata" to ds-set-name
           perform initialize-data-block
           move zero to end-of-actions-flag.

       initialize-data-block.
           open input sales-data
           move zero to end-of-file-flag
           move zero to number-of-records
           move zero to indx
           perform until end-of-file
               read sales-data at end
                   move 1 to end-of-file-flag
               not at end
                   add 1 to indx
                   move sales-rep to sales-name(indx)
                   move sales-office to sales-region(indx)
                   move sales-loc-state to sales-state(indx)
                   add 1 to number-of-records
               end-read
           end-perform.

       process-actions.
           move action to action-code
           evaluate true
               when action-code = exit-program
                   move 1 to end-of-actions-flag
               when action-code = sort-by-name
                   perform sort-by-name-routine
               when action-code = sort-by-region
                   perform sort-by-region-routine
               when action-code = sort-by-state
                   perform sort-by-state-routine
           end-evaluate
           if not end-of-actions
               perform call-screen-manager.

       sort-by-name-routine.
           perform initialize-array
           perform fill-rec-from-data-block
           sort sales-rec on ascending sales-rec-name
           perform fill-data-block-from-rec.

       sort-by-region-routine.
           perform initialize-array
           perform fill-rec-from-data-block
           sort sales-rec on ascending sales-rec-region
           perform fill-data-block-from-rec.

       sort-by-state-routine.
           perform initialize-array
           perform fill-rec-from-data-block
           sort sales-rec on ascending sales-rec-state
           perform fill-data-block-from-rec.

       initialize-array.
           perform varying indx from 1 by 1
                   until indx > array-max
               move high-values to sales-rec-name(indx)
               move high-values to sales-rec-region(indx)
               move high-values to sales-rec-state(indx)
           end-perform.

       fill-rec-from-data-block.
           perform varying indx from 1 by 1
                   until indx > number-of-records
               move sales-name(indx) to sales-rec-name(indx)
               move sales-region(indx) to sales-rec-region(indx)
               move sales-state(indx) to sales-rec-state(indx)
           end-perform.

       fill-data-block-from-rec.
           perform varying indx from 1 by 1
                   until indx > number-of-records
               move sales-rec-name(indx) to sales-name(indx)
               move sales-rec-region(indx) to sales-region(indx)
               move sales-rec-state(indx) to sales-state(indx)
           end-perform.

       call-screen-manager.
           call "DSRUN" using ds-control-block,
                              data-block
           if not ds-no-error
               set end-of-actions to true
               move 0 to action
           end-if.

