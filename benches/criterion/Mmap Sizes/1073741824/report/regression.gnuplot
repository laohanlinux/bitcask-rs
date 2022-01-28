set output 'output.plot'
set title 'Mmap Sizes/1073741824'
set xtics nomirror 
set xlabel 'Iterations (x 10^6)'
set grid xtics
set ytics nomirror 
set ylabel 'Total sample time (ms)'
set grid ytics
set key on inside top left Left reverse 
set terminal svg dynamic dashed size 1280, 720 font 'Helvetica'
unset bars
plot '-' binary endian=little record=100 format='%float64' using 1:2 with points lt 1 lc rgb '#1f78b4' pt 7 ps 0.5 title 'Sample', '-' binary endian=little record=2 format='%float64' using 1:2 with lines lt 1 lw 2 lc rgb '#1f78b4' title 'Linear regression', '-' binary endian=little record=2 format='%float64' using 1:2:3 with filledcurves fillstyle solid 0.25 noborder lc rgb '#1f78b4' title 'Confidence interval'
�hW!�'@�X�W�?�hW!�'@L�*��N @u���"@\���(�@�hW!�'(@�x�&1�@�B�i�1.@:Yj�ߘ@u���2@M�p]�@�{,}�"5@K7�A`�@�hW!�'8@Y�U�W@�U���,;@�V%�}�!@�B�i�1>@���Ŋ#@��m�@@+�ن%@u���B@��ʡu'@�+j�C@nO���v)@�{,}�"E@a��_+@�A�f�F@�V�-@�hW!�'H@c'�O0@&�lsc�I@�}V�)I1@�U���,K@9�m½:2@:̗`�L@+���33@�B�i�1N@�\�3@M�»\�O@�˸���4@��m�P@��,z�5@0����\Q@�Z{���6@u���R@�S㥛t7@�I+�R@`�un�p8@�+j�S@��j9@D�!T�aT@cD�вb:@�{,}�"U@���];@�67�'�U@_ѭ׀<@�A�f�V@5x_�Q=@W�L��fW@�\�&��>@�hW!�'X@�ɍ"kQ?@�#bJ$�X@�Zd;a@@&�lsc�Y@ᔹ�F�@@k�w��kZ@��|?5@A@�U���,[@rh��|�A@��� �[@NbX9HB@:̗`�\@Bz�"�B@��@�p]@5^�I�C@�B�i�1^@�D@����^@?5^�I�D@M�»\�_@�_[?��D@I�f��:`@'��Q�E@��m�`@p�x��E@�uq�`@�a��KF@0����\a@��Q��F@�0|DL�a@t	���G@u���b@����M�G@�m�~b@������G@�I+�b@�Y�rLtH@]����?c@;���H@�+j�c@�p=
�MJ@�b��	d@���z�J@D�!T�ad@TpxADdJ@���H�d@�$A��J@�{,}�"e@p��|#rK@+ٱ��e@�~j�tCL@�67�'�e@��k�6�L@p��:�Df@
ףp=M@�A�f�f@���z�RM@�O�cg@ᔹ�F�M@W�L��fg@�G�z�N@�
ҌE�g@��Q�,O@�hW!�'h@��n�^O@?�ܵ��h@��o�D�O@�#bJ$�h@!�rh�<P@�����Ii@���(\}P@&�lsc�i@���V�P@�<�j@��W���P@k�w��kj@_�(�Q@��0B�j@�G�z�Q@�U���,k@���KR@R�Z��k@ڪ$�gT@��� �k@��� ��R@�n��Nl@��v��~T@:̗`�l@�Zd�V@�)��m@�Xl��S@��@�pm@��KS@!�'�>�m@t�V�S@�B�i�1n@��ʡE�S@f�2�}�n@����)�S@����n@���(@(T@�[='�So@lt�OqfT@M�»\�o@��E��T@x$(~
p@	�I���T@I�f��:p@�Ljh�U@i��kp@��+�U@��m�p@�C�l�U@��.Q��p@u ��V@�uq�p@ŭ��[V@_$��\,q@��:7m)Z@0����\q@�K7�A�X@�9z��q@�~���1W@�0|DL�q@�6�x͙W@�߾��q@���K5X@u���r@���tw�X@F=D�;Nr@�$A��X@�m�~r@     �Y@��7ۮr@Y�&�=[@�I+�r@W�Y�D`@                �I+�r@n���|Y@                        �I+�r@���BY@�l�Z@