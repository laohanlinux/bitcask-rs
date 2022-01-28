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
�n�10@V-2�?�n�10@U�G��I @Swe$"@����)�	@�n�10(@>�x��@��q�&<.@�ɧǶ�@Swe$2@�K7�A�@��K*5@e����P@�n�108@���8Կ@��2#6;@u�b�T�!@��q�&<>@�-���#@0Xr�@@�(_�B�%@Swe$B@:���'@��X�C@0E�4~�)@��K*E@��Kǔ+@�'�>�F@{�G�j-@�n�10H@�ʡE�k/@��%!�I@�w���0@��2#6K@P���1@�CR%�L@T�J���2@��q�&<N@g���d@4@tѐ�(�O@��,zG5@0Xr�P@����6@���k�bQ@1"QhY�6@Swe$R@V-���7@��_��R@!����8@��X�S@�x�&1�9@�=&R�hT@Ӂ��Vk:@��K*U@��K7�1<@n�EE��U@'eRCL=@�'�>�V@)v4�_=@[�d8�nW@��\>@�n�10X@\��'n?@I�+��X@
ףp=<@@��%!�Y@�p=
ס@@6Y��tZ@+��ΡA@��2#6[@GW�� B@#����[@��(\�B@�CR%�\@7e�B@���z]@o�UfJC@��q�&<^@�t��C@�-���^@`��"�'D@tѐ�(�_@���V9E@u:��T@`@^�IqE@0Xr�`@�&1��E@����a@%�S;�&F@���k�ba@I+��F@b���V�a@^G��zG@Swe$b@�x$^�
H@�$?�ׄb@�x$^�H@��_��b@E���ԊH@O���XFc@�:U�g I@��X�c@
ףp=�I@�k^��d@�a���J@�=&R�hd@�ʡE��J@<��Z�d@��E�K@��K*e@�O��n�K@��}�ۊe@������L@n�EE��e@��Co�L@*V�\Lf@��S�M@�'�>�f@L�[�߂M@�����g@�M�GűN@[�d8�ng@�B���N@�,�^�g@�$A��N@�n�10h@%�S;�XO@�@��ߐh@�Y�rLBP@I�+��h@}�:lP@�K�`Ri@��_=�oP@��%!�i@P��n�P@z�ۡ�j@V-��EQ@6Y��tj@J+�\Q@�*k�b�j@3�ٲ{Q@��2#6k@voEb��Q@g����k@o�UfJjR@#����k@����qDR@�q��dXl@;���R@�CR%�l@;�O��	S@U��m@�O���"S@���zm@��|?5!S@˸��f�m@r75ЀS@��q�&<n@�VAt�S@B\9{�n@XƆn��S@�-���n@?�0`�4T@���th^o@���T@tѐ�(�o@ a��T@�Q,��p@�i U@u:��T@p@jIG9�&U@S#�3�pp@�ZdcU@0Xr�p@�Գ ��U@���u�p@�P�v0V@����q@�W�BV@�ƃ-62q@;l"3�V@���k�bq@$�&ݖ�V@��K���q@�� �r�V@b���V�q@c섗�dW@@j'��q@6���W@Swe$r@�"��~�W@�;ۣwTr@a����W@�$?�ׄr@}�:X@�� 8�r@�,��\AX@��_��r@��E��X@                ��_��r@ƻ�0�X@                        ��_��r@a���X@�fR���X@