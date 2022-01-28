set output 'output.plot'
set title 'Mmap Sizes/1024: slope'
set xtics nomirror 
set xlabel 'Average time (ps)'
set xrange [326.4343760868752:328.08546525387555]
set ytics nomirror 
set ylabel 'Density (a.u.)'
set key on outside top right Left reverse 
set terminal svg dynamic dashed size 1280, 720 font 'Helvetica'
unset bars
plot '-' binary endian=little record=500 format='%float64' using 1:2 with lines lt 1 lw 2 lc rgb '#1f78b4' title 'Bootstrap distribution', '-' binary endian=little record=407 format='%float64' using 1:2:3 with filledcurves fillstyle solid 0.25 noborder lc rgb '#1f78b4' title 'Confidence interval', '-' binary endian=little record=2 format='%float64' using 1:2 with lines lt 2 lw 2 lc rgb '#1f78b4' title 'Point estimate'
��V4�ft@�lA��?Y�� gt@����"�?�=cOgt@R������?�b��gt@J�=hZ��?L�oj)gt@f�Xn�?���6gt@�;�J�?��{�Dgt@�K�<W�?@�Rgt@�}P�д?���_gt@��L��K�?�>.mgt@��0��ʵ?4c��zgt@���M�?ۇI�gt@��,�Ҷ?���֕gt@B�i�[�?(�&d�gt@�K����?����gt@�ǣ��w�?u3�gt@0�j��
�??��gt@�2�t��?�c?��gt@;�u��;�?i��'�gt@�`�؇ٺ?�K��gt@X<�{�?���Bht@�T �?]�W�ht@L�[*�ɼ?�]ht@�����v�?�?d�*ht@Z]s�%(�?Pd�x8ht@��R�ݾ?��pFht@���S��?����Sht@mh֐�+�?D�|!aht@�}�`ƍ�?���nht@!`
_��?��<|ht@H<)��Y�?8@ʉht@ 0�zx��?�d�W�ht@��+
0�?���ht@ij�QI��?,��r�ht@s�ׄ+�?��' �ht@ܬ;띅�?y����ht@M��^���? 4�ht@�oa�u�?�@���ht@�ܱ\!��?me@6�ht@�=Ũ}n�?���it@OMu����?��LQit@�DD�Yn�?a���it@BWt8s��?�Xl,it@�Byb�s�?���9it@��L���?TAe�Git@ʙ�#<}�?�e�Uit@mک-�?��q�bit@I���ˉ�?H��/pit@o
�?��}�}it@�8/A��?��K�it@��bZ!�?<�ؘit@E�0x��?�Af�it@ᜄ�I4�?�f��it@�@߾�?0���it@9԰�GJ�?֯��it@ʑ����?}�(��it@��n�c�?$��)�it@5*�����?�5��it@�B���?qB�Djt@��Ԝ��?gA�jt@DdQ�?���_ jt@�uT5��?e�M�-jt@��'D2��?��z;jt@��m�,�?��YIjt@w;�v�?X��Vjt@�ڟ����?�Bf#djt@^sO��
�?�g�qjt@|I	�`U�?L�r>jt@���-���?��ˌjt@0���?��~Y�jt@�b��5�?@��jt@�9�̀�?��t�jt@D�9�M��?�C�jt@���-;�?4h���jt@��=�d�?ڌ�jt@��tܱ�?�����jt@ų�����?(�)8�jt@8��$�N�?����kt@��o���?u6Skt@0�7���?D��!kt@��BS}C�?�hBn/kt@@��@ ��?i���<kt@o\IE���?�N�Jkt@�.e��F�?���Xkt@��A4��?]�Z�ekt@\$���? �1skt@�/�"\�?�Dg��kt@���xͼ�?Pi�L�kt@��M��?��sڛkt@R��|��?���g�kt@�K4qd��?D���kt@�b�9T�?����kt@���ݾ�?� ��kt@b��*+�?8E��kt@�?*!���?�i�+�kt@t����?����kt@�=��Qx�?,��Flt@���y��?��*�lt@����X[�?y��a#lt@�І���? !7�0lt@�g@�?�E�|>lt@3N1��?mjC
Llt@�yM:�%�?�ɗYlt@8�e��?��O%glt@m�@A�?a�ղtlt@�{��>�?�[@�lt@ ���v�?�!�͏lt@Ti���?TFh[�lt@�n�{���?�j��lt@!� ��?��tv�lt@�Gu'U�?H���lt@^T�)��?�؀��lt@A+J�W��?���lt@����z��?<"���lt@V-��[.�?�F:�lt@e��[d�?�k��	mt@'I���?0�Umt@J�.z���?ִ��$mt@!��7�?}�+p2mt@�WPD�9�?$���?mt@��0��n�?�"8�Mmt@Ca 3��?qG�[mt@����?lD�hmt@�qU�M�?���3vmt@�Y8�E�?e�P��mt@���	{�?��N�mt@v�B.��?��\ܞmt@�����?X#�i�mt@'g��?�Gi��mt@ֆ2�T�?�l��mt@�E�����?L�u�mt@������?����mt@%�����?�ځ-�mt@ɻн�0�?@���mt@��AMh�?�#�Hnt@�2Ⱥ��?�H�nt@;D��?��?4m�c&nt@>��.��?ڑ �3nt@��U<�F�?���~Ant@O�~�?(�,Ont@LO�㚶�?����\nt@}o���?u$9'jnt@@X�p�'�?I��wnt@�.��`�?�mEB�nt@+	,(��?i��ϒnt@�і�)��?�Q]�nt@ώ`ս�?����nt@�V���I�?\ ^x�nt@��	9ǅ�?%��nt@e���F��?�Ij��nt@���Hj��?Pn� �nt@�&<�'=�?��v��nt@�8{�m{�?���;�nt@���#��?D܂�ot@6��*��?� 	Wot@WT�Y\8�?�%��'ot@E"��w�?8Jr5ot@�QUx���?�n��Bot@m/�=1��?��!�Pot@`y��<3�?,��^ot@i+:�~p�?��-�kot@d���Ŭ�?y�5yot@0&)����?&:Æot@J�K�!�?�J�P�ot@�%��Y�?moFޡot@R�w���?��k�ot@���O���?��R��ot@�Z4����?`�؆�ot@��R�*�?_�ot@�<'�BZ�?�&��ot@�i��I��?TKk/�ot@K>�0���?�o� pt@c�k��?��wJpt@���P��?H���pt@��勧0�?�݃e)pt@����]W�?�
�6pt@�qp�|�?<'��Dpt@�W뫡�?�KRpt@Ҥ�؊��?�p��_pt@��н���?0�")mpt@u�;���?ֹ��zpt@�%����?}�.D�pt@�ef�'�?#�ѕpt@[�G�8�?�';_�pt@<��*3I�?qL��pt@`���Y�?qGz�pt@�/,^j�?����pt@�Bfz�z�?d�S��pt@��R��?��"�pt@3��T���?�`��pt@v?�t��?X(�=qt@^�@�T��?�Ll�qt@�4�ͅ��?�q�Xqt@�Nƞ��?L�x�*qt@'���?��s8qt@�t.|��?�߄Fqt@!淣:�?@�Sqt@d��g��?�(�aqt@SL-J+�?�M�nqt@���֖:�?4r�7|qt@[�4W�I�?ږ#ŉqt@���X�?���R�qt@�q�wg�?'�/�qt@�O��v�?��m�qt@���m��?u)<��qt@�Ec ���?N�qt@�H�'~��?�rH�qt@a���"��?h�Σ�qt@�8[|��?�T1�qt@A��C���?��ھrt@<�2/��?\aLrt@�r�x��?*��rt@�f�GV��?�Nmg,rt@�I���?Ps��9rt@�Z�F��?��y�Grt@�M^��?���Urt@�����?Dᅝbrt@o�R!�?�+prt@f���*�?�*��}rt@4.��G2�?8OF�rt@c�3�9�?�s�Әrt@\m�M�@�?��$a�rt@w3�gG�?+���rt@�InDQM�?��0|�rt@=6J�R�?y�	�rt@��̈́W�?+=��rt@���S�[�?�O�$�rt@��2�_�?ltI��rt@�ݹ��b�?��?st@"f��e�?��U�st@4CQZ1h�?`��Z st@y���j�?b�-st@=8��k�?�+�u;st@��(sl�?TPnIst@����l�?�t��Vst@Q���l�?��zdst@tk2�Bl�?H� �qst@�*|$k�?��9st@D��mxi�?�ǌst@�lb�:g�?<,�T�st@A� �gd�?�P�st@MD|�`�?�u�o�st@��v�\�?/�%��st@�s�iX�?־���st@��CS�?}�1�st@#�4��M�?#���st@_r��aG�?�,>3�st@�b�j�@�?pQ��tt@��)�9�?vJNtt@��<2�?����!tt@�����*�?d�Vi/tt@�D�?�"�?���<tt@������?�c�Jtt@Ǿ4EZ�?X-�Xtt@u}�/'
�?�Qo�ett@F1��?�v�,stt@���5���?L�{��tt@��"����?�H�tt@���,���?��՛tt@ � ��?@	c�tt@��?9��?�-��tt@vE��t��?�R~�tt@`�_����?4w��tt@�)�����?ڛ&��tt@�)=r���?���&�tt@�@E\��?'�2��tt@K����?�	�Aut@�S7����?u.?�ut@'����?S�\#ut@vߨ9���?�wK�0ut@`�B����?h��w>ut@��X�v�?�WLut@Y]��i�?��ݒYut@²=�I\�?\
d gut@#�W�6N�?/�tut@$V�V?�?�Sp;�ut@]:��/�?Px�ȏut@ҔL�?��|V�ut@?-�Q:�?���ut@�B���?D�q�ut@�S/�P��?�
��ut@�rצ���?�/���ut@��Vv���?8T�ut@=�e+��?�x���ut@�E%ŏ��?��'5�ut@���Cˉ�?+­�	vt@]�h�u�?��3Pvt@���-b�?y��$vt@����N�?0@k2vt@���=/:�?�T��?vt@H���P&�?lyL�Mvt@�l�r}�?��[vt@u! �f��?��X�hvt@f�z���?`��.vvt@�D"Z��?e��vt@��JɆ�?�0�I�vt@f���_�?TUqמvt@�R��G7�?�y�d�vt@Bn�45�?��}�vt@���,���?H���vt@7�}���?���vt@�����?���vt@2-�Tk�?<1�(�vt@�GK2A�?�U��vt@q�=��?�z�Cwt@��b�<��?/�(�wt@ϡ�\��?�î^&wt@��/0ے�?}�4�3wt@�h��e�?#�yAwt@P�.�7�?�1AOwt@&�-�	�?pVǔ\wt@��c�l��?{M"jwt@�w��?��ӯwwt@�� az�?d�Y=�wt@��m�nI�?��ʒwt@�C����?�fX�wt@q~����?X2��wt@ �n���?�Vrs�wt@J+qf��?�{� �wt@�g�'L�?L�~��wt@�p����?���wt@�%S�0��?�銩�wt@��p���?@7�wt@��YKJx�?�2��xt@+���B�?�WRxt@g�OTt�?3|��'xt@�v��J��?ڠ)m5xt@h4a���?�ů�Bxt@�n�Pid�?'�5�Pxt@-����+�?��^xt@�׭b��?t3B�kxt@�Y�K���?X�0yxt@ � 5~�?�|N��xt@��k[C�?h��K�xt@�C%��?�Z١xt@3ߒLZ��?���f�xt@7�כX��?\g��xt@d[(g!T�?4��xt@����?�Xs�xt@G��$���?P}���xt@���G{��?��*�xt@L��W�c�?��� yt@���(�?D�Eyt@ξ�v���?��yt@�Xp��?�4�`)yt@��]Q7{�?7Y�6yt@� �]C�?�}�{Dyt@0Om���?��*	Ryt@|B���?+ǰ�_yt@S�6ľ��?��6$myt@�]z�o�?x��zyt@�4��=�?5C?�yt@�t����?�Y�̕yt@�b���?l~OZ�yt@X�����?���yt@K����?��[u�yt@��vR�?`���yt@�|P�k%�?h��yt@�1���?�5��yt@�@f���?TZt��yt@B�3=���?�~�8zt@]��r�?����zt@5����E�?H�Tzt@����?���*zt@"04'���?�o8zt@���]���?;6��Ezt@�����?�Z�Szt@.ސY�^�?��azt@���|/�?/�+�nzt@W�m_���?�ȱ2|zt@����l��?|�7��zt@ySt���?#�M�zt@~c��n�?�6Dۤzt@�V���=�?p[�h�zt@QE<g��?�P��zt@%��}��?��փ�zt@
���Z�?d�\�zt@ 1��J��?���zt@������?�i,�zt@F�b�?�?X7�{t@�1qX���?�[uG{t@�RZ ���?����{t@���q/�?L��b,{t@�ᥨ���?���9{t@Huߡ�?��}G{t@Z��)�??U{t@��>�P��?�7��b{t@Lͽ[��?�\ &p{t@�+&��/�?3���}{t@8�ɜ<��?ڥ,A�{t@���y���?�ʲΘ{t@�K�r>�?'�8\�{t@������?���{t@t��dX��?t8Ew�{t@�Ux.R�?]��{t@�Q�?��Q��{t@��Nԥ��?h���{t@h�Hi�?�]��{t@�����?���:|t@7;~���?\j�|t@�
/��?9�U |t@f�{I2�?�]v�-|t@?!�@1��?P��p;|t@0�4��?����H|t@v��R\G�?���V|t@q"ˣ��?C��d|t@�p�����?��q|t@��Y�Z�?�9�4|t@v_	B��?7^!|t@4�˴���?ނ�O�|t@n�I��m�?��-ݧ|t@{�	3�?+̳j�|t@wԱ��?��9��|t@ �"ǂ�?x���|t@X��>n5�?:F�|t@|l����?�^̠�|t@2Y�&��?l�R.�|t@���
R�?�ػ}t@ f81�?��^I}t@#Z`�~��?`���!}t@����
x�?kd/}t@V��1�?�:��<}t@n���,��?T_wJ}t@Ca0�ީ�?���X}t@:�h�?����e}t@G1�ʫ'�?H�	(s}t@�8�ɒ��?�񏵀}t@iɱ6�V�?�C�}t@��7���?;;�Л}t@_�ni�?�_"^�}t@�v����?����}t@S������?/�.y�}t@�����?�ʹ�}t@>���O��?|�:��}t@�s��C�?#�!�}t@d�,4��?�;G��}t@xjhtav�?p`�<~t@k3��3�?�S�~t@&��ڌ��?���W#~t@HAQN�?d�_�0~t@S�pUh��?��r>~t@Z�»��?�l L~t@b�62�?X<�Y~t@�v&���?�`xg~t@�]]�Uz�?����t~t@��T��?L��6�~t@�-;�%��?��
ď~t@A>9m�?��Q�~t@Z����??ߪ~t@�_�G7��?�<�l�~t@�v��e�?�a#��~t@�S0��?3����~t@F�G��?ڪ/�~t@�4":Ia�?�ϵ��~t@��k
�?'�;0�~t@�;\��?�½	t@E����[�?t=HKt@�Ae�<�?b��$t@�wq���?��Tf2t@hzceJS�?h���?t@���	��?�`�Mt@(���D��?���[t@Ϡ��F�?\m�ht@#G�?_��?>�)vt@��%j��?�by��t@?;G5�?P��D�t@�e���?���Ҟt@�$��?��`�t@��Zh$�?C����t@�,�Ʌ��?�{�t@�í��?�>��t@"y�0�0�?7c$��t@����V��?އ�#�t@�G�ּ?��0��t@��5]�-�?+Ѷ>�t@�f�aш�?��<��t@����}�?x�Y&�t@i�<J�??I�3�t@��j&G��?�c�tA�t@}	���?l�UO�t@���ߌ�?�ۏ\�t@���b��?��aj�t@goNM{�?`��w�t@xf��?n8��t@\��"�{�?�?�Œ�t@E�����?TdzS��t@?��?X��?�� ᭀt@o}���?���n��t@��X���?G��Ȁt@b`II�?����րt@$x��{�?��t@W��� ��?;@���t@M,%�?�d%2��t@����ɲ?�����t@���:�q�?/�1M�t@$s!�?�ҷ�'�t@�ǟ��ȱ?|�=h5�t@<��6x�?#��B�t@�'�wI)�?�@J�P�t@�sXܰ?pe�^�t@�gD��?��q�bit@I���ˉ�?        H��/pit@o
�?        ��}�}it@�8/A��?        ��K�it@��bZ!�?        <�ؘit@E�0x��?        �Af�it@ᜄ�I4�?        �f��it@�@߾�?        0���it@9԰�GJ�?        ֯��it@ʑ����?        }�(��it@��n�c�?        $��)�it@5*�����?        �5��it@�B���?        qB�Djt@��Ԝ��?        gA�jt@DdQ�?        ���_ jt@�uT5��?        e�M�-jt@��'D2��?        ��z;jt@��m�,�?        ��YIjt@w;�v�?        X��Vjt@�ڟ����?        �Bf#djt@^sO��
�?        �g�qjt@|I	�`U�?        L�r>jt@���-���?        ��ˌjt@0���?        ��~Y�jt@�b��5�?        @��jt@�9�̀�?        ��t�jt@D�9�M��?        �C�jt@���-;�?        4h���jt@��=�d�?        ڌ�jt@��tܱ�?        �����jt@ų�����?        (�)8�jt@8��$�N�?        ����kt@��o���?        u6Skt@0�7���?        D��!kt@��BS}C�?        �hBn/kt@@��@ ��?        i���<kt@o\IE���?        �N�Jkt@�.e��F�?        ���Xkt@��A4��?        ]�Z�ekt@\$���?         �1skt@�/�"\�?        �Dg��kt@���xͼ�?        Pi�L�kt@��M��?        ��sڛkt@R��|��?        ���g�kt@�K4qd��?        D���kt@�b�9T�?        ����kt@���ݾ�?        � ��kt@b��*+�?        8E��kt@�?*!���?        �i�+�kt@t����?        ����kt@�=��Qx�?        ,��Flt@���y��?        ��*�lt@����X[�?        y��a#lt@�І���?         !7�0lt@�g@�?        �E�|>lt@3N1��?        mjC
Llt@�yM:�%�?        �ɗYlt@8�e��?        ��O%glt@m�@A�?        a�ղtlt@�{��>�?        �[@�lt@ ���v�?        �!�͏lt@Ti���?        TFh[�lt@�n�{���?        �j��lt@!� ��?        ��tv�lt@�Gu'U�?        H���lt@^T�)��?        �؀��lt@A+J�W��?        ���lt@����z��?        <"���lt@V-��[.�?        �F:�lt@e��[d�?        �k��	mt@'I���?        0�Umt@J�.z���?        ִ��$mt@!��7�?        }�+p2mt@�WPD�9�?        $���?mt@��0��n�?        �"8�Mmt@Ca 3��?        qG�[mt@����?        lD�hmt@�qU�M�?        ���3vmt@�Y8�E�?        e�P��mt@���	{�?        ��N�mt@v�B.��?        ��\ܞmt@�����?        X#�i�mt@'g��?        �Gi��mt@ֆ2�T�?        �l��mt@�E�����?        L�u�mt@������?        ����mt@%�����?        �ځ-�mt@ɻн�0�?        @���mt@��AMh�?        �#�Hnt@�2Ⱥ��?        �H�nt@;D��?��?        4m�c&nt@>��.��?        ڑ �3nt@��U<�F�?        ���~Ant@O�~�?        (�,Ont@LO�㚶�?        ����\nt@}o���?        u$9'jnt@@X�p�'�?        I��wnt@�.��`�?        �mEB�nt@+	,(��?        i��ϒnt@�і�)��?        �Q]�nt@ώ`ս�?        ����nt@�V���I�?        \ ^x�nt@��	9ǅ�?        %��nt@e���F��?        �Ij��nt@���Hj��?        Pn� �nt@�&<�'=�?        ��v��nt@�8{�m{�?        ���;�nt@���#��?        D܂�ot@6��*��?        � 	Wot@WT�Y\8�?        �%��'ot@E"��w�?        8Jr5ot@�QUx���?        �n��Bot@m/�=1��?        ��!�Pot@`y��<3�?        ,��^ot@i+:�~p�?        ��-�kot@d���Ŭ�?        y�5yot@0&)����?        &:Æot@J�K�!�?        �J�P�ot@�%��Y�?        moFޡot@R�w���?        ��k�ot@���O���?        ��R��ot@�Z4����?        `�؆�ot@��R�*�?        _�ot@�<'�BZ�?        �&��ot@�i��I��?        TKk/�ot@K>�0���?        �o� pt@c�k��?        ��wJpt@���P��?        H���pt@��勧0�?        �݃e)pt@����]W�?        �
�6pt@�qp�|�?        <'��Dpt@�W뫡�?        �KRpt@Ҥ�؊��?        �p��_pt@��н���?        0�")mpt@u�;���?        ֹ��zpt@�%����?        }�.D�pt@�ef�'�?        #�ѕpt@[�G�8�?        �';_�pt@<��*3I�?        qL��pt@`���Y�?        qGz�pt@�/,^j�?        ����pt@�Bfz�z�?        d�S��pt@��R��?        ��"�pt@3��T���?        �`��pt@v?�t��?        X(�=qt@^�@�T��?        �Ll�qt@�4�ͅ��?        �q�Xqt@�Nƞ��?        L�x�*qt@'���?        ��s8qt@�t.|��?        �߄Fqt@!淣:�?        @�Sqt@d��g��?        �(�aqt@SL-J+�?        �M�nqt@���֖:�?        4r�7|qt@[�4W�I�?        ږ#ŉqt@���X�?        ���R�qt@�q�wg�?        '�/�qt@�O��v�?        ��m�qt@���m��?        u)<��qt@�Ec ���?        N�qt@�H�'~��?        �rH�qt@a���"��?        h�Σ�qt@�8[|��?        �T1�qt@A��C���?        ��ھrt@<�2/��?        \aLrt@�r�x��?        *��rt@�f�GV��?        �Nmg,rt@�I���?        Ps��9rt@�Z�F��?        ��y�Grt@�M^��?        ���Urt@�����?        Dᅝbrt@o�R!�?        �+prt@f���*�?        �*��}rt@4.��G2�?        8OF�rt@c�3�9�?        �s�Әrt@\m�M�@�?        ��$a�rt@w3�gG�?        +���rt@�InDQM�?        ��0|�rt@=6J�R�?        y�	�rt@��̈́W�?        +=��rt@���S�[�?        �O�$�rt@��2�_�?        ltI��rt@�ݹ��b�?        ��?st@"f��e�?        ��U�st@4CQZ1h�?        `��Z st@y���j�?        b�-st@=8��k�?        �+�u;st@��(sl�?        TPnIst@����l�?        �t��Vst@Q���l�?        ��zdst@tk2�Bl�?        H� �qst@�*|$k�?        ��9st@D��mxi�?        �ǌst@�lb�:g�?        <,�T�st@A� �gd�?        �P�st@MD|�`�?        �u�o�st@��v�\�?        /�%��st@�s�iX�?        ־���st@��CS�?        }�1�st@#�4��M�?        #���st@_r��aG�?        �,>3�st@�b�j�@�?        pQ��tt@��)�9�?        vJNtt@��<2�?        ����!tt@�����*�?        d�Vi/tt@�D�?�"�?        ���<tt@������?        �c�Jtt@Ǿ4EZ�?        X-�Xtt@u}�/'
�?        �Qo�ett@F1��?        �v�,stt@���5���?        L�{��tt@��"����?        �H�tt@���,���?        ��՛tt@ � ��?        @	c�tt@��?9��?        �-��tt@vE��t��?        �R~�tt@`�_����?        4w��tt@�)�����?        ڛ&��tt@�)=r���?        ���&�tt@�@E\��?        '�2��tt@K����?        �	�Aut@�S7����?        u.?�ut@'����?        S�\#ut@vߨ9���?        �wK�0ut@`�B����?        h��w>ut@��X�v�?        �WLut@Y]��i�?        ��ݒYut@²=�I\�?        \
d gut@#�W�6N�?        /�tut@$V�V?�?        �Sp;�ut@]:��/�?        Px�ȏut@ҔL�?        ��|V�ut@?-�Q:�?        ���ut@�B���?        D�q�ut@�S/�P��?        �
��ut@�rצ���?        �/���ut@��Vv���?        8T�ut@=�e+��?        �x���ut@�E%ŏ��?        ��'5�ut@���Cˉ�?        +­�	vt@]�h�u�?        ��3Pvt@���-b�?        y��$vt@����N�?        0@k2vt@���=/:�?        �T��?vt@H���P&�?        lyL�Mvt@�l�r}�?        ��[vt@u! �f��?        ��X�hvt@f�z���?        `��.vvt@�D"Z��?        e��vt@��JɆ�?        �0�I�vt@f���_�?        TUqמvt@�R��G7�?        �y�d�vt@Bn�45�?        ��}�vt@���,���?        H���vt@7�}���?        ���vt@�����?        ���vt@2-�Tk�?        <1�(�vt@�GK2A�?        �U��vt@q�=��?        �z�Cwt@��b�<��?        /�(�wt@ϡ�\��?        �î^&wt@��/0ے�?        }�4�3wt@�h��e�?        #�yAwt@P�.�7�?        �1AOwt@&�-�	�?        pVǔ\wt@��c�l��?        {M"jwt@�w��?        ��ӯwwt@�� az�?        d�Y=�wt@��m�nI�?        ��ʒwt@�C����?        �fX�wt@q~����?        X2��wt@ �n���?        �Vrs�wt@J+qf��?        �{� �wt@�g�'L�?        L�~��wt@�p����?        ���wt@�%S�0��?        �銩�wt@��p���?        @7�wt@��YKJx�?        �2��xt@+���B�?        �WRxt@g�OTt�?        3|��'xt@�v��J��?        ڠ)m5xt@h4a���?        �ů�Bxt@�n�Pid�?        '�5�Pxt@-����+�?        ��^xt@�׭b��?        t3B�kxt@�Y�K���?        X�0yxt@ � 5~�?        �|N��xt@��k[C�?        h��K�xt@�C%��?        �Z١xt@3ߒLZ��?        ���f�xt@7�כX��?        \g��xt@d[(g!T�?        4��xt@����?        �Xs�xt@G��$���?        P}���xt@���G{��?        ��*�xt@L��W�c�?        ��� yt@���(�?        D�Eyt@ξ�v���?        ��yt@�Xp��?        �4�`)yt@��]Q7{�?        7Y�6yt@� �]C�?        �}�{Dyt@0Om���?        ��*	Ryt@|B���?        +ǰ�_yt@S�6ľ��?        ��6$myt@�]z�o�?        x��zyt@�4��=�?        5C?�yt@�t����?        �Y�̕yt@�b���?        l~OZ�yt@X�����?        ���yt@K����?        ��[u�yt@��vR�?        `���yt@�|P�k%�?        h��yt@�1���?        �5��yt@�@f���?        TZt��yt@B�3=���?        �~�8zt@]��r�?        ����zt@5����E�?        H�Tzt@����?        ���*zt@"04'���?        �o8zt@���]���?        ;6��Ezt@�����?        �Z�Szt@.ސY�^�?        ��azt@���|/�?        /�+�nzt@W�m_���?        �ȱ2|zt@����l��?        |�7��zt@ySt���?        #�M�zt@~c��n�?        �6Dۤzt@�V���=�?        p[�h�zt@QE<g��?        �P��zt@%��}��?        ��փ�zt@
���Z�?        d�\�zt@ 1��J��?        ���zt@������?        �i,�zt@F�b�?�?        X7�{t@�1qX���?        �[uG{t@�RZ ���?        ����{t@���q/�?        L��b,{t@�ᥨ���?        ���9{t@Huߡ�?        ��}G{t@Z��)�?        ?U{t@��>�P��?        �7��b{t@Lͽ[��?        �\ &p{t@�+&��/�?        3���}{t@8�ɜ<��?        ڥ,A�{t@���y���?        �ʲΘ{t@�K�r>�?        '�8\�{t@������?        ���{t@t��dX��?        t8Ew�{t@�Ux.R�?        ]��{t@�Q�?        ��Q��{t@��Nԥ��?        h���{t@h�Hi�?        �]��{t@�����?        ���:|t@7;~���?        \j�|t@�
/��?        9�U |t@f�{I2�?        �]v�-|t@?!�@1��?        P��p;|t@0�4��?        ����H|t@v��R\G�?        ���V|t@q"ˣ��?        C��d|t@�p�����?        ��q|t@��Y�Z�?        �9�4|t@v_	B��?        7^!|t@4�˴���?        ނ�O�|t@n�I��m�?        ��-ݧ|t@{�	3�?        +̳j�|t@wԱ��?        ��9��|t@ �"ǂ�?        x���|t@X��>n5�?        :F�|t@|l����?        �^̠�|t@2Y�&��?        l�R.�|t@���
R�?        �ػ}t@ f81�?        ��^I}t@#Z`�~��?        `���!}t@����
x�?        kd/}t@V��1�?        �:��<}t@n���,��?        T_wJ}t@Ca0�ީ�?        ���X}t@:�h�?        ����e}t@G1�ʫ'�?        H�	(s}t@�8�ɒ��?        �񏵀}t@iɱ6�V�?        �C�}t@��7���?        ;;�Л}t@_�ni�?        �_"^�}t@�v����?        ����}t@S������?        /�.y�}t@�����?        �ʹ�}t@>���O��?        |�:��}t@�s��C�?        #�!�}t@d�,4��?        �;G��}t@xjhtav�?        p`�<~t@k3��3�?        �S�~t@&��ڌ��?        ���W#~t@HAQN�?        d�_�0~t@S�pUh��?        ��r>~t@Z�»��?        �l L~t@b�62�?        X<�Y~t@�v&���?        �`xg~t@�]]�Uz�?        ����t~t@��T��?        L��6�~t@�-;�%��?        ��
ď~t@A>9m�?        ��Q�~t@Z����?        ?ߪ~t@�_�G7��?        �<�l�~t@�v��e�?        �a#��~t@�S0��?        3����~t@F�G��?        ڪ/�~t@�4":Ia�?        .�6ηst@        .�6ηst@�+f1\�?