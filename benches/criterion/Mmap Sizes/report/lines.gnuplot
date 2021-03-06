set output 'output.plot'
set title 'Mmap Sizes: Comparison'
set xtics nomirror 
set xlabel 'Input'
set ytics nomirror 
set ylabel 'Average time (ps)'
set grid ytics
set key on outside top right Left reverse 
set terminal svg dynamic dashed size 1280, 720 font 'Helvetica'
unset bars
plot '-' binary endian=little record=4 format='%float64' using 1:2 with lines lt 1 lw 2 lc rgb '#b22222' notitle, '-' binary endian=little record=4 format='%float64' using 1:2 with points lt 1 lc rgb '#b22222' pt 7 ps 0.75 notitle
      ?@?4s#}t@      0A??o??t@      ?A|ՙ47u@      ?Au?(Hǻt@      ?@?4s#}t@      0A??o??t@      ?A|ՙ47u@      ?Au?(Hǻt@