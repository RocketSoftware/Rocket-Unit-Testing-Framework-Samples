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
