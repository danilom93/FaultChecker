#isim force add {/testchecker/uut/core_1/x_out} 69 -radix unsigned -time 115 ns -cancel 135 ns
#isim force add {/testchecker/uut/sr_2datain_s} 699 -radix unsigned -time 115 ns -cancel 124 ns


#isim force add {/testchecker/uut/sr_2datain_s} 699 -radix unsigned -time 115 ns -cancel 155 ns
#isim force add {/testchecker/uut/sr_1datain_s} 900 -radix unsigned -time 155 ns -cancel 200 ns
#isim force add {/testchecker/uut/sr_2datain_s} 999 -radix unsigned -time 115 ns -cancel 200 ns
isim force add {/testchecker/uut/sr_2datain_s} 699 -radix unsigned
#run 2000 ns
run 8000 ns
