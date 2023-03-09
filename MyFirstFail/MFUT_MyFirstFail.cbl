      ******************************************************************
      *
      * (C) Copyright 2010-2023 Micro Focus or one of its affiliates.
      *
      * This sample code is supplied for demonstration purposes only
      * on an "as is" basis and is for use at your own risk.
      *
      ******************************************************************

      *****************************************************************
      * This is a small unit test that always fails
      *****************************************************************
       copy "mfunit_prototypes.cpy".
       program-id. "MFUT_MyFirstFail".
       78 TEST-MyFirstFail value "MyFirstFail".
       copy "mfunit.cpy".
       procedure division.
           call "CBL_DEBUGBREAK"
           call "wibble"
           *> this test case will always fail
           if 1 equals 1
              call MFU-ASSERT-FAIL-Z using by reference z"I always fail"
           end-if

           goback returning 0.

      $region Test Configuration

       entry MFU-TC-SETUP-PREFIX & TEST-MyFirstFail.
           goback returning 0
       .

       entry MFU-TC-TEARDOWN-PREFIX & TEST-MyFirstFail.
           goback returning 0
       .

       entry MFU-TC-METADATA-SETUP-PREFIX & TEST-MyFirstFail.
           move "This is a small unit test that always fails"
                 to MFU-MD-TESTCASE-DESCRIPTION
           move 10000 to MFU-MD-TIMEOUT-IN-MS
           move "smoke,myfirstfail,fail" to MFU-MD-TRAITS
           set MFU-MD-SKIP-TESTCASE to false
           goback returning 0
       .

      $end-region