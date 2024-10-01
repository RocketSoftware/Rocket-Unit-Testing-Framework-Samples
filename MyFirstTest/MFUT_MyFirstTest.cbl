      *****************************************************************
      *                                                               *
      * Copyright 2010-2024 Rocket Software, Inc. or its affiliates.  *
      * All Rights Reserved.                                          *
      *                                                               *
      * This software may be used, modified, and distributed          *
      * (provided this notice is included without modification)       *
      * solely for internal demonstration purposes with other         *
      * Rocket® products, and is otherwise subject to the EULA at     *
      * https://www.rocketsoftware.com/company/trust/agreements.      *
      *                                                               *
      * THIS SOFTWARE IS PROVIDED "AS IS" AND ALL IMPLIED WARRANTIES, *
      * INCLUDING THE IMPLIED WARRANTIES OF MERCHANTABILITY AND       *
      * FITNESS FOR A PARTICULAR PURPOSE, SHALL NOT APPLY.            *
      *                                                               *
      * TO THE EXTENT PERMITTED BY LAW, IN NO EVENT WILL              *
      * ROCKET SOFTWARE HAVE ANY LIABILITY WHATSOEVER IN CONNECTION   *
      * WITH THIS SOFTWARE.                                           *
      *                                                               *
      *****************************************************************

      *****************************************************************
      * This is a example of a small unit test that always passes
      *****************************************************************
       copy "mfunit_prototypes.cpy".
       program-id. MFUT_MyFirstTest.
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