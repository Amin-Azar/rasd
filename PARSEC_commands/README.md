

# PARSEC sim-large commands line arguments



```

	if [ ${BASENAME} = "blackscholes" ]; then
            COMMAND="${BENCHDIR}/Parsec/pkgs/apps/blackscholes/inst/amd64-linux.gcc-serial/bin/blackscholes 1 in_10M.txt output.txt"
        elif [ ${BASENAME} = "bodytrack" ]; then
            COMMAND="${BENCHDIR}/Parsec/pkgs/apps/bodytrack/inst/amd64-linux.gcc-serial/bin/bodytrack sequenceB_261 4 261 4000 5 0 1 output.txt"
            CORE="Timing"
        elif [ ${BASENAME} = "facesim" ]; then
            COMMAND="${BENCHDIR}/Parsec/pkgs/apps/facesim/inst/amd64-linux.gcc-serial/bin/facesim -timing -threads 1 -lastframe 100"
        elif [ ${BASENAME} = "ferret" ]; then
            COMMAND="${BENCHDIR}/Parsec/pkgs/apps/ferret/inst/amd64-linux.gcc-serial/bin/ferret corel lsh queries 50 20 1 output.txt"
        elif [ ${BASENAME} = "fluidanimate" ]; then
            COMMAND="${BENCHDIR}/Parsec/pkgs/apps/fluidanimate/inst/amd64-linux.gcc-serial/bin/fluidanimate 1 500 in_500K.fluid output.txt"
        elif [ ${BASENAME} = "freqmine" ]; then
            COMMAND="${BENCHDIR}/Parsec/pkgs/apps/freqmine/inst/amd64-linux.gcc-serial/bin/freqmine webdocs_250k.dat 11000"
        elif [ ${BASENAME} = "raytrace" ]; then
            COMMAND="${BENCHDIR}/Parsec/pkgs/apps/raytrace/inst/amd64-linux.gcc-serial/bin/rtview thai_statue.obj -automove -nthreads 1 -frames 200 -res 1920 1080"
        elif [ ${BASENAME} = "swaptions" ]; then
            COMMAND="${BENCHDIR}/Parsec/pkgs/apps/swaptions/inst/amd64-linux.gcc-serial/bin/swaptions -ns 128 -sm 1000000 -nt 1"
        elif [ ${BASENAME} = "vips" ]; then
            COMMAND="${BENCHDIR}/Parsec/pkgs/apps/vips/inst/amd64-linux.gcc-serial/bin/vips im_benchmark orion_18000x18000.v output.v"
        elif [ ${BASENAME} = "x264" ]; then
            COMMAND="${BENCHDIR}/Parsec/pkgs/apps/x264/inst/amd64-linux.gcc-serial/bin/x264 --quiet --qp 20 --partitions b8x8,i4x4 --ref 5 --direct auto --b-pyramid --weightb --mixed-refs --no-fast-pskip --me umh --subme 7 --analyse b8x8,i4x4 --threads 1 -o output.txt eledream_1920x1080_512.y4m"
        elif [ ${BASENAME} = "canneal" ]; then
            COMMAND="${BENCHDIR}/Parsec/pkgs/kernels/canneal/inst/amd64-linux.gcc-serial/bin/canneal 1 15000 2000 2500000.nets 6000"
        elif [ ${BASENAME} = "dedup" ]; then
            COMMAND="${BENCHDIR}/Parsec/pkgs/kernels/dedup/inst/amd64-linux.gcc-serial/bin/dedup -c -p -v -t 1 -i FC-6-x86_64-disc1.iso -o output.txt"
        elif [ ${BASENAME} = "streamcluster" ]; then
            COMMAND="${BENCHDIR}/Parsec/pkgs/kernels/streamcluster/inst/amd64-linux.gcc-serial/bin/streamcluster 10 20 128 1000000 200000 5000 none output.txt 1"
        fi
```
