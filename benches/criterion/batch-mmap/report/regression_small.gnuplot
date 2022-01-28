set output 'output.plot'
set xtics nomirror 
set xlabel 'Iterations (x 10^3)'
set grid xtics
set ytics nomirror 
set ylabel 'Total sample time (ms)'
set grid ytics
set key off
set terminal svg dynamic dashed size 450, 300 font 'Helvetica'
unset bars
plot '-' binary endian=little record=100 format='%float64' using 1:2 with points lt 1 lc rgb '#1f78b4' pt 7 ps 0.5 title 'Sample', '-' binary endian=little record=2 format='%float64' using 1:2 with lines lt 1 lw 2 lc rgb '#1f78b4' title 'Linear regression', '-' binary endian=little record=2 format='%float64' using 1:2:3 with filledcurves fillstyle solid 0.25 noborder lc rgb '#1f78b4' title 'Confidence interval'
�I+��?^�I��?�I+��?��Q�@L7�A`�?r���,@�I+��?,,���@)\���(�?����V!@L7�A`�?�����%@��ʡE��?�W<�HK(@�I+��?bX9��)@��MbX�?� �rh�,@)\���(�?�y ���/@`��"���?�g\Wh1@L7�A`��?4g}�1U3@�����M�?I+��4@��ʡE��?��d��.6@��Q��?��ݯ�7@�I+��?׽�	F9@V-����?�mr�H;@��MbX�?��>�=@��n���?R���m>@)\���(�?}?5^��?@� �rh��?���x�@@`��"���?+�?H@��x�&1�?��.��B@L7�A`��?�f��gC@�������?-�B;��D@�����M�?bX9�nE@5^�I�?�a���I@��ʡE��?�(\�Bk@�"��~j�?}�:Q@��Q��?f�8�H@m������?J&�v��I@�I+��?-���pK@�Zd;�?d;�O��L@V-����?�4�($�L@�p=
ף�?qW�"��M@��MbX�?p�x��N@@5^�I�?V-8P@��n���?mt�Oq�P@��~j�t�?^G���P@)\���(�?�R��FzQ@w��/��?���cHR@� �rh��?h�
�R@��ʡE�?��ʅ;S@`��"���?��Co�S@�G�z��?�%9`W"T@��x�&1�?5^�I�T@%��C��?Y�&�YV@L7�A`��?-���V@sh��|?�?A`��"�V@�������?����)/W@�ʡE���?wKr���W@�����M�?3�ٲgX@-����?��]gX@5^�I�?�ʡE�iX@\���(\�?l����Y@��ʡE��?k���D�Y@���Mb�?
dv�\Z@�"��~j�?l����J[@�S㥛��?	�I��}[@��Q��?6:�8^^@F����x�?�� �r�\@m������?��]@�V-�?S�K�"^@�I+��?�$���^@�z�G��?Pj��_@�Zd;�?rh���(`@/�$���?���n�`@V-����?	3�z�`@}?5^�I�?��C<a@�p=
ף�?�y�a@ˡE����?� �rh�a@��MbX�?�qp�^b@V-��?��ʓ�b@@5^�I�?5^�IIc@gfffff�?aS�Q�c@��n���?fffff�c@��v���?��E�Ud@��~j�t�?5^�I�d@+����?���GS&e@)\���(�?C�l�{�e@P��n��?��zM f@w��/��?�'d�m�f@���K7�?�w�~\g@� �rh��?�����Fg@�Q����?X9����h@��ʡE�?�ej<"i@:��v���?	��7i@`��"���?�ի��i@����S�?!��ƽVn@�G�z��?���Lj@k�t��?'1��k@��x�&1�?L��pv�k@��|?5^�?��C��k@%��C��?߽�Ƅak@���Q��?ffff�0l@L7�A`��?X9��v�l@�O��n�?�v��m@sh��|?�?J�.�3�m@��C�l�?�Z��Hn@�������?Dg�E�o@                �������?;�҅k@                        �������?��K�[1j@�{�o�k@