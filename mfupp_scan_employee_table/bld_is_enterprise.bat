FOR /F "delims=;" %%A IN ("%COBDIR%") DO (
    if exist "%%A\cpylib\sqlca.cpy" (
        set _SQLCA_FILE="%%A\cpylib\sqlca.cpy"
    )

    if exist "%%A\cpylib\dfheiblk.cpy" (
        set _DFHEIBLK_FILE="%%A\cpylib\dfheiblk.cpy"
    )
)
