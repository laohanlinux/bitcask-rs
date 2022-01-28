set output 'output.plot'
set title 'Mmap Sizes/268435456: slope'
set xtics nomirror 
set xlabel 'Average time (ps)'
set xrange [327.0097627798414:328.94393314546676]
set ytics nomirror 
set ylabel 'Density (a.u.)'
set key on outside top right Left reverse 
set terminal svg dynamic dashed size 1280, 720 font 'Helvetica'
unset bars
plot '-' binary endian=little record=500 format='%float64' using 1:2 with lines lt 1 lw 2 lc rgb '#1f78b4' title 'Bootstrap distribution', '-' binary endian=little record=407 format='%float64' using 1:2:3 with filledcurves fillstyle solid 0.25 noborder lc rgb '#1f78b4' title 'Confidence interval', '-' binary endian=little record=2 format='%float64' using 1:2 with lines lt 2 lw 2 lc rgb '#1f78b4' title 'Point estimate'
1B�'pt@Z��:Y�?<e�7pt@���=�-�?G�ŽGpt@�d.�n�?Q�&�Wpt@k�a�Rr�?\V�~gpt@��Œu�?g�^wpt@�;c�V�?r�H?�pt@כR�˱?}���pt@�l��B�?�j
 �pt@�e�H��?�/k�pt@�~��4�?�����pt@)�}�L��?��,��pt@�p�B*�?�~���pt@����l��?�C�a�pt@܍ac �?�OBqt@�}J7��?�ͯ"qt@h�+�^�?ޒ&qt@�Vώ�?�Wq�5qt@E%�t�?���Eqt@�(O}P�?��2�Uqt@'Vv��?	���eqt@7>��m�?l�duqt@V�Y�Y�?1UE�qt@Z��c�Y�?)��%�qt@����Jй?4��qt@+�f�G�??�w�qt@�'�i��?JE���qt@�
a�:�?U
9��qt@�5�ij��?_ϙ��qt@}�RG�6�?j��g�qt@`���-��?uY[Hrt@�O�	@?�?��(rt@����Uɽ?��	$rt@E���W�?��}�3rt@FH���?�m��Crt@d�5��?�2?�Srt@���,�?����crt@l�6>xa�?�� ksrt@3�,.x��?ˁaK�rt@OZ�1�?�F�+�rt@�`�¢e�?�#�rt@e�f����?�Ѓ�rt@��s�� �?�����rt@�yx�ׁ�?[E��rt@�Ə����? ���rt@KI��K�?�n�rt@������?"�gNst@x��p�?-o�.st@9D�ظ��?74)"st@������?B���1st@��&XEh�?M���Ast@e�f�*��?X�K�Qst@!u "8K�?cH��ast@n%c<��?mqqst@�Zx2�?x�mQ�st@�6�=g��?���1�st@�1yU2�?�\/�st@��g8?��?�!��st@��Lj�?�����st@a|���z�?��Q��st@�� ����?�p���st@d��O�d�?�5t�st@I��b��?��sT tt@�6��M�?ٿ�4tt@�x>����?�5 tt@�n)��6�?�I��/tt@`*D�?���?tt@)	I�h �?�W�Ott@C�ۮ��?���_tt@D���?^wott@���@h��?%#zWtt@WӋU��?0��7�tt@�aa�s�?;�;�tt@ՑF���?Er���tt@\��m�5�?P7�ؾtt@���%u�?[�]��tt@:�0����?f����tt@}q}����?q�z�tt@,�Gc�:�?{K�Z�tt@���z\�?��:ut@:��W��?��Aut@���?����-ut@m�j��U�?�_�=ut@��.W��?�$d�Mut@��ȏ���?��Ĝ]ut@Զ�M�8�?Ǯ%}mut@�J./ֆ�?�s�]}ut@��M��?�8�=�ut@覩��&�?��G�ut@7T�zx�?�¨��ut@�p�U��?��	߼ut@����e�?Mj��ut@��ڥ�r�?˟�ut@�wL�W��?�+��ut@E�,��?(��`�ut@ʘ]��r�?3a�@vt@�2���?>&N!vt@����?I�,vt@�7wDw�?S��;vt@w����?^up�Kvt@��uh&�?i:Ѣ[vt@O��(�~�?t�1�kvt@�n���?Ēc{vt@ �O��/�?���C�vt@j�9<���?�NT$�vt@��^��?���vt@� 
S�;�?���vt@���G���?��v��vt@dB.����?�bץ�vt@�AYgXJ�?�'8��vt@A$�{1��?��f�vt@~ʠ�T �?��F
wt@d@�B�[�?�vZ'wt@��ng��?�;�*wt@i��8I�? �9wt@-@�_[o�?�|�Iwt@�!�����?�ݨYwt@�e���'�?!P>�iwt@7�ksZ��?+�iywt@�KX���?6��I�wt@�#��V=�?A�`*�wt@'Ĭٙ�?Ld�
�wt@՝P�Z��?W)"�wt@r��l)�?a���wt@��Y��W�?l���wt@��}P��?wxD��wt@���1��?�=�l�wt@l�����?�Mxt@�z����?��f-xt@�`�3Q?�?���(xt@����m�?�Q(�7xt@L'����?���Gxt@:3��f��?���Wxt@�A�m��?͠J�gxt@P�W�)�?�e�owxt@��XY�?�*P�xt@���Ј�?��l0�xt@�:��ø�?����xt@�*�����?z.�xt@g�nXp�??���xt@��_*J�?��xt@����${�?$�P��xt@i��}]��?/��r�xt@������?9SSyt@�r.x�?Ds3yt@ w/PA�?O��&yt@��Qs�?Z�4�5yt@.e�v��?eg��Eyt@$�t���?o,��Uyt@zJ4�
�?z�V�eyt@��ݧd<�?���uuyt@�|\h�n�?�{V�yt@�n[��?�@y6�yt@!.H d��?���yt@SG�F��?��:��yt@�xΧ7�?�����yt@I�-�i�?�T���yt@O=�5X��?�]��yt@7�(���?�޽x�yt@�� �Q��?�Yzt@>��/�?�h9zt@��ۊ`�?�-�$zt@�¿Gc��?�@�3zt@�8���?���Czt@l`b���?}�Szt@�*Ny#�?'Bc�czt@?>�jS�?2�{szt@������?=�$\�zt@K�o��?G��<�zt@�2����?RV��zt@>h!9�?]G��zt@� �ID�?h���zt@o��@t�?s���zt@�Cb��?}ji��zt@r3m���?�/�~�zt@$�p�?��*_{t@�܍I2�?���?{t@�,��`�?�~�"{t@5���?�CM 2{t@��� ���?���A{t@�7�M&��?���Q{t@�{���?Ԓo�a{t@=�Zb�=�?�WЁq{t@?�g�?�1b�{t@;Yi���?��B�{t@�_�P��?���"�{t@�#5B��?
lS�{t@�)h���?1���{t@�0J҂�?���{t@�DW�?�?*�u��{t@��{^�?5�ք�{t@3��{�?@E7e |t@NH_��?K
�E|t@@ws���?U��% |t@q%Mʳ��?`�Y0|t@�m�s���?kY��?|t@^W��B��?v�O|t@֍W-�?��{�_|t@��g��#�?��܇o|t@����>8�?�m=h|t@�ڰ��K�?�2�H�|t@��*�_�?���(�|t@�g��q�?��_	�|t@�,�����?����|t@o��1��?�F!��|t@���r��?����|t@�(?�׻�?����|t@	�]AL��?�Ck�|t@5�0����?�Z�K}t@�Ađ��? ,}t@��9q�?�e.}t@�_o}�?���=}t@ֈ�o�,�?#o'�M}t@ݓ��@�?-4��]}t@E��S�?8��m}t@����'g�?C�In}}t@��i��z�?N��N�}t@��K�P��?YH/�}t@.�	?���?cl�}t@9Kվ���?n���}t@t������?y�-��}t@���yg��?�\���}t@�4xg��?�!��}t@��Ed���?��Oq�}t@�һv�?���Q~t@c���T�?�p2~t@`��*N-�?�5r,~t@g���P;�?����;~t@���LH�?Ͽ3�K~t@$�4�6T�?ڄ��[~t@��_�?�I��k~t@(�)��h�?�Vt{~t@a��Kq�?�ӶT�~t@4,��x�?�5�~t@��3)�?^x�~t@�wH���?#���~t@$�P���?&�9��~t@��G�J��?1����~t@;^ԟю�?;r���~t@�/Sl���?F7\w�~t@�e�j��?Q��W
t@ـ�.���?\�8t@��7���?g�~*t@d8�ޏ�?qK��9t@��E}	��?|@�It@�t3>���?�ՠ�Yt@����x��?���it@@��?�_bzyt@�I�O��?�$�Z�t@ly��0{�?��#;�t@ <�Ru�?����t@�4A2�n�?�s���t@���#g�?�8F��t@�WG�^�?�����t@ǛbLU�?����t@yIB��J�?�h}�t@�r�2W?�?�L�]�t@�o�;�2�?*>�t@����$�?׊(�t@ɟe��?���7�t@K�1��?)aL�G�t@��
3��?4&��W�t@9J@���?>��g�t@q%���?I�n�w�t@AcW���?Tu�`��t@&�`v��?_:0A��t@-�UM%��?j��!��t@J�yit�?t����t@"��4�[�?�R�ƀt@��	�B�?�N��րt@I)�%)�?���t@��^I�?��t���t@[�#h���?���c�t@��AT��?�b6D�t@����Կ�?�'�$&�t@�c��e��?���6�t@OLt��?ֱX�E�t@�$�tq�?�v��U�t@�]�GIW�?�;�e�t@�����=�?� {�u�t@�l���$�?��f��t@�c����?�<G��t@q|�:��?P�'��t@�,����?!���t@�4ٞ��?,�^�āt@� l^l��?7���ԁt@jܐ(��?Bd ��t@�&��y�?L)���t@���`�?W��i�t@Ng3��G�?b�BJ�t@�v;��-�?mx�*$�t@�rj�x�?x=4�t@y�HB-��?�e�C�t@�	�����?����S�t@S&�����?��&�c�t@K��h��?�Q��s�t@�J���?��l��t@p�UL`�?��HM��t@[s>�?à�-��t@�<եh�?�e
��t@�WK1��?�*k�t@z�(W���?����҂t@m���i��?�,��t@�V�j���?�y���t@&�|2�[�??�o�t@��@l2�?OP�t@ �3}�?ɯ0"�t@�ɩr���?$�2�t@B�xͲ�?/Sq�A�t@�2?��?:��Q�t@���rW[�?E�2�a�t@�y,/�?P���q�t@�����?Zg�r��t@P��[��?e,US��t@�f��ש�?p�3��t@���7T}�?{���t@^R���P�?�{w���t@^�}�v$�?�@��Ѓt@��%�+��?�9���t@�+����?�ʙ���t@��h����?���u �t@�	��t�?�T[V�t@�N��LH�?��6 �t@�n��?��0�t@&W��3��?ܣ}�?�t@�^u"���?�h��O�t@��H���?�-?�_�t@�b}�o�?��o�t@����D�?� y�t@@G���?}aY��t@�����?B�9��t@��~�}��?(#��t@���O��?2̃���t@_���o�?=���΄t@�0 �uE�?HVE�ބt@���CY�?S���t@�h��W��?^�|��t@�z3�n��?h�g\�t@����?sj�<�t@7k�}�s�?~/).�t@����J�?���=�t@iK1g �?����M�t@�������?�~K�]�t@�^����?�C��m�t@}�����?�}�t@@]�ey�?��m_��t@��|�N�?ʒ�?��t@.�8��$�?�W/ ��t@-�MP2��?�� ��t@�Ga�|��?����̅t@�M���?��Q�܅t@�lQ_y�? l���t@k���M�?
1���t@X�6W"�?�sb�t@!�?���? ��B�t@F�v���?+�5#,�t@5�pzk��?6E�<�t@��7r�?@
��K�t@䲄N�E�?K�W�[�t@��ּ�?V���k�t@^x����?aY�{�t@B�|��?lze��t@�F@���?v��E��t@��d��i�?��;&��t@���!Y>�?�m���t@��I� �?�2��ʆt@
�x�i��?��]�چt@�͝7{�?�����t@�&�?�����t@��.L���?�F�h
�t@`�����?��H�t@C�9t-�?��A)*�t@�ì����?╢	:�t@a�y���?�Z�I�t@-�B�:�?�d�Y�t@g���(��?�Īi�t@�`T�?��?�%�y�t@N�Y�M�?o�k��t@UC\$ �?#4�K��t@ok��Բ�?.�G,��t@AH�4�e�?9����t@_ĬR\�?D�	�ȇt@baa�	��?NHj�؇t@X��߀�?Y˭�t@=��4�?d�+���t@r������?o��n�t@�RmI_��?z\�N�t@��pC�O�?�!N/(�t@ꨂ��?��8�t@���յ�?���G�t@���0!h�?�pp�W�t@e�/��?�5Ѱg�t@s����?��1�w�t@$d�n�{�?ſ�q��t@P��M�+�?Є�Q��t@�7ׂ���?�IT2��t@8 ����?����t@3�KJ�7�?���ƈt@��~����?��v�ֈt@�/���?^׳�t@٥�A�?#8���t@���Ɓ��?�t�t@O��`+��?&��T�t@��^�-J�?1rZ5&�t@e�\���?<7�6�t@�Յ����?G��E�t@�MɄX�?R�|�U�t@ۧ�=	�?\�ݶe�t@3�/ ���?gK>�u�t@Q��Bo�?r�w��t@����X$�?}��W��t@�,����?��`8��t@�&���?�_���t@:SP��L�?�$"�ĉt@uX���?���ԉt@�N
e���?����t@���B��?�sD��t@SsC�?�8�z�t@��5z�?��[�t@�u�݌�?��f;$�t@	��~��?��4�t@K�����?�L(�C�t@!tvn'�?���S�t@�kR���?	��c�t@��8�hA�?�J�s�t@�TC��?a�}��t@����`�?*&^��t@W/ G���?4�l>��t@���PX��??����t@=�k6��?Ju.�t@�y�IL��?U:��Ҋt@_��:�?`���t@�
H���?j�P��t@舎?gc�?u����t@�%����?�Na�t@�<�X��?�sA"�t@[�P&�?���!2�t@^ 1���?��4B�t@����.X�?�b��Q�t@�����?�'��a�t@Ե��?��V�q�t@���>�-�?̱����t@�ns���?�vd��t@��ߚ�o�?�;yD��t@�BYnt�?� �$��t@=E@S��?��:��t@�.�67a�?���Ћt@��g��?P����t@6I��?]���t@��vd�?"ڽ� �t@l�I��?-�g�t@�F�m��?8dG �t@F�f1pv�?B)�'0�t@���S�)�?M�@@�t@�m���?X���O�t@�M�*��?cx�_�t@4�òOG�?n=c�o�t@�k�����?xĉ�t@E^fRo��?��$j��t@@J�`,h�?���J��t@Y�I��?�Q�*��t@W�&T��?�G��t@�T����?�ۧ�Όt@��ZI~�?���ތt@� ,���?�ei��t@�T`
V�?�*ʌ��t@}�1��¼?��*m�t@�B��'0�?䴋M�t@f�O���?�y�-.�t@U�>���?�>M>�t@�!��?��M�t@io��)�?��]�t@, �Rh�?�o�m�t@��Ze�߸?%SЏ}�t@��Qb4Y�?01p��t@��U�0շ?;ݑP��t@�=J�S�?F��0��t@�f��Զ?PgS��t@����zX�?[,��̍t@�錱�޵?f��܍t@���E(h�?q�u��t@-��8��?|{֒��t@��.��?�@7s�t@`y�H�?��S�t@������?���3,�t@�^���A�?��Y<�t@N'r+�ܲ?�T��K�t@�f�@�z�?��[�t@�h���?��{�k�t@�b)��?ңܕ{�t@���.g�?�h=v��t@�Q+�?�-�V��t@>�l�x��?���6��t@N�F�cl�?��_��t@�O܎��?}��ʎt@�2�J��?B!�ڎt@�
T�
�?���t@ܛ�)Kw�?(����t@ ��<��?3�Cy
�t@�;�V�?>V�Y�t@0B��WǬ?"�gNst@x��p�?        -o�.st@9D�ظ��?        74)"st@������?        B���1st@��&XEh�?        M���Ast@e�f�*��?        X�K�Qst@!u "8K�?        cH��ast@n%c<��?        mqqst@�Zx2�?        x�mQ�st@�6�=g��?        ���1�st@�1yU2�?        �\/�st@��g8?��?        �!��st@��Lj�?        �����st@a|���z�?        ��Q��st@�� ����?        �p���st@d��O�d�?        �5t�st@I��b��?        ��sT tt@�6��M�?        ٿ�4tt@�x>����?        �5 tt@�n)��6�?        �I��/tt@`*D�?        ���?tt@)	I�h �?        �W�Ott@C�ۮ��?        ���_tt@D���?        ^wott@���@h��?        %#zWtt@WӋU��?        0��7�tt@�aa�s�?        ;�;�tt@ՑF���?        Er���tt@\��m�5�?        P7�ؾtt@���%u�?        [�]��tt@:�0����?        f����tt@}q}����?        q�z�tt@,�Gc�:�?        {K�Z�tt@���z\�?        ��:ut@:��W��?        ��Aut@���?        ����-ut@m�j��U�?        �_�=ut@��.W��?        �$d�Mut@��ȏ���?        ��Ĝ]ut@Զ�M�8�?        Ǯ%}mut@�J./ֆ�?        �s�]}ut@��M��?        �8�=�ut@覩��&�?        ��G�ut@7T�zx�?        �¨��ut@�p�U��?        ��	߼ut@����e�?        Mj��ut@��ڥ�r�?        ˟�ut@�wL�W��?        �+��ut@E�,��?        (��`�ut@ʘ]��r�?        3a�@vt@�2���?        >&N!vt@����?        I�,vt@�7wDw�?        S��;vt@w����?        ^up�Kvt@��uh&�?        i:Ѣ[vt@O��(�~�?        t�1�kvt@�n���?        Ēc{vt@ �O��/�?        ���C�vt@j�9<���?        �NT$�vt@��^��?        ���vt@� 
S�;�?        ���vt@���G���?        ��v��vt@dB.����?        �bץ�vt@�AYgXJ�?        �'8��vt@A$�{1��?        ��f�vt@~ʠ�T �?        ��F
wt@d@�B�[�?        �vZ'wt@��ng��?        �;�*wt@i��8I�?         �9wt@-@�_[o�?        �|�Iwt@�!�����?        �ݨYwt@�e���'�?        !P>�iwt@7�ksZ��?        +�iywt@�KX���?        6��I�wt@�#��V=�?        A�`*�wt@'Ĭٙ�?        Ld�
�wt@՝P�Z��?        W)"�wt@r��l)�?        a���wt@��Y��W�?        l���wt@��}P��?        wxD��wt@���1��?        �=�l�wt@l�����?        �Mxt@�z����?        ��f-xt@�`�3Q?�?        ���(xt@����m�?        �Q(�7xt@L'����?        ���Gxt@:3��f��?        ���Wxt@�A�m��?        ͠J�gxt@P�W�)�?        �e�owxt@��XY�?        �*P�xt@���Ј�?        ��l0�xt@�:��ø�?        ����xt@�*�����?        z.�xt@g�nXp�?        ?���xt@��_*J�?        ��xt@����${�?        $�P��xt@i��}]��?        /��r�xt@������?        9SSyt@�r.x�?        Ds3yt@ w/PA�?        O��&yt@��Qs�?        Z�4�5yt@.e�v��?        eg��Eyt@$�t���?        o,��Uyt@zJ4�
�?        z�V�eyt@��ݧd<�?        ���uuyt@�|\h�n�?        �{V�yt@�n[��?        �@y6�yt@!.H d��?        ���yt@SG�F��?        ��:��yt@�xΧ7�?        �����yt@I�-�i�?        �T���yt@O=�5X��?        �]��yt@7�(���?        �޽x�yt@�� �Q��?        �Yzt@>��/�?        �h9zt@��ۊ`�?        �-�$zt@�¿Gc��?        �@�3zt@�8���?        ���Czt@l`b���?        }�Szt@�*Ny#�?        'Bc�czt@?>�jS�?        2�{szt@������?        =�$\�zt@K�o��?        G��<�zt@�2����?        RV��zt@>h!9�?        ]G��zt@� �ID�?        h���zt@o��@t�?        s���zt@�Cb��?        }ji��zt@r3m���?        �/�~�zt@$�p�?        ��*_{t@�܍I2�?        ���?{t@�,��`�?        �~�"{t@5���?        �CM 2{t@��� ���?        ���A{t@�7�M&��?        ���Q{t@�{���?        Ԓo�a{t@=�Zb�=�?        �WЁq{t@?�g�?        �1b�{t@;Yi���?        ��B�{t@�_�P��?        ���"�{t@�#5B��?        
lS�{t@�)h���?        1���{t@�0J҂�?        ���{t@�DW�?�?        *�u��{t@��{^�?        5�ք�{t@3��{�?        @E7e |t@NH_��?        K
�E|t@@ws���?        U��% |t@q%Mʳ��?        `�Y0|t@�m�s���?        kY��?|t@^W��B��?        v�O|t@֍W-�?        ��{�_|t@��g��#�?        ��܇o|t@����>8�?        �m=h|t@�ڰ��K�?        �2�H�|t@��*�_�?        ���(�|t@�g��q�?        ��_	�|t@�,�����?        ����|t@o��1��?        �F!��|t@���r��?        ����|t@�(?�׻�?        ����|t@	�]AL��?        �Ck�|t@5�0����?        �Z�K}t@�Ađ��?         ,}t@��9q�?        �e.}t@�_o}�?        ���=}t@ֈ�o�,�?        #o'�M}t@ݓ��@�?        -4��]}t@E��S�?        8��m}t@����'g�?        C�In}}t@��i��z�?        N��N�}t@��K�P��?        YH/�}t@.�	?���?        cl�}t@9Kվ���?        n���}t@t������?        y�-��}t@���yg��?        �\���}t@�4xg��?        �!��}t@��Ed���?        ��Oq�}t@�һv�?        ���Q~t@c���T�?        �p2~t@`��*N-�?        �5r,~t@g���P;�?        ����;~t@���LH�?        Ͽ3�K~t@$�4�6T�?        ڄ��[~t@��_�?        �I��k~t@(�)��h�?        �Vt{~t@a��Kq�?        �ӶT�~t@4,��x�?        �5�~t@��3)�?        ^x�~t@�wH���?        #���~t@$�P���?        &�9��~t@��G�J��?        1����~t@;^ԟю�?        ;r���~t@�/Sl���?        F7\w�~t@�e�j��?        Q��W
t@ـ�.���?        \�8t@��7���?        g�~*t@d8�ޏ�?        qK��9t@��E}	��?        |@�It@�t3>���?        �ՠ�Yt@����x��?        ���it@@��?        �_bzyt@�I�O��?        �$�Z�t@ly��0{�?        ��#;�t@ <�Ru�?        ����t@�4A2�n�?        �s���t@���#g�?        �8F��t@�WG�^�?        �����t@ǛbLU�?        ����t@yIB��J�?        �h}�t@�r�2W?�?        �L�]�t@�o�;�2�?        *>�t@����$�?        ׊(�t@ɟe��?        ���7�t@K�1��?        )aL�G�t@��
3��?        4&��W�t@9J@���?        >��g�t@q%���?        I�n�w�t@AcW���?        Tu�`��t@&�`v��?        _:0A��t@-�UM%��?        j��!��t@J�yit�?        t����t@"��4�[�?        �R�ƀt@��	�B�?        �N��րt@I)�%)�?        ���t@��^I�?        ��t���t@[�#h���?        ���c�t@��AT��?        �b6D�t@����Կ�?        �'�$&�t@�c��e��?        ���6�t@OLt��?        ֱX�E�t@�$�tq�?        �v��U�t@�]�GIW�?        �;�e�t@�����=�?        � {�u�t@�l���$�?        ��f��t@�c����?        �<G��t@q|�:��?        P�'��t@�,����?        !���t@�4ٞ��?        ,�^�āt@� l^l��?        7���ԁt@jܐ(��?        Bd ��t@�&��y�?        L)���t@���`�?        W��i�t@Ng3��G�?        b�BJ�t@�v;��-�?        mx�*$�t@�rj�x�?        x=4�t@y�HB-��?        �e�C�t@�	�����?        ����S�t@S&�����?        ��&�c�t@K��h��?        �Q��s�t@�J���?        ��l��t@p�UL`�?        ��HM��t@[s>�?        à�-��t@�<եh�?        �e
��t@�WK1��?        �*k�t@z�(W���?        ����҂t@m���i��?        �,��t@�V�j���?        �y���t@&�|2�[�?        ?�o�t@��@l2�?        OP�t@ �3}�?        ɯ0"�t@�ɩr���?        $�2�t@B�xͲ�?        /Sq�A�t@�2?��?        :��Q�t@���rW[�?        E�2�a�t@�y,/�?        P���q�t@�����?        Zg�r��t@P��[��?        e,US��t@�f��ש�?        p�3��t@���7T}�?        {���t@^R���P�?        �{w���t@^�}�v$�?        �@��Ѓt@��%�+��?        �9���t@�+����?        �ʙ���t@��h����?        ���u �t@�	��t�?        �T[V�t@�N��LH�?        ��6 �t@�n��?        ��0�t@&W��3��?        ܣ}�?�t@�^u"���?        �h��O�t@��H���?        �-?�_�t@�b}�o�?        ��o�t@����D�?        � y�t@@G���?        }aY��t@�����?        B�9��t@��~�}��?        (#��t@���O��?        2̃���t@_���o�?        =���΄t@�0 �uE�?        HVE�ބt@���CY�?        S���t@�h��W��?        ^�|��t@�z3�n��?        h�g\�t@����?        sj�<�t@7k�}�s�?        ~/).�t@����J�?        ���=�t@iK1g �?        ����M�t@�������?        �~K�]�t@�^����?        �C��m�t@}�����?        �}�t@@]�ey�?        ��m_��t@��|�N�?        ʒ�?��t@.�8��$�?        �W/ ��t@-�MP2��?        �� ��t@�Ga�|��?        ����̅t@�M���?        ��Q�܅t@�lQ_y�?         l���t@k���M�?        
1���t@X�6W"�?        �sb�t@!�?���?         ��B�t@F�v���?        +�5#,�t@5�pzk��?        6E�<�t@��7r�?        @
��K�t@䲄N�E�?        K�W�[�t@��ּ�?        V���k�t@^x����?        aY�{�t@B�|��?        lze��t@�F@���?        v��E��t@��d��i�?        ��;&��t@���!Y>�?        �m���t@��I� �?        �2��ʆt@
�x�i��?        ��]�چt@�͝7{�?        �����t@�&�?        �����t@��.L���?        �F�h
�t@`�����?        ��H�t@C�9t-�?        ��A)*�t@�ì����?        ╢	:�t@a�y���?        �Z�I�t@-�B�:�?        �d�Y�t@g���(��?        �Īi�t@�`T�?��?        �%�y�t@N�Y�M�?        o�k��t@UC\$ �?        #4�K��t@ok��Բ�?        .�G,��t@AH�4�e�?        9����t@_ĬR\�?        D�	�ȇt@baa�	��?        NHj�؇t@X��߀�?        Y˭�t@=��4�?        d�+���t@r������?        o��n�t@�RmI_��?        z\�N�t@��pC�O�?        �!N/(�t@ꨂ��?        ��8�t@���յ�?        ���G�t@���0!h�?        �pp�W�t@e�/��?        �5Ѱg�t@s����?        ��1�w�t@$d�n�{�?        ſ�q��t@P��M�+�?        Є�Q��t@�7ׂ���?        �IT2��t@8 ����?        ����t@3�KJ�7�?        ���ƈt@��~����?        ��v�ֈt@�/���?        ^׳�t@٥�A�?        #8���t@���Ɓ��?        �t�t@O��`+��?        &��T�t@��^�-J�?        1rZ5&�t@e�\���?        <7�6�t@�Յ����?        G��E�t@�MɄX�?        R�|�U�t@ۧ�=	�?        \�ݶe�t@3�/ ���?        gK>�u�t@Q��Bo�?        r�w��t@����X$�?        }��W��t@�,����?        ��`8��t@�&���?        �_���t@:SP��L�?        �$"�ĉt@uX���?        ���ԉt@�N
e���?        ����t@���B��?        �sD��t@SsC�?        �8�z�t@��5z�?        ��[�t@�u�݌�?        ��f;$�t@	��~��?        ��4�t@K�����?        �L(�C�t@!tvn'�?        ���S�t@�kR���?        	��c�t@��8�hA�?        �J�s�t@�TC��?        a�}��t@����`�?        *&^��t@W/ G���?        4�l>��t@���PX��?        ?����t@=�k6��?        Ju.�t@�y�IL��?        U:��Ҋt@_��:�?        `���t@�
H���?        j�P��t@舎?gc�?        u����t@�%����?        �Na�t@�<�X��?        �sA"�t@[�P&�?        ���!2�t@^ 1���?        ��4B�t@����.X�?        �b��Q�t@�����?        �'��a�t@Ե��?        ��V�q�t@���>�-�?        ̱����t@�ns���?        �vd��t@��ߚ�o�?        �;yD��t@�BYnt�?        � �$��t@=E@S��?        ��:��t@�.�67a�?        ���Ћt@��g��?        P����t@6I��?        ]���t@��vd�?        "ڽ� �t@l�I��?        -�g�t@�F�m��?        8dG �t@F�f1pv�?        B)�'0�t@���S�)�?        �k�PQt@        �k�PQt@�h��?