

#fl_size="run_base_test_mytest-m64"
fl_size="run_base_refrate_mytest-m64"

for fldr in ./*
do 
	fldr2=$fldr/run/

	for i in `seq 1 9`
	do
		rm -rf $fldr2/$fl_size.000$i
	done

	for i in `seq 10 20`
        do
                rm -rf  $fldr2/$fl_size.00$i
        done


done
