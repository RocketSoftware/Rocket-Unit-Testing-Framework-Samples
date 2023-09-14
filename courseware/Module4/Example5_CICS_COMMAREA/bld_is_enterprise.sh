
for i in $(echo $COBDIR | sed 's/:/ /') ; 
do 
    if test -f "$i/cpylib/sqlca.cpy";
    then
        _SQLCA_FILE=$i/cpylib/sqlca.cpy
    fi

    if test -f "$i/cpylib/dfheiblk.cpy";
    then
        _DFHEIBLK_FILE=$i/cpylib/dfheiblk.cpy
    fi
done

