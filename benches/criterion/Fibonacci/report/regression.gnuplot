set output 'output.plot'
set title 'Fibonacci'
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
��u�+N@Z��U���?��u�+N@��x�&q�?~SX��z!@x�q�@��u�+N'@��z]@�5�o�!-@�����@~SX��z1@���8[@�fd4@�:�э @��u�+N7@)\���8@=}��7:@0o��!@�5�o�!=@S ���#@3���@@j���%@~SX��zA@cD�в�'@ȯb��B@     �)@�fdD@�"��~�+@]h��H�E@���0(�-@��u�+NG@}?5^�i/@� =E�H@����k�0@=}��7J@���Ss�1@��˶ӬK@���K�2@�5�o�!M@�'Hlw�3@�Z(��N@Zd;߫4@3���P@f��e�5@Y��L/�P@Ӂ��Vw6@~SX��zQ@�A`��j7@��5R@4g}�1�8@ȯb��R@���9@�]����S@�i2�m�:@�fdT@�xyr;@8�Jw�U@]��'�<@]h��H�U@% &�BR=@�0��V@/��Q�d>@��u�+NW@�5�p?@�r��X@Z~�*O<@@� =E�X@)v4��@@Ϡ�}Y@^��W8A@=}��7Z@��4���A@b+hZb�Z@^��WBB@��˶Ӭ[@
dv��B@��/Eg\@@OIC@�5�o�!]@s�c���C@����'�]@�l���D@�Z(��^@�@�S��D@B@��
Q_@�z���D@3���`@ʡE��E@F��b`@\���?F@Y��L/�`@�����F@k|&�ga@�4�($G@~SX��za@���(@�G@�*�W��a@XƆn��G@��5b@��5&�H@����J�b@�����I@ȯb��b@��ʡEpI@ۆQ�Lc@Zd;�OJ@�]����c@yv�և�J@ 5�l-d@�t��J@�fdd@�ފ��K@&�ɞ�d@��il��K@8�Jw�e@ĭ��lL@K�|%|e@Z~�*OM@]h��H�e@��,
��M@p?���6f@������M@�0��f@R���[N@��C���f@���(@�N@��u�+Ng@=
ףpeO@���:d�g@�Y�rL�O@�r��h@;��HP@�I��eh@��,�tP@� =E�h@�|�R�P@�n�F i@+����P@Ϡ�}i@���(\8Q@*��O��i@T㥛ċQ@=}��7j@:����Q@PT6�)�j@���S��Q@b+hZb�j@{�G�*R@u��Ok@5^�IiR@��˶Ӭk@]¡��R@���d
l@��̰�R@��/Egl@�&l?.S@�^a�}�l@�~j�taS@�5�o�!m@b�*�3�S@���~m@�^f��S@����'�m@�t�T@
�(z`9n@�&1�^T@�Z(��n@[@h=|�T@/i����n@N�����T@B@��
Qo@��K|T@T�2C�o@�I+�T@3���p@�����T@��GZ4p@�&l?IU@F��bp@!=ExU@Ϲ����p@�(\���U@Y��L/�p@��0�:V@����p@�[��bV@k|&�gq@dȱ�oV@�g?RLq@�'d�m�V@~SX��zq@)�ahuW@?q =�q@b�*�3"W@�*�W��q@q75ЉW@��ur@�x�&1sW@��5r@=
ףp�W@                ��5r@�I�IX@                        ��5r@���?�1X@ɪ�xcX@