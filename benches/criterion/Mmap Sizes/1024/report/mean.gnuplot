set output 'output.plot'
set title 'Mmap Sizes/1024: mean'
set xtics nomirror 
set xlabel 'Average time (ps)'
set xrange [326.850917684073:328.8944859349655]
set ytics nomirror 
set ylabel 'Density (a.u.)'
set key on outside top right Left reverse 
set terminal svg dynamic dashed size 1280, 720 font 'Helvetica'
unset bars
plot '-' binary endian=little record=500 format='%float64' using 1:2 with lines lt 1 lw 2 lc rgb '#1f78b4' title 'Bootstrap distribution', '-' binary endian=little record=407 format='%float64' using 1:2:3 with filledcurves fillstyle solid 0.25 noborder lc rgb '#1f78b4' title 'Confidence interval', '-' binary endian=little record=2 format='%float64' using 1:2 with lines lt 2 lw 2 lc rgb '#1f78b4' title 'Point estimate'
��[�mt@��_5b�?#�"�mt@�┞�4�?^�b�mt@�w���
�?�����mt@c�h���?ӗ�t�mt@���L�_�?�+;�mt@��Jϰ?I�nnt@�>���?�?����nt@��ʖ��?���#nt@�0P|=$�?��7T4nt@�h����?4�zEnt@_蠀��?o���Unt@�K �Ҁ�?�� �fnt@����U��?�Cmwnt@��5�~l�?��3�nt@X�K�^�?Z����nt@�9b[�?����nt@ZȆ?�ӵ?��O��nt@X4Y��M�?ŒL�nt@���~ɶ?E���nt@���rG�?����nt@Y0��Ʒ?��[��nt@����I�?�ўeot@t�J�wϸ?1��+ot@��:�X�?k�$�/ot@�Lġ�?��g�@ot@%SxP�x�?�ު~Qot@3�&��?��Dbot@*o}�%��?W�0sot@8����M�?��sуot@���n��?�붗�ot@]�����?��]�ot@���U�?B�<$�ot@����?}���ot@�
_�Ϳ?��°�ot@���4�H�?��w�ot@H�7n���?-�H=�ot@�l�M��?h�
pt@;�-�~�?���pt@P��N��?��+pt@9�SX�?UV<pt@�y���?S�Mpt@��p��8�?���]pt@� |��?��npt@�k����?aopt@�H���?>�5�pt@ʹ�ڂ	�?y���pt@�M�;��?�"*±pt@�����?�%m��pt@�O�
p�?*)�N�pt@e\�	��?d,��pt@jT�þb�?�/6��pt@ɰ�,��?�2y�qt@����[X�?6�gqt@�}�X��?P9�-'qt@5��]2Q�?�<B�7qt@ӎ�����?�?��Hqt@���M�? CȀYqt@���%���?;FGjqt@�\O�?vIN{qt@��	����?�L�Ӌqt@���U�?�Oԙ�qt@��t�a��?&S`�qt@�o�N�b�?aVZ&�qt@��g���?�Y���qt@�70!kw�?�\��qt@j��f��?`#y�qt@�Ĳɀ��?Lcf?rt@�y�A�?�f�rt@��1~{]�?�i��"rt@�>m����?�l/�3rt@a)����?7prXDrt@�w.�C�?rs�Urt@v��G��?�v��ert@�����?�y;�vrt@?��W6�?#}~q�rt@�w��a��?^��7�rt@�����?����rt@�$��3�?ӆGĹrt@�'�HQ��?����rt@�%$���?I��P�rt@:�ĝ:�?���rt@�j����?��S��rt@pU#����?����st@��JفH�?4��ist@Ԡ#7}��?o�0/st@���}���?��_�?st@T�T�jZ�?䣢�Pst@ԇ�:��?��ast@�zL7�?Z�(Irst@�zkO]n�?��k�st@�)�n���?а�Փst@�7P6'�?
��st@{� ��?E�4b�st@g�ml��?��w(�st@t���>�?�����st@��bS���?�����st@���g��?1�@{�st@&X<��Z�?kǃA	tt@������?���tt@*��n�?��	�*tt@��+��}�?�L�;tt@�~^N���?WԏZLtt@^���D�?��� ]tt@��c�z��?���mtt@�P��?�X�~tt@Q�-�_u�?B�s�tt@MLWnN��?}��9�tt@�n�C�?��! �tt@�d'�d��?��d��tt@��_/1�?-�tt@$��p�z�?h��R�tt@��tFQ��?��-�tt@F[�t�$�?��p�ut@-�,g�W�?���ut@ڝir��?S��k&ut@FS�����?�:27ut@/NنC��?�}�Gut@�e�D�?��Xut@z�6ٝO�?>�iut@f�qJ�?yFKzut@�E�I��?���ut@�i{f���?��כut@��R
�?*��ut@�5�n7�?dRd�ut@1 ��d�?��*�ut@��h	��?�!���ut@���ϻ�?%��ut@+#~�0��?P(^} vt@�t�S�?�+�Cvt@D�#�I=�?�.�	"vt@V*f�'h�? 2'�2vt@�Y���?;5j�Cvt@����ܽ�?v8�\Tvt@�!z���?�;�"evt@E ���?�>3�uvt@�7�??�?&Bv��vt@$��ޅj�?aE�u�vt@9{�z��?�H�;�vt@Z	�����?�K?�vt@�g�/���?O���vt@�ݸ�?LRŎ�vt@`�(�RF�?�UU�vt@	35��r�?�XK�vt@*ٹ�Z��?�[��wt@Fm/`	��?7_ѧwt@~ ����?rbn.wt@Jz2Ϟ%�?�eW4?wt@����yR�?�h��Owt@e�,4W�?#l��`wt@k���/��?]o �qwt@�2�q���?�rcM�wt@V"� ��?�u��wt@ꨮE2�?y�٣wt@Z�=�^�?I|,��wt@)�1�؊�?�of�wt@0((3���?���,�wt@�o��9��?�����wt@�*RI�?4�8��wt@3�5[�7�?o�{xt@6Z���a�?���Ext@:����?�*xt@����d��?�D�:xt@���5���?Z���Kxt@��o��?���^\xt@��}B@'�?П%mxt@DU��K�?
�P�}xt@ˋ��eo�?E����xt@�(*�ۑ�?���w�xt@��ƃ?��?��>�xt@n-͘��?��\�xt@{.����?0����xt@�4ga�?k���xt@$���.�?��%W�xt@�a:V�K�?�hyt@�$� h�?���yt@��۬��?V��%yt@�U&��?��1p6yt@A����?��t6Gyt@�������?ͷ�Wyt@������?B���hyt@�(+M
�?}�=�yyt@���8%�?�րO�yt@;��U@�?����yt@=��x�[�?-�ܫyt@+���Ww�?h�I��yt@��v?J��?��h�yt@�4�W���?���.�yt@��&��?���yt@o�U���?S�U��yt@^&ۉ��?��zt@���"�?���G!zt@_�e@�?�2zt@��l�]�?>�a�Bzt@sw�%z�?y���Szt@���CΖ�?� �`dzt@o���4��?�+'uzt@�.$�-��?)n�zt@���h���?d
���zt@��Ny�?��y�zt@��J~��?�7@�zt@�,��9�?z�zt@S�֟Q�?P���zt@/��[i�?� ��zt@�Bu�3��?�CY�zt@v7u�!��? !�{t@[溹!��?;$��{t@S��*2��?v'�-{t@�(94R��?�*Or>{t@�5����?�-�8O{t@����?&1��_{t@��W��?a4�p{t@߽~�b�?�7[��{t@-$��#�?�:�Q�{t@t���1�?>��{t@�9��p=�?LA$޳{t@j�\��H�?�Dg��{t@*���R�?�G�j�{t@���e�[�?�J�0�{t@����mc�?7N0��{t@?�z��i�?rQs�|t@�8E��n�?�T��|t@O���r�?�W�I)|t@�`G��t�?#[<:|t@�K
�u�?]^�J|t@�/S��t�?�a[|t@�Դ�r�?�dcl|t@kl]wo�?hH)}|t@��C��j�?Ik��|t@X�֩d�?�nε�|t@����p]�?�q|�|t@![��U�?�tTB�|t@p,��K�?4x��|t@���A�?o{���|t@����|6�?�~��|t@�?
�*�?�`[}t@��2�5�?��!}t@(�m��?Z���$}t@��`Pt�?��)�5}t@��:��?ώltF}t@�vJ[r��?
��:W}t@���?E�� h}t@DQD��?��5�x}t@�{6x��?��x��}t@�Ұ��?���S�}t@�����?0���}t@>�����?k�A�}t@s���k�?�����}t@����V�?��l�}t@�g���@�?�
3�}t@j���)�?V�M��}t@uS��B�?����~t@���#���?̸Ӆ ~t@��{���?�L1~t@�)��;��?B�YB~t@ ��Q��?|�R~t@���u`��?��ߞc~t@���6|g�?��"et~t@��1�G�?-�e+�~t@���I>'�?hϨ�~t@���?��뷦~t@��zx��?��.~�~t@:��o��?�qD�~t@Tr0#��?Sܴ
�~t@��8-�}�?�����~t@URk�7[�?��:��~t@\Z�U�8�?�}]t@�� ��?>��#t@
��P���?y��,t@��{���?��F�=t@��N?���?��vNt@"��_��?)��<_t@@hC�Nq�?d�pt@D���Q�?��Rɀt@��q�2�?�����t@���v��?�U�t@:-��A��?O�t@Ԭf�X��?�	_��t@[7���?����t@�ɜR��? �n�t@��H��?;(5�t@vd��Vl�?vk��t@�^�~�Q�?����t@IJ��7�?��(�t@��ȕ��?& 4N9�t@���M��?a#wJ�t@�.�6���?�&��Z�t@ۥza��?�)��k�t@�E����?-@g|�t@_�tЛ��?L0�-��t@5/��}�?�3��t@^�ȍa�?�6	���t@�6�qD�?�9L���t@�a&�?7=�FЀt@�\��?r@��t@�;'C��?�C��t@`>X����?�FX��t@fsEY5��?"J�_�t@[����?]M�%$�t@a`Z0a�?�P!�4�t@�Y�}=�?�Sd�E�t@A��H�?W�xV�t@�D\a���?IZ�>g�t@
%��k��?�]-x�t@K=O~���?�`pˈ�t@�M�C��?�c����t@J@�5m^�?4g�W��t@V���8�?oj9��t@�d����?�m|�ˁt@A)�����?�p��܁t@�C)���?tq�t@��G~��?ZwE7��t@m�i|�?�z���t@�q���V�?�}���t@�2�=�1�?
��0�t@��?<��?E�QPA�t@����?���R�t@x&dP��?����b�t@�d���?���s�t@	�f�y�?0�]i��t@�lo-�T�?k��/��t@Bz���/�?������t@?��)�
�?�&���t@�y�����?�i�ǂt@qᮣ���?V��H؂t@j�(D���?����t@�5U8�p�?̧2���t@5'�m�H�?�u�
�t@��2 �?B��a�t@�,���?|��',�t@�Q����?��>�<�t@m�Ɨ֡�?򷁴M�t@����0v�?-��z^�t@V�.�I�?h�Ao�t@n� ���?��J��t@�9�]��?�č͐�t@�͉F���?�Г��t@�4��3��?S�Z��t@C��4c�?��V Ãt@�����3�?�љ�Ӄt@��ڪ�?�ܬ�t@̑��]��?>�s��t@�Q�5��?y�b9�t@97�Ow�?�ޥ��t@�5���H�?����'�t@��v���?)�+�8�t@��QJy��?d�nRI�t@�=f^�?��Z�t@�ѩ$p(�?����j�t@�r����?�7�{�t@�D��M|�?O�zk��t@~���(�?���1��t@��_#o��?�� ���t@c{�ׅ�? �C���t@����6�?;��τt@��X&��?u�J��t@�)�g��?��t@�D
R�?�P��t@F}l�g�?&���t@�!a���?a�c#�t@�N�ܤx�?�*4�t@P&��f2�?�\�D�t@ ���/��?��U�t@i5�b���?L�|f�t@B��µe�?�"%Cw�t@(�$e#�?�%h	��t@-�hR ��?�(�Ϙ�t@�s遡�?7,�t@��dm�a�?r/1\��t@��]#�?�2t"˅t@8�LU!��?�5��ۅt@ZA\��?"9���t@�0(^Ok�?]<=u��t@��M/�?�?�;�t@�.���?�B��t@~=P���?F�/�t@�^e��}�?HII�@�t@�[i/�B�?�L�TQ�t@$�zq��?�O�b�t@����@��?�R�r�t@�㉐�?4VU���t@��HFT�?nY�m��t@�3��T�?�\�3��t@�2R*���?�_���t@Y����?ca�Ɔt@b�6t�[�?Zf��׆t@J�,�?�i�L�t@�gϞ���?�l*��t@<&�Y��?
pm�	�t@����8T�?Es���t@���9\�?�v�e+�t@�������?�y6,<�t@����?�|y�L�t@��}�A�?0���]�t@*��vL��?k��~n�t@m�$��?��BE�t@J��q�?ቅ��t@;9�-�?��Ѡ�t@���)���?V����t@����H��?��N^t@S�o'�b�?̖�$Ӈt@A��E� �?����t@ᨻ�
��?A���t@9˱�`��?|�Zw�t@V����a�?���=�t@e��z$�?��'�t@6U�����?-�#�7�t@���xxZ�?h�f�H�t@%k����?���VY�t@/�mu�?ݳ�j�t@.�z�?�/�z�t@�G����?S�r���t@SI5LE,�?���o��t@S�v`��?���5��t@�tu�#Z�?�;���t@4Nt��?>�~�Έt@k�8��?y���߈t@&e�Y*�?��O��t@�{���?��G�t@3��df�?)Ԋ��t@�
��/�?d�͡"�t@za���?��h3�t@o�F�I�?��S.D�t@�T"��?��T�t@�Be�7��?O�ٺe�t@��d�T5�?���v�t@���-x��?��_G��t@.+p����? ���t@k$@�*�?;��Ө�t@�L� ��?u�(���t@8pus~�?��k`ʉt@Q����)�?���&ۉt@%��m��?&����t@��&1��?a5���t@���2�?�xy�t@8�RS���?��?�t@�����?�/�t@łjpF�?LA�?�t@=nݣ���?���P�t@�Zh��?��Xa�t@��jd%d�?�
r�t@a'���?7M傊t@{�\��?r����t@w�����?�!�q��t@�L�e�C�?�$8��t@*$X���?"(Y�Ŋt@E��溷�?]+��֊t@���$Ar�?�.ߊ�t@��I-�?�1"Q��t@\�da���?5e	�t@h_7Ǣ�?H8���t@a���]�?�;�*�t@���b�?�>.j;�t@A�/'��?�Aq0L�t@PNu�/�?4E��\�t@��0�9��?nH��m�t@�$�[�?�K:�~�t@ixo|�z�?�N}I��t@V\���?R���t@ZX�i�g�?ZUְ�t@�9m<a�?�XF���t@�i\��Z�?�[�bҋt@�p��ֺ?
_�(�t@(I�?�U�?Eb��t@/�n�O׹?�eR��t@��/\�?�h�{�t@�.�U��?�k�A&�t@K��np�?0o7�t@^�~ �?kr^�G�t@��Tz��?�u��X�t@�з2�*�?�x�Zi�t@u%`].Ŷ?|'!z�t@���=&c�?Vj犌t@6�
2�?������t@��`��?̅�s��t@��9R>N�?�3:��t@������?A�v Όt@�|���?|���ތt@�~��K�?�����t@��GBG��?�?S �t@�SPwi��?-���t@@W�S�?g���!�t@ sO�?���2�t@zk>4��?ݢKlC�t@���2�]�?��2T�t@��+��?S���d�t@
"fCl��?���u�t@�޿�"i�?ȯW���t@�p!�?��K��t@��Մǰ?>����t@&Y�!nw�?y� ظ�t@F����'�?��c�ɍt@m�=���?dڍt@��X��?)��*�t@8���h}�?d�,���t@E���?��o��t@�#�hP�?�̲}�t@���/��?��C.�t@�*��),�?O�8
?�t@屻[N��?��{�O�t@�	��?y���pt@�M�;��?        �"*±pt@�����?        �%m��pt@�O�
p�?        *)�N�pt@e\�	��?        d,��pt@jT�þb�?        �/6��pt@ɰ�,��?        �2y�qt@����[X�?        6�gqt@�}�X��?        P9�-'qt@5��]2Q�?        �<B�7qt@ӎ�����?        �?��Hqt@���M�?         CȀYqt@���%���?        ;FGjqt@�\O�?        vIN{qt@��	����?        �L�Ӌqt@���U�?        �Oԙ�qt@��t�a��?        &S`�qt@�o�N�b�?        aVZ&�qt@��g���?        �Y���qt@�70!kw�?        �\��qt@j��f��?        `#y�qt@�Ĳɀ��?        Lcf?rt@�y�A�?        �f�rt@��1~{]�?        �i��"rt@�>m����?        �l/�3rt@a)����?        7prXDrt@�w.�C�?        rs�Urt@v��G��?        �v��ert@�����?        �y;�vrt@?��W6�?        #}~q�rt@�w��a��?        ^��7�rt@�����?        ����rt@�$��3�?        ӆGĹrt@�'�HQ��?        ����rt@�%$���?        I��P�rt@:�ĝ:�?        ���rt@�j����?        ��S��rt@pU#����?        ����st@��JفH�?        4��ist@Ԡ#7}��?        o�0/st@���}���?        ��_�?st@T�T�jZ�?        䣢�Pst@ԇ�:��?        ��ast@�zL7�?        Z�(Irst@�zkO]n�?        ��k�st@�)�n���?        а�Փst@�7P6'�?        
��st@{� ��?        E�4b�st@g�ml��?        ��w(�st@t���>�?        �����st@��bS���?        �����st@���g��?        1�@{�st@&X<��Z�?        kǃA	tt@������?        ���tt@*��n�?        ��	�*tt@��+��}�?        �L�;tt@�~^N���?        WԏZLtt@^���D�?        ��� ]tt@��c�z��?        ���mtt@�P��?        �X�~tt@Q�-�_u�?        B�s�tt@MLWnN��?        }��9�tt@�n�C�?        ��! �tt@�d'�d��?        ��d��tt@��_/1�?        -�tt@$��p�z�?        h��R�tt@��tFQ��?        ��-�tt@F[�t�$�?        ��p�ut@-�,g�W�?        ���ut@ڝir��?        S��k&ut@FS�����?        �:27ut@/NنC��?        �}�Gut@�e�D�?        ��Xut@z�6ٝO�?        >�iut@f�qJ�?        yFKzut@�E�I��?        ���ut@�i{f���?        ��כut@��R
�?        *��ut@�5�n7�?        dRd�ut@1 ��d�?        ��*�ut@��h	��?        �!���ut@���ϻ�?        %��ut@+#~�0��?        P(^} vt@�t�S�?        �+�Cvt@D�#�I=�?        �.�	"vt@V*f�'h�?         2'�2vt@�Y���?        ;5j�Cvt@����ܽ�?        v8�\Tvt@�!z���?        �;�"evt@E ���?        �>3�uvt@�7�??�?        &Bv��vt@$��ޅj�?        aE�u�vt@9{�z��?        �H�;�vt@Z	�����?        �K?�vt@�g�/���?        O���vt@�ݸ�?        LRŎ�vt@`�(�RF�?        �UU�vt@	35��r�?        �XK�vt@*ٹ�Z��?        �[��wt@Fm/`	��?        7_ѧwt@~ ����?        rbn.wt@Jz2Ϟ%�?        �eW4?wt@����yR�?        �h��Owt@e�,4W�?        #l��`wt@k���/��?        ]o �qwt@�2�q���?        �rcM�wt@V"� ��?        �u��wt@ꨮE2�?        y�٣wt@Z�=�^�?        I|,��wt@)�1�؊�?        �of�wt@0((3���?        ���,�wt@�o��9��?        �����wt@�*RI�?        4�8��wt@3�5[�7�?        o�{xt@6Z���a�?        ���Ext@:����?        �*xt@����d��?        �D�:xt@���5���?        Z���Kxt@��o��?        ���^\xt@��}B@'�?        П%mxt@DU��K�?        
�P�}xt@ˋ��eo�?        E����xt@�(*�ۑ�?        ���w�xt@��ƃ?��?        ��>�xt@n-͘��?        ��\�xt@{.����?        0����xt@�4ga�?        k���xt@$���.�?        ��%W�xt@�a:V�K�?        �hyt@�$� h�?        ���yt@��۬��?        V��%yt@�U&��?        ��1p6yt@A����?        ��t6Gyt@�������?        ͷ�Wyt@������?        B���hyt@�(+M
�?        }�=�yyt@���8%�?        �րO�yt@;��U@�?        ����yt@=��x�[�?        -�ܫyt@+���Ww�?        h�I��yt@��v?J��?        ��h�yt@�4�W���?        ���.�yt@��&��?        ���yt@o�U���?        S�U��yt@^&ۉ��?        ��zt@���"�?        ���G!zt@_�e@�?        �2zt@��l�]�?        >�a�Bzt@sw�%z�?        y���Szt@���CΖ�?        � �`dzt@o���4��?        �+'uzt@�.$�-��?        )n�zt@���h���?        d
���zt@��Ny�?        ��y�zt@��J~��?        �7@�zt@�,��9�?        z�zt@S�֟Q�?        P���zt@/��[i�?        � ��zt@�Bu�3��?        �CY�zt@v7u�!��?         !�{t@[溹!��?        ;$��{t@S��*2��?        v'�-{t@�(94R��?        �*Or>{t@�5����?        �-�8O{t@����?        &1��_{t@��W��?        a4�p{t@߽~�b�?        �7[��{t@-$��#�?        �:�Q�{t@t���1�?        >��{t@�9��p=�?        LA$޳{t@j�\��H�?        �Dg��{t@*���R�?        �G�j�{t@���e�[�?        �J�0�{t@����mc�?        7N0��{t@?�z��i�?        rQs�|t@�8E��n�?        �T��|t@O���r�?        �W�I)|t@�`G��t�?        #[<:|t@�K
�u�?        ]^�J|t@�/S��t�?        �a[|t@�Դ�r�?        �dcl|t@kl]wo�?        hH)}|t@��C��j�?        Ik��|t@X�֩d�?        �nε�|t@����p]�?        �q|�|t@![��U�?        �tTB�|t@p,��K�?        4x��|t@���A�?        o{���|t@����|6�?        �~��|t@�?
�*�?        �`[}t@��2�5�?        ��!}t@(�m��?        Z���$}t@��`Pt�?        ��)�5}t@��:��?        ώltF}t@�vJ[r��?        
��:W}t@���?        E�� h}t@DQD��?        ��5�x}t@�{6x��?        ��x��}t@�Ұ��?        ���S�}t@�����?        0���}t@>�����?        k�A�}t@s���k�?        �����}t@����V�?        ��l�}t@�g���@�?        �
3�}t@j���)�?        V�M��}t@uS��B�?        ����~t@���#���?        ̸Ӆ ~t@��{���?        �L1~t@�)��;��?        B�YB~t@ ��Q��?        |�R~t@���u`��?        ��ߞc~t@���6|g�?        ��"et~t@��1�G�?        -�e+�~t@���I>'�?        hϨ�~t@���?        ��뷦~t@��zx��?        ��.~�~t@:��o��?        �qD�~t@Tr0#��?        Sܴ
�~t@��8-�}�?        �����~t@URk�7[�?        ��:��~t@\Z�U�8�?        �}]t@�� ��?        >��#t@
��P���?        y��,t@��{���?        ��F�=t@��N?���?        ��vNt@"��_��?        )��<_t@@hC�Nq�?        d�pt@D���Q�?        ��Rɀt@��q�2�?        �����t@���v��?        �U�t@:-��A��?        O�t@Ԭf�X��?        �	_��t@[7���?        ����t@�ɜR��?         �n�t@��H��?        ;(5�t@vd��Vl�?        vk��t@�^�~�Q�?        ����t@IJ��7�?        ��(�t@��ȕ��?        & 4N9�t@���M��?        a#wJ�t@�.�6���?        �&��Z�t@ۥza��?        �)��k�t@�E����?        -@g|�t@_�tЛ��?        L0�-��t@5/��}�?        �3��t@^�ȍa�?        �6	���t@�6�qD�?        �9L���t@�a&�?        7=�FЀt@�\��?        r@��t@�;'C��?        �C��t@`>X����?        �FX��t@fsEY5��?        "J�_�t@[����?        ]M�%$�t@a`Z0a�?        �P!�4�t@�Y�}=�?        �Sd�E�t@A��H�?        W�xV�t@�D\a���?        IZ�>g�t@
%��k��?        �]-x�t@K=O~���?        �`pˈ�t@�M�C��?        �c����t@J@�5m^�?        4g�W��t@V���8�?        oj9��t@�d����?        �m|�ˁt@A)�����?        �p��܁t@�C)���?        tq�t@��G~��?        ZwE7��t@m�i|�?        �z���t@�q���V�?        �}���t@�2�=�1�?        
��0�t@��?<��?        E�QPA�t@����?        ���R�t@x&dP��?        ����b�t@�d���?        ���s�t@	�f�y�?        0�]i��t@�lo-�T�?        k��/��t@Bz���/�?        ������t@?��)�
�?        �&���t@�y�����?        �i�ǂt@qᮣ���?        V��H؂t@j�(D���?        ����t@�5U8�p�?        ̧2���t@5'�m�H�?        �u�
�t@��2 �?        B��a�t@�,���?        |��',�t@�Q����?        ��>�<�t@m�Ɨ֡�?        򷁴M�t@����0v�?        -��z^�t@V�.�I�?        h�Ao�t@n� ���?        ��J��t@�9�]��?        �č͐�t@�͉F���?        �Г��t@�4��3��?        S�Z��t@C��4c�?        ��V Ãt@�����3�?        �љ�Ӄt@��ڪ�?        �ܬ�t@̑��]��?        >�s��t@�Q�5��?        y�b9�t@97�Ow�?        �ޥ��t@�5���H�?        ����'�t@��v���?        )�+�8�t@��QJy��?        d�nRI�t@�=f^�?        ��Z�t@�ѩ$p(�?        ����j�t@�r����?        �7�{�t@�D��M|�?        O�zk��t@~���(�?        ���1��t@��_#o��?        �� ���t@c{�ׅ�?         �C���t@����6�?        ;��τt@��X&��?        u�J��t@�)�g��?        ��t@�D
R�?        �P��t@F}l�g�?        &���t@�!a���?        a�c#�t@�N�ܤx�?        �*4�t@P&��f2�?        �\�D�t@ ���/��?        ��U�t@i5�b���?        L�|f�t@B��µe�?        �"%Cw�t@(�$e#�?        �%h	��t@-�hR ��?        �(�Ϙ�t@�s遡�?        7,�t@��dm�a�?        r/1\��t@��]#�?        �2t"˅t@8�LU!��?        �5��ۅt@ZA\��?        "9���t@�0(^Ok�?        ]<=u��t@��M/�?        �?�;�t@�.���?        �B��t@~=P���?        F�/�t@�^e��}�?        HII�@�t@�[i/�B�?        �L�TQ�t@$�zq��?        �O�b�t@����@��?        �R�r�t@�㉐�?        4VU���t@��HFT�?        nY�m��t@�3��T�?        �\�3��t@�2R*���?        �_���t@Y����?        ca�Ɔt@b�6t�[�?        Zf��׆t@J�,�?        �i�L�t@�gϞ���?        �l*��t@<&�Y��?        
pm�	�t@����8T�?        Es���t@���9\�?        �v�e+�t@�������?        �y6,<�t@����?        �|y�L�t@��}�A�?        0���]�t@*��vL��?        k��~n�t@m�$��?        ��BE�t@J��q�?        ቅ��t@;9�-�?        ��Ѡ�t@���)���?        V����t@����H��?        ��N^t@S�o'�b�?        ̖�$Ӈt@A��E� �?        ����t@ᨻ�
��?        A���t@9˱�`��?        |�Zw�t@V����a�?        ���=�t@e��z$�?        ��'�t@6U�����?        -�#�7�t@���xxZ�?        h�f�H�t@%k����?        ���VY�t@/�mu�?        ݳ�j�t@.�z�?        �/�z�t@�G����?        S�r���t@SI5LE,�?        ���o��t@S�v`��?        ���5��t@�tu�#Z�?        �;���t@4Nt��?        >�~�Έt@k�8��?        y���߈t@&e�Y*�?        ��O��t@�{���?        ��G�t@3��df�?        )Ԋ��t@�
��/�?        d�͡"�t@za���?        ��h3�t@o�F�I�?        ��S.D�t@�T"��?        ��T�t@�Be�7��?        O�ٺe�t@��d�T5�?        ���v�t@���-x��?        ��_G��t@.+p����?         ���t@k$@�*�?        ;��Ө�t@�L� ��?        u�(���t@8pus~�?        ��k`ʉt@Q����)�?        ���&ۉt@%��m��?        &����t@��&1��?        a5���t@���2�?        �xy�t@8�RS���?        ��?�t@�����?        �/�t@łjpF�?        LA�?�t@=nݣ���?        ���P�t@�Zh��?        ��Xa�t@��jd%d�?        �
r�t@a'���?        7M傊t@{�\��?        r����t@w�����?        �!�q��t@�L�e�C�?        �$8��t@*$X���?        "(Y�Ŋt@E��溷�?        ]+��֊t@���$Ar�?        �.ߊ�t@��I-�?        �1"Q��t@\�da���?        5e	�t@h_7Ǣ�?        H8���t@a���]�?        �;�*�t@���b�?        �>.j;�t@A�/'��?        �4s#}t@        �4s#}t@� ���?