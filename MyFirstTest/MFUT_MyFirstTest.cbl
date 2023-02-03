      ******************************************************************
      *
      * (C) Copyright 2010-2023 Micro Focus or one of its affiliates.
      *
      * This sample code is supplied for demonstration purposes only
      * on an "as is" basis and is for use at your own risk.
      *
      ******************************************************************

      *****************************************************************
      * This is a example of a small unit test that always passes
      *****************************************************************
       copy "mfunit_prototypes.cpy".
       program-id. MFUT_MyfirstTest.
       working-storage section.
       78 TEST-MyFirstTest value "MyFirstTest".
       copy "mfunit.cpy".
       procedure division.
       myfirsttest-para.
            display "INFO: A message from my first test".
            goback returning MFU-PASS-RETURN-CODE.


      $region Test Configuration
       entry MFU-TC-SETUP-PREFIX & TEST-MyFirstTest.
           goback returning 0
       .

       entry MFU-TC-TEARDOWN-PREFIX & TEST-MyFirstTest.
           goback returning 0
       .

       entry MFU-TC-METADATA-SETUP-PREFIX & TEST-MyFirstTest.
           move "This is a small unit test that always passes"
                to MFU-MD-TESTCASE-DESCRIPTION
           move 10000 to MFU-MD-TIMEOUT-IN-MS
           move "smoke,myfirsttest,pass" to MFU-MD-TRAITS
           set MFU-MD-SKIP-TESTCASE to false
           goback returning 0
       .
      $end-region