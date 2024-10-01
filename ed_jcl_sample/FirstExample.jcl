//* Usage on Windows:
//*   mfurun -verbose -es-server-name:ESMFUJCL ^
//*     -es-syscat:c:\esmfujcl\catalog.dat FirstExample.jcl
//*   notepad FirstExample-report.txt
//*
//* Usage on Unix:
//*   cobmfurun -verbose -es-server-name:ESMFUJCL \
//*    -es-syscat:$HOME/esmfujcl/CATALOG.DAT FirstExample.jcl
//*   vi FirstExample-report.txt
//*
//JCLDM1 JOB 'MFUEX1',CLASS=A,MSGCLASS=A
//*---- should pass ----------------------------------------------------
//STEP01 EXEC PGM=IEFBR14
//OUTA1 OUTPUT ADDRESS=('Rocket Software','The Lawn','Newbury','Berkshire')
//
