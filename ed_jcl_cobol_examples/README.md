# JCL Examples as a UnitTest

## Overview
This example, is the same JCL example provided in the Mainframe\JCL\Classic\jcl-examples directory but is provided as UnitTest.

## Description

This example, is the same JCL example provided in the Mainframe\JCL\Classic\jcl-examples directory but is provided as a mfunit COBOL/JCL Unit Test.

This folder contains supplementary demonstration files for the JCL component included in Enterprise Developer.

Each job contains comments describing the features demonstrated, along with any setup required in order to run the jobstream

MFJDEM00.JCL is a good starting point for running the supplementary jobs.  It provides an overview, and includes an index to all of the
other JCL example jobstreams.

## Requirements

You need to configure an enterprise server for JCL.

### How to Run This Demonstration

To run these demonstration jobs you will need a JCL enabled Enterprise Server region.   See the documentation on how to "Set Up the ESJCL Enterprise Server Region"
      
Follow the configuration information for the region provided in the MFJDEM00.JCL fille.
      
Build the COBOL part of the Unit Test using the bld.bat command

Then run the unit test with mfurun, replace ESMFUJCL with your own region and changing the directory of your catalog.dat, for example:
       
      mfurun -show-progress -es-server-name:ESMFUJCL -es-syscat:c:\esmfujcl\catalog.dat JCL_EXAMPLES

Open JCL_EXAMPLES.md or JCL_EXAMPLES-report.txt

