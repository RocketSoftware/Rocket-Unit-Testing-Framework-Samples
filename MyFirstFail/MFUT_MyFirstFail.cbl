      ******************************************************************
      *
      * Copyright (C) 2010-2023 Open Text or one of its affiliates.
      *
      * The only warranties for products and services of Open Text and
      * its affiliates and licensors ("Open Text") are set forth in
      * the express warranty statements accompanying such products and
      * services. Nothing herein should be construed as constituting an
      * additional warranty. Open Text shall not be liable for
      * technical or editorial errors or omissions contained herein. The
      * information contained herein is subject to change without
      * notice.
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
