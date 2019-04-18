

# SPEC2017 CPU refrate commands line arguments

- extracted from speccmd.cmd files inside run folders of each benchmark.
- only the first run is chosen when there was multiple argument options.
- files need to be copied from:

> cp -r ../$bench/data/all/input/* .

and

> cp -r ../$bench/data/refrate/input/* .

to your current run directory.


```
./run_base_refrate_mytest-m64.0000/perlbench_base.mytest-m64    -I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1 > checkspam.2500.5.25.11.150.1.1.1.1.out 2>> checkspam.2500.5.25.11.150.1.1.1.1.err
./run_base_refrate_mytest-m64.0000/gcc_base.mytest-m64          gcc-pp.c -O5 -fipa-pta -o gcc-pp.opts-O5_-fipa-pta.s > gcc-pp.opts-O5_-fipa-pta.out 2>> gcc-pp.opts-O5_-fipa-pta.err
./run_base_refrate_mytest-m64.0000/omnetpp_base.mytest-m64      -c General -r 0 > omnetpp.General-0.out 2>> omnetpp.General-0.err
./run_base_refrate_mytest-m64.0000/xalancbmk_base.mytest-m64    -v t5.xml xalanc.xsl > ref-t5.out 2>> ref-t5.err
./run_base_refrate_mytest-m64.0000/x264_base.mytest-m64 --pass  1 --stats x264_stats.log --bitrate 1000 --frames 1000 -o BuckBunny_New.264 BuckBunny.yuv 1280x720 > run_000-1000_x264_pass1.out 2>> run_000-1000_x264_pass1.err
./run_base_refrate_mytest-m64.0000/deepsjeng_base.mytest-m64    ref.txt > ref.out 2>> ref.err
./run_base_refrate_mytest-m64.0000/leela ref.sgf_base.mytest-m64 > ref.out 2>> ref.err
./run_base_refrate_mytest-m64.0000/exchange2_base.mytest-m64    6 > exchange2.txt 2>> exchange2.err
./run_base_refrate_mytest-m64.0000/xz_base.mytest-m64           cld.tar.xz 160 19cf30ae51eddcbefda78dd06014b4b96281456e078ca7c13e1c0c9e6aaea8dff3efb4ad6b0456697718cede6bd5454852652806a657bb56e07d61128434b474 59796407 61004416 6> cld.tar-160-6.out 2>> cld.tar-160-6.err
./run_base_refrate_mytest-m64.0000/specrand_base.mytest-m64     1255432124 234923 > rand.234923.out 2>> rand.234923.err
./run_base_refrate_mytest-m64.0000/bwaves_base.mytest-m64       bwaves_1 < bwaves_1.in > bwaves_1.out 2>> bwaves_1.err
./run_base_refrate_mytest-m64.0000/cactusBSSN_base.mytest-m64   spec_ref.par > spec_ref.out 2>> spec_ref.err
./run_base_refrate_mytest-m64.0000/namd_r_base.mytest-m64       --input apoa1.input --output apoa1.ref.output --iterations 65 > namd.out 2>>namd.err
./run_base_refrate_mytest-m64.0000/parest_r_base.mytest-m64     ref.prm > ref.out 2>> ref.err
./run_base_refrate_mytest-m64.0000/povray_r_base.mytest-m64     SPEC-benchmark-ref.ini > SPEC-benchmark-ref.stdout 2>> SPEC-benchmark-ref.stderr
./run_base_refrate_mytest-m64.0000/lbm_r_base.mytest-m64        3000 reference.dat 0 0 100_100_130_ldc.of > lbm.out 2>> lbm.err
./run_base_refrate_mytest-m64.0000/lbm_s_base.mytest-m64        2000 reference.dat 0 0 200_200_260_ldc.of > lbm.out 2>> lbm.err
./run_base_refrate_mytest-m64.0000/wrf_base.mytest-m64          > rsl.out.0000 2>> wrf.err
./run_base_refrate_mytest-m64.0000/blender_r_base.mytest-m64    sh3_no_char.blend --render-output sh3_no_char_ --threads 1 -b -F RAWTGA -s 849 -e 849 -a > sh3_no_char.849.spec.out 2>> sh3_no_char.849.spec.err
./run_base_refrate_mytest-m64.0000/cam4_base.mytest-m64         > cam4.txt 2>> cam4.err
./run_base_refrate_mytest-m64.0000/pop2_base.mytest-m64         > pop2.out 2>> pop2.err
./run_base_refrate_mytest-m64.0000/imagick_base.mytest-m64      -limit disk 0 refrate_input.tga -edge 41 -resample 181% -emboss 31 -colorspace YUV -mean-shift 19x19+15% -resize 30% refrate_output.tga >refrate_convert.out 2>> refrate_convert.err
./run_base_refrate_mytest-m64.0000/nab_base.mytest-m64          1am0 1122214447 122 > 1am0.out 2>> 1am0.err
./run_base_refrate_mytest-m64.0000/fotonik3d_base.mytest-m64    > fotonik3d.log 2>> fotonik3d.err
./run_base_refrate_mytest-m64.0000/roms_base.mytest-m64         < ocean_benchmark2.in.x > ocean_benchmark2.log 2>> ocean_benchmark2.err
./run_base_refrate_mytest-m64.0000/specrand_base.mytest-m64     1255432124 234923 > rand.234923.out 2>> rand.234923.err

```
