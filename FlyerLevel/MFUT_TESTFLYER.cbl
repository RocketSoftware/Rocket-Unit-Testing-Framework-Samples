       program-id. MFUT_TESTFLYER.
       working-storage section.
       copy "mfunit.cpy".
       copy "GetFlyerLevel.cpy" replacing ==:prefix:== by ==ws==.

       01 ws-expected-award-level td-flyer-status.
       01 ws-earned               td-flyer-status-points.

       01 mfu-dd-InitialStatus    is MFU-DD-VALUE external.
       01 mfu-dd-FinalStatus      is MFU-DD-VALUE external.
       01 mfu-dd-InitialPoints    is MFU-DD-VALUE external.
       01 mfu-dd-EarnedPoints     is MFU-DD-VALUE external.
       procedure division.
           move mfu-dd-InitialStatus to ws-award-level
           move mfu-dd-FinalStatus   to ws-expected-award-level
           move function numval(mfu-dd-InitialPoints) to ws-award-points
           move function numval(mfu-dd-EarnedPoints) to ws-earned
           
      $if show-progress defined
           display " Data data driven test for " MFU-DD-DIAG-MSG
      $end
           call "GetFlyerLevel" using 
               by reference ws-flyer-info
               by reference ws-earned
           end-call
           if ws-award-level not equal ws-expected-award-level
               goback returning MFU-FAIL-RETURN-CODE
           end-if
           goback returning MFU-PASS-RETURN-CODE.

       entry "MFUM_TESTFLYER".
           move "csv:FrequentFlyer.csv" to MFU-MD-TESTDATA
           goback.

       end program.

