      $set sourceformat"variable" 
       program-id. "MFUT_AlwaysBroken".
       working-storage section.
       copy "mfunit.cpy".
       procedure division.
            call "AlwaysCrashes"
            goback.

        testcase-metadata-entrypoint section.
        entry "MFUM_AlwaysBroken".
            move "My really broken Unit Test"   to MFU-MD-TESTCASE-DESCRIPTION
​            move 10000                          to MFU-MD-TIMEOUT-IN-MS
            move MFU-MD-TESTCASE-PRIORITY-LOW   to MFU-MD-TESTCASE-PRIORITY
            move "smoke,secondtest,fail"        to MFU-MD-TRAITS
            goback.            
       end program "MFUT_AlwaysBroken".