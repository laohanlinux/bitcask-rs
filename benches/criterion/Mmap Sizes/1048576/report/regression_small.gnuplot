set output 'output.plot'
set xtics nomirror 
set xlabel 'Iterations (x 10^6)'
set grid xtics
set ytics nomirror 
set ylabel 'Total sample time (ms)'
set grid ytics
set key off
set terminal svg dynamic dashed size 450, 300 font 'Helvetica'
unset bars
plot '-' binary endian=little record=100 format='%float64' using 1:2 with points lt 1 lc rgb '#1f78b4' pt 7 ps 0.5 title 'Sample', '-' binary endian=little record=2 format='%float64' using 1:2 with lines lt 1 lw 2 lc rgb '#1f78b4' title 'Linear regression', '-' binary endian=little record=2 format='%float64' using 1:2:3 with filledcurves fillstyle solid 0.25 noborder lc rgb '#1f78b4' title 'Confidence interval'
��vhX,@;�O��.�?��vhX,@u�V. @g)YNB!"@KVE���@��vhX,(@�(]��@V���n7.@j�t��@g)YNB!2@bX9��@�h[�&5@��S�+@��vhX,8@��LM��@��u�1;@�E���D"@V���n7>@~�Ɍ�=$@I���|�@@�{+|&@g)YNB!B@��K7��(@�����C@h��|?*@�h[�&E@�MbXi+@�s�ᒩF@��A�|-@��vhX,H@��(\��/@�O���I@�y ���0@��u�1K@���[�1@8,���L@��?�Z3@V���n7N@% &�B.4@t	4�O@�n���4@I���|�P@� dˊ5@Xr��_Q@�&1��6@g)YNB!R@ �K��7@v����R@�%�`�8@�����S@1"QhY�9@�N$�jeT@!����:@�h[�&U@X9���;@���0�U@�V�=@�s�ᒩV@V-��=@�*3��jW@ �K�N>@��vhX,X@�w��a?@혺+��X@��K7�9@@�O���Y@+��$��@@B��pZ@\�gA(�A@��u�1[@�c�M*�A@)u�8F�[@R���+B@8,���\@�sCS�B@G�P�v]@�S�CC@V���n7^@�6��:"D@eQ�E��^@�҈�}D@t	4�_@�=b�D@��/f�=`@����E@I���|�`@o,(ʆE@Жs).�`@!=E!F@Xr��_a@#���iIG@�M���a@y�|!G@g)YNB!b@�[��byG@����b@��5&�H@v����b@��KrH@��>sVCc@f��e�H@�����c@Ւ�r0mI@s�6�d@���(@�J@�N$�jed@ʡE���J@*���d@��8dK@�h[�&e@T�J���K@*�	�~�e@s�69|M@���0�e@n��ʩL@9�M��Hf@���&�cM@�s�ᒩf@H�`�^M@HO�CD
g@N�����M@�*3��jg@��
O@W���g@XSYv�N@��vhX,h@�S�QO@f��	�h@�g\W�O@혺+��h@�f���P@ut\�lNi@L7�A`yP@�O���i@�VAt�P@�+�P�j@���Mb�P@B��pj@-���PQ@���2�j@���Mb�Q@��u�1k@�%9`W�Q@��'ה�k@0�Qd��Q@)u�8F�k@;l"3�R@�Pk��Sl@�Z��|R@8,���l@6:�8S@��]Zm@�N���R@G�P�vm@^G��ZS@ξ� ��m@�p=
�aS@V���n7n@     �S@�u6��n@y�&1�S@eQ�E��n@E����T@�,z��Yo@�A`�оT@t	4�o@�%9`W�T@��^�rp@�}r �T@��/f�=p@FCƣT6U@�� $np@ݱ�&�U@I���|�p@�%9`W�U@��x��p@6��V@Жs).�p@tD�K�;V@��Dچ/q@ףp=
EV@Xr��_q@�$���V@`�;8�q@�Z���V@�M���q@Z���UW@�;����q@#h�$�;W@g)YNB!r@;l"3�W@+*��Qr@u ��mX@����r@τ&�%X@���`L�r@�Y�rL�X@v����r@�t��X@                v����r@�#� �X@                        v����r@���!��X@}��p�X@