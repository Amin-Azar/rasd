

# SPEC2017 CPU refrate commands line arguments

- extracted from speccmd.cmd files inside run folders of each benchmark.
  `> vim ../$bench/run/run_base_refrate_mytest-m64.00*/s*.cmd`

- only the first run is chosen when there was multiple argument options.


- Input files need to be copied from:

`
> cp -r ../$bench/data/all/input/* .
> cp -r ../$bench/data/refrate/input/* .
`

to your current run directory.


```

run_path="run/run_base_refrate_mytest-m64.0000"
ext="base.mytest-m64"

500.perlbench_r/$run_path/perlbench_$ext   	-I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1 > checkspam.2500.5.25.11.150.1.1.1.1.out 2>> checkspam.2500.5.25.11.150.1.1.1.1.err
502.gcc_r/$run_path/cpugcc_r_$ext 		gcc-pp.c -O3 -finline-limit=0 -fif-conversion -fif-conversion2 -o gcc-pp.opts-O3_-finline-limit_0_-fif-conversion_-fif-conversion2.s > gcc-pp.opts-O3_-finline-limit_0_-fif-conversion_-fif-conversion2.out 2>> gcc-pp.opts-O3_-finline-limit_0_-fif-conversion_-fif-conversion2.err
505.mcf_r/$run_path/mcf_r_$ext 			inp.in  > inp.out 2>> inp.err
520.omnetpp_r/$run_path/omnetpp_r_$ext 		-c General -r 0 > omnetpp.General-0.out 2>> omnetpp.General-0.err
523.xalancbmk_r/$run_path/cpuxalan_r_$ext 	-v t5.xml xalanc.xsl > ref-t5.out 2>> ref-t5.err
525.x264_r/$run_path/x264_r_$ext 		--pass 1 --stats x264_stats.log --bitrate 1000 --frames 1000 -o BuckBunny_New.264 BuckBunny.yuv 1280x720 > run_000-1000_x264_r_$ext_x264_pass1.out 2>> run_000-1000_x264_r_$ext_x264_pass1.err
531.deepsjeng_r/$run_path/deepsjeng_r_$ext 	ref.txt > ref.out 2>> ref.err
541.leela_r/$run_path/leela_r_$ext 		ref.sgf > ref.out 2>> ref.err
548.exchange2_r/$run_path/exchange2_r_$ext 	6 > exchange2.txt 2>> exchange2.err
557.xz_r/$run_path/xz_r_$ext 			cld.tar.xz 160 19cf30ae51eddcbefda78dd06014b4b96281456e078ca7c13e1c0c9e6aaea8dff3efb4ad6b0456697718cede6bd5454852652806a657bb56e07d61128434b474 59796407 61004416 6 > cld.tar-160-6.out 2>> cld.tar-160-6.err
503.bwaves_r/$run_path/bwaves_r_$ext 		bwaves_1 < bwaves_1.in > bwaves_1.out 2>> bwaves_1.err
507.cactuBSSN_r/$run_path/cactusBSSN_r_$ext 	spec_ref.par   > spec_ref.out 2>> spec_ref.err
508.namd_r/$run_path/namd_r_$ext 		--input apoa1.input --output apoa1.ref.output --iterations 65 > namd.out 2>> namd.err
510.parest_r/$run_path/parest_r_$ext 		ref.prm > ref.out 2>> ref.err
511.povray_r/$run_path/povray_r_$ext 		SPEC-benchmark-ref.ini > SPEC-benchmark-ref.stdout 2>> SPEC-benchmark-ref.stderr
519.lbm_r/$run_path/lbm_r_$ext 			3000 reference.dat 0 0 100_100_130_ldc.of > lbm.out 2>> lbm.err
521.wrf_r/$run_path/wrf_r_$ext 			> rsl.out.0000 2>> wrf.err
527.cam4_r/$run_path/cam4_r_$ext 		> cam4_r_$ext.txt 2>> cam4_r_$ext.err
538.imagick_r/$run_path/imagick_r_$ext 		-limit disk 0 refrate_input.tga -edge 41 -resample 181% -emboss 31 -colorspace YUV -mean-shift 19x19+15% -resize 30% refrate_output.tga > refrate_convert.out 2>> refrate_convert.err
549.fotonik3d_r/$run_path/fotonik3d_r_$ext 	> fotonik3d_r.log 2>> fotonik3d_r.err
997.specrand_fr/$run_path/specrand_fr_$ext 	1255432124 234923 > rand.234923.out 2>> rand.234923.err
999.specrand_ir/$run_path/specrand_ir_$ext 	1255432124 234923 > rand.234923.out 2>> rand.234923.err
544.nab_r/$run_path/nab_r_$ext 			1am0 1122214447 122 > 1am0.out 2>> 1am0.err
554.roms_r/$run_path/roms_r_$ext 		< ocean_benchmark2.in.x > ocean_benchmark2.log 2>> ocean_benchmark2.err

// make error
526.blender_r/$run_path/blender_r_$ext    	sh3_no_char.blend --render-output sh3_no_char_ --threads 1 -b -F RAWTGA -s 849 -e 849 -a > sh3_no_char.849.spec.out 2>> sh3_no_char.849.spec.err

```
