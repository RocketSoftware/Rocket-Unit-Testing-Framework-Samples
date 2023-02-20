      $set mf
       program-id. JCL_EXAMPLES.
       working-storage section.
       copy "mfunit.cpy".

       procedure division.
           goback.

      $region Test case : MFJDEM00
       entry "MFUT_MFJDEM00".
           goback.

       entry "MFUM_MFJDEM00".
           move "MFJDEM00.JCL" to MFU-MD-JCL-FILE-NAME
           move MFU-MD-TESTCASE-PRIORITY-HIGH to 
                MFU-MD-TESTCASE-PRIORITY
           move "IDCAMS - DELETE DATASETS CREATED BY JCL DEMOS" to
                MFU-MD-TESTCASE-DESCRIPTION
           goback.
      $end-region

      $region Test case : MFJDEM01
       entry "MFUT_MFJDEM01".
           goback.

       entry "MFUM_MFJDEM01".
           move "MFJDEM01.JCL" to MFU-MD-JCL-FILE-NAME
           compute MFU-MD-TESTCASE-PRIORITY = 
                   MFU-MD-TESTCASE-PRIORITY-HIGH - 1
           move "MFJDEMUT - READ AND LIST A DATASET TO THE CONSOLE" to
                MFU-MD-TESTCASE-DESCRIPTION
           goback.
      $end-region


      $region Test case : MFJDEM02
       entry "MFUT_MFJDEM02".
           goback.

       entry "MFUM_MFJDEM02".
           move "MFJDEM02.JCL" to MFU-MD-JCL-FILE-NAME
           compute MFU-MD-TESTCASE-PRIORITY = 
                   MFU-MD-TESTCASE-PRIORITY-HIGH - 2
           move "MFJDEMUT - READ AND LIST INSTREAM DATA CARDS TO " &
                "THE CONSOLE" to
                MFU-MD-TESTCASE-DESCRIPTION
           goback.
      $end-region

      $region Test case : MFJDEM03
       entry "MFUT_MFJDEM03".
           *> Is this a S806?  If so, then it's a PASS!
           if MFU-MD-JCL-COND-TYPE-SYS and
              MFU-MD-JCL-COND-CODE equal h"806"
               set MFU-MD-JCL-TESTCASE-PASSED to true
           end-if
           goback.

       entry "MFUM_MFJDEM03".
           move "MFJDEM03.JCL" to MFU-MD-JCL-FILE-NAME
           compute MFU-MD-TESTCASE-PRIORITY = 
                   MFU-MD-TESTCASE-PRIORITY-HIGH - 3
           move "XXXXXXXX - JCL ERROR - PROGRAM NOT FOUND" TO
                MFU-MD-TESTCASE-DESCRIPTION
           goback.
      $end-region

      $region Test case : MFJDEM04
       entry "MFUT_MFJDEM04".
           *> Is this a S422?  If so, then it's a PASS!
           if MFU-MD-JCL-COND-TYPE-SYS and
              MFU-MD-JCL-COND-CODE equal h"422"
               set MFU-MD-JCL-TESTCASE-PASSED to true
           end-if
           goback.

       entry "MFUM_MFJDEM04".
           move "MFJDEM04.JCL" to MFU-MD-JCL-FILE-NAME
           compute MFU-MD-TESTCASE-PRIORITY = 
                   MFU-MD-TESTCASE-PRIORITY-HIGH - 4
           move "IEFBR14 - JCL ERROR - DUPLICATE DATASET" TO
                MFU-MD-TESTCASE-DESCRIPTION
           goback.
      $end-region


      $region Test case : MFJDEM05
       entry "MFUT_MFJDEM05".
           goback.

       entry "MFUM_MFJDEM05".
           move "MFJDEM05.JCL" to MFU-MD-JCL-FILE-NAME
           compute MFU-MD-TESTCASE-PRIORITY = 
                   MFU-MD-TESTCASE-PRIORITY-HIGH - 5
           move "IEFBR14 - ALLOCATE AND DELETE DATASETS VIA " &
                "JCL DISPOSITION" TO
                MFU-MD-TESTCASE-DESCRIPTION
           goback.
      $end-region

      $region Test case : MFJDEM06
       entry "MFUT_MFJDEM06".
           goback.

       entry "MFUM_MFJDEM06".
           move "MFJDEM06.JCL" to MFU-MD-JCL-FILE-NAME
           compute MFU-MD-TESTCASE-PRIORITY = 
                   MFU-MD-TESTCASE-PRIORITY-HIGH - 6
           move "IEBGENER - COPY A FILE TO A TEMPORARY DATASET" TO
                MFU-MD-TESTCASE-DESCRIPTION
           goback.
      $end-region  

      $region Test case : MFJDEM07
       entry "MFUT_MFJDEM07".
           goback.

       entry "MFUM_MFJDEM07".
           move "MFJDEM07.JCL" to MFU-MD-JCL-FILE-NAME
           compute MFU-MD-TESTCASE-PRIORITY = 
                   MFU-MD-TESTCASE-PRIORITY-HIGH - 7
           move "IEBGENER - APPEND (MOD) DATA TO AN EXISTING DATASET" 
                TO MFU-MD-TESTCASE-DESCRIPTION
           goback.
      $end-region  

      $region Test case : MFJDEM08
       entry "MFUT_MFJDEM08".
           goback.

       entry "MFUM_MFJDEM08".
           move "MFJDEM08.JCL" to MFU-MD-JCL-FILE-NAME
           compute MFU-MD-TESTCASE-PRIORITY = 
                   MFU-MD-TESTCASE-PRIORITY-HIGH - 8
           move "IEBGENER - COPY A FILE CREATING A GDG BIAS (+1) ENTRY" 
                TO MFU-MD-TESTCASE-DESCRIPTION
           goback.
      $end-region  


      $region Test case : MFJDEM09
       entry "MFUT_MFJDEM09".
           goback.

       entry "MFUM_MFJDEM09".
           move "MFJDEM09.JCL" to MFU-MD-JCL-FILE-NAME
           compute MFU-MD-TESTCASE-PRIORITY = 
                   MFU-MD-TESTCASE-PRIORITY-HIGH - 9
           move "SORT - BATCH SORT WITH CONCATENATED INPUTS" 
                TO MFU-MD-TESTCASE-DESCRIPTION
           goback.
      $end-region

      $region Test case : MFJDEM10
       entry "MFUT_MFJDEM10".
           goback.

       entry "MFUM_MFJDEM10".
           move "MFJDEM10.JCL" to MFU-MD-JCL-FILE-NAME
           compute MFU-MD-TESTCASE-PRIORITY = 
                   MFU-MD-TESTCASE-PRIORITY-HIGH - 10
           move "IDCAMS - DEFINE CLUSTER/AIX, REPRO, PRINT, LISTCAT" 
                TO MFU-MD-TESTCASE-DESCRIPTION
           goback.
      $end-region

      $region Test case : MFJDEM11
       entry "MFUT_MFJDEM11".
           goback.

       entry "MFUM_MFJDEM11".
           move "MFJDEM11.JCL" to MFU-MD-JCL-FILE-NAME
           compute MFU-MD-TESTCASE-PRIORITY = 
                   MFU-MD-TESTCASE-PRIORITY-HIGH - 11
           move "PROCLIB - EXECUTE A CATALOGED JCL PROCEDURE" 
                TO MFU-MD-TESTCASE-DESCRIPTION
           goback.
      $end-region


      $region Test case : MFJDEM12
       entry "MFUT_MFJDEM12".
           goback.

       entry "MFUM_MFJDEM12".
           move "MFJDEM12.JCL" to MFU-MD-JCL-FILE-NAME
           compute MFU-MD-TESTCASE-PRIORITY = 
                   MFU-MD-TESTCASE-PRIORITY-HIGH - 12
           move "INSTREAM - RUN MFJDEM12 VIA INSTREAM PROC TO " &
                "PRINT REPORTS" 
                TO MFU-MD-TESTCASE-DESCRIPTION
           goback.
      $end-region


      $region Configuration
       entry MFU-GLOBAL-COMMANDLINE-PREFIX & "JCL_EXAMPLES".
        *> NOTE: un-comment if you want the region config to come from
        *>       .cfg file!
        *>    move "@region.cfg" to  MFU-GLOBAL-COMMANDLINE-ARG
           goback
           .

       entry MFU-GLOBAL-METADATA-PREFIX & "JCL_EXAMPLES". 
       *> NOTE: this test does not need to the results of job to work
           set MFU-MD-JCL-COPY-DD to false    
       .
      $end-region
       end program.