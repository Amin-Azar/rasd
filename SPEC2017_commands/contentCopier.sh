

for fldr in ./*
do 
	fldr2=$fldr/run/

	for i in `seq 1 9`
	do
		cp -r $fldr2/run_base_refrate_mytest-m64.000$i/* $fldr2/run_base_refrate_mytest-m64.0000
	done

	for i in `seq 10 20`
        do
                cp -r $fldr2/run_base_refrate_mytest-m64.00$i/* $fldr2/run_base_refrate_mytest-m64.0000
        done


done
