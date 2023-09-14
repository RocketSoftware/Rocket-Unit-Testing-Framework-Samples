set +e
rm -f *.so *.int *.gnt *.o *debug.log *cobconfig*cfg *prep *.log *sys*.txt *.idy *lst *report.txt

cob -vgzc fizzbuzz.cbl
cobrun fizzbuzz 10 20
echo 

# cob -vgzU -e "" fizzbuzz.cbl -C case -C 'verbose preprocess"mfupp" verbose endp'
# cobmfurun -dc:ansi -verbose -redirect:true fizzbuzz.so

rm -f *.so *.int *.gnt *.o *debug.log *cobconfig*cfg *prep *.log *sys*.txt *.idy *lst *report.txt

