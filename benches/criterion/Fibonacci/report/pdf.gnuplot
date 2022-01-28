set output 'output.plot'
set title 'Fibonacci'
set xtics nomirror 
set xlabel 'Average time (ps)'
set xrange [319.5835104837213:361.05207394288936]
set ytics nomirror 
set ylabel 'Iterations (x 10^6)'
set yrange [0:291.3169]
set y2tics nomirror 
set y2label 'Density (a.u.)'
set key on outside top right Left reverse 
set terminal svg dynamic dashed size 1280, 720 font 'Helvetica'
unset bars
plot '-' binary endian=little record=500 format='%float64' using 1:2:3 axes x1y2 with filledcurves fillstyle solid 0.25 noborder lc rgb '#1f78b4' title 'PDF', '-' binary endian=little record=2 format='%float64' using 1:2 with lines lt 2 lw 2 lc rgb '#1f78b4' title 'Mean', '-' binary endian=little record=20 format='%float64' using 1:2 with points lt 1 lc rgb '#1f78b4' pt 7 ps 0.75 title '"Clean" sample', '-' binary endian=little record=4 format='%float64' using 1:2 with points lt 1 lc rgb '#ff7f00' pt 7 ps 0.75 title 'Mild outliers', '-' binary endian=little record=16 format='%float64' using 1:2 with points lt 1 lc rgb '#e31a1c' pt 7 ps 0.75 title 'Severe outliers', '-' binary endian=little record=2 format='%float64' using 1:2 with lines lt 2 lw 2 lc rgb '#ff7f00' notitle, '-' binary endian=little record=2 format='%float64' using 1:2 with lines lt 2 lw 2 lc rgb '#ff7f00' notitle, '-' binary endian=little record=2 format='%float64' using 1:2 with lines lt 2 lw 2 lc rgb '#e31a1c' notitle, '-' binary endian=little record=2 format='%float64' using 1:2 with lines lt 2 lw 2 lc rgb '#e31a1c' notitle
L�V�s@!1�g&	?        O@s��s@ݜ�V�?        SEi���s@f�I8�?        V��;S�s@h�8[?        Zû���s@���ҿ�?        ]���s@e(�s�?        `AhPt@Pq��Kg?        d�7̤t@����z* ?        g�`0�t@���"|^"?        k���Mt@�'���$?        n=���t@��j+[�'?        q|�\�t@َi��*?        u��J	t@�^��.?        x�.%�
t@�JT0�0?        |9X��t@��1f3?        x��Gt@vC�a5?        ���Q�t@x��]�7?        ��ӵ�t@���v�:?        �5�Et@�C{��=?        �t&~�t@�(xG��@?        ��O��t@ �Mv�B?        ��xFBt@Y41su�D?        �1���t@(�]���F?        �p��t@�D�=pJI?        ���r?t@�Z�Q��K?        ��דt@�]2���N?        �-G;�t@����P?        �lp�<t@���Z��R?        ����t@Y�ґ~T?        ���g�t@E�?�uV?        �)��9!t@�T��W�X?        �h0�"t@���\��Z?        ��>��#t@��V#D]?        ��g�6%t@��dς�_?        �%�\�&t@+W���Pa?        �d���'t@��j��b?        ǣ�$4)t@� Z}C[d?        ����*t@B���f?        �!6��+t@� -�q�g?        �`_Q1-t@�٧��i?        ԟ���.t@���x��k?        �ޱ�/t@0�tЪm?        ��}.1t@�ĕ��o?        �\�2t@��yҫq?        �-F�3t@�*��?r?        ��V�+5t@e; �p~s?        ���6t@؜����t?        �X�r�7t@���<�$v?        ���(9t@2�xY�w?        ���:}:t@g�w� y?        �%��;t@�V$nI�z?        �TN&=t@z�|J�|?        ��wgz>t@�z* �}?        Ӡ��?t@����xQ?        �/#At@4��N���?        Q�wBt@=.֑�_�?        ���Ct@��2�/C�?        �E\ Et@��@?+�?        o�tFt@�a_���?        M�$�Gt@�u�?        ���It@�J/ ���?        ���qJt@���>��?        
Q�Kt@l�&nv�?        #I=�Mt@����?        &�foNt@Ef�Y�?        )Ǐ}�Ot@B�Iɝ�?        -��Qt@/��]�?        0E�ElRt@ƭ4t�?        4���St@����ߍ?        7�4Ut@^���ێ?        :^riVt@�G�A�֏?        >A�ֽWt@1,&��g�?        A��:Yt@t���H�?        E�ٞfZt@��0�/[�?        H��[t@��Y�ё?        L=,g]t@vGd`F�?        O|U�c^t@6m{���?        R�~/�_t@��=Q�&�?        V���at@�0g�Y��?        Y9��`bt@	�W^��?        ]x�[�ct@\AΉ�^�?        `�#�	et@���辔?        c�L$^ft@�C��?        g5v��gt@�Vr�r�?        jt��it@�݂�ŕ?        n��P[jt@T�8Ԧ�?        q��kt@��B�\�?        t1mt@�H�*���?        xpD}Xnt@� hQߖ?        {�m�ot@qL_�|�?        �Eqt@�	&�L�?        �-��Urt@�;x�z�?        �l��st@ڕ�C��?        ��r�tt@�H=�ė?        ��;�Rvt@c�!@�?        �)e:�wt@��o����?        �h���xt@�d��?        ���Pzt@ms���?        ���f�{t@��h���?        �%
��|t@�q­��?        �d3/M~t@��Ed�?        ��\��t@�h\�?        �����t@=�)�8�?        �!�[J�t@T/���ۗ?        �`ؿ��t@s���?        ��$�t@�'ڙȜ�?        ��*�G�t@MO*{u�?        �T웇t@�"�.I�?        �\}P��t@���?        ����D�t@�aT�K�?        �����t@Rwzv��?        ��|�t@݄�B�i�?        �X"�A�t@c \pB'�?        ͗KE��t@;U:�?        ��t��t@���v��?        ��?�t@h�!�J�?        �T�q��t@�������?        ۓ���t@��Iʋ��?        ��:<�t@9��S�?        �C���t@U!�|r��?        �Pl�t@��Pg��?        菕f9�t@ǹV�5L�?        �ξʍ�t@���xF�?        ��.�t@�����?        �L�6�t@_�]/�=�?        ��:���t@��Z�r�?        ��c[ߠt@f�Rd��?        �	��3�t@��3'Y5�?         I�#��t@�-���?        �߇ܤt@�D3����?        ��0�t@�~�4�@�?        
2P��t@�2���?        E[�٨t@�i�C`�?        ��.�t@0e��ގ?        í|��t@��,�i�?        ��֬t@�����?        A E+�t@��BV��?        �)��t@z��fh_�?        "�R԰t@�z71X(�?        &�{q(�t@4[�n��?        )=��|�t@�V6 9��?        ,|�9Ѵt@>���t��?        0���%�t@��� �?        3� z�t@f�^��Y�?        79Jfθt@���ѩ��?        :xs�"�t@��/%�?        =��.w�t@��齸�?        A�Œ˼t@��oY�m�?        D5���t@M�嗱"�?        Ht[t�t@��6䠐?        K�A���t@�g�B2�?        N�j#�t@��>�ב?        R1��q�t@>�
=֑�?        Up����t@ ��a�?        Y��O�t@-����G�?        \��n�t@j��,-E�?        _-9��t@���,FZ�?        clb|�t@C�YBʇ�?        f���k�t@v���LΘ?        j�D��t@�a\Q.�?        m)ި�t@��/�I��?        phi�t@�:��<�?        t�0q��t@�� �y�?        w�Y��t@;��Z�?        {%�9f�t@����L�?        ~d����t@=��L�?        ����t@��U=�Y�?        ���ec�t@���9t�?        �!(ʷ�t@�-��Û�?        �`Q.�t@9G3`-Ц?        ��z�`�t@s��(�?        �ޣ���t@�H�(W^�?        ��Z	�t@D�QjH��?        �\��]�t@&�g�y�?        ��#��t@���V��?        ��H��t@��e�7�?        �r�Z�t@!��B�?        �X�O��t@� �O�?        ��ĳ�t@Iҩ�*ѱ?        ���X�t@+�����?        �|��t@�ݙ��l�?        �T@� �t@�?�Ξ>�?        ��iDU�t@&! �?        �Ғ���t@H5���?        ����t@�vgP���?        �P�pR�t@�	p���?        Əզ�t@T�GҺd�?        ��79��t@���\u7�?        �a�O�t@P�Y
�?        �L���t@��f�պ?        Ӌ�e��t@�Wj�?        ����L�t@���e�?        �	.��t@�����&�?        �H/���t@��4��?        �X�I�t@_��-���?        �ƁZ��t@�U��|D�?        �����t@��(�{�?        �D�"G�t@J$�ID�?        ���� u@� D[��?        ��&��u@� ���?        �PODu@rwOT�?        �@y��u@��vO�?        ���u@v�8���?         ��{Au@tDFݴ�?        ��ߕu@�S���?        =D�	u@æ�{�?        
|G�>u@�����?        �p�u@4�1."7�?        ��p�u@#�:��G�?        9��;u@����R�?        x�8�u@�Pڛ�U�?        ���u@sx��R�?        �>9u@h�$f�I�?        "5he�u@�KM�:�?        %t���u@���R $�?        (��-6u@l��F��?        ,�㑊u@HY�O���?        /1��u@�XI6Y��?        3p6Z3u@iѾy��?        6�_��u@��RH\�?        :�"�u@�:Vc|#�?        =-��0u@���`���?        @l�� u@PS�z��?        D�O�!u@エ8�\�?        G�-�-#u@75*��?        J)W�$u@�یP���?        Nh�{�%u@�9*���?        Q���*'u@�8gء5�?        U��C(u@.Op����?        X%���)u@�}���μ?        \d%(+u@QS���?        _�Np|,u@�:?!�U�?        b�w��-u@�ȅ��?        f!�8%/u@��̾�Ϲ?        i`ʜy0u@���)
�?        m�� �1u@�0��B�?        p�e"3u@۟�${�?        sF�v4u@%hl��?        w\o-�5u@�H���?        z���7u@��}�%�?        ~���s8u@�#b�`�?        ��Y�9u@����?        �X�;u@Γ%uVܲ?        ��="q<u@/6��u�?        ��f��=u@d�'9�c�?        ���?u@���\���?        �T�Nn@u@�b�q�?        ����Au@�Iٔ���?        ��Cu@��6�,>�?        �5{kDu@U*z��?        �P^߿Eu@zq�b��?        ���CGu@b4�u�?        �ΰ�hHu@6#~%�E�?        ���Iu@�Ĳ �?        �LpKu@��J=�?        ��,�eLu@鋷����?        ��U8�Mu@�ecC��?        �	�Ou@? " ���?        �H� cPu@����?        ���d�Qu@m,*�?        ����Su@*�[�@�?        �$-`Tu@m@Zܞ?        �DM��Uu@2�Z�$K�?        ̃v�Wu@}{���̛?        �Y]Xu@ �Ga�?        �ɽ�Yu@�ߩ��?        �@�![u@~������?        ��Z\u@�g��?        ݾD�]u@�yl�ia�?        ��mN_u@�,�� J�?        �<��W`u@�����A�?        �{��au@����?G�?        ��z cu@7F��Z�?        ���Tdu@b�@��z�?        �8<C�eu@���ZN�?        �we��fu@BH��S��?        ���Rhu@�{�"D�?        ���o�iu@��m�ފ?        �4���ju@B/�C��?        t
8Olu@ٓ�E-L�?        �3��mu@%հ1!�?        	�\ �nu@�����?        1�dLpu@t����?        p�Ƞqu@��a���?        ��,�ru@g�b^��?        ��Itu@w[N�B�?        -+��uu@nE=y/�?        lTY�vu@?�>\�?        !�}�Fxu@��ʹ%?        %�!�yu@�t9]�}?        ()Ѕ�zu@֗Ih36|?        +h��C|u@BL�#�z?        /�"N�}u@��t�+�y?        2�K��~u@��6eEx?        6%uA�u@�Q=#�w?        9d�z��u@����3�u?        <����u@�~��b�t?        @��B>�u@]�V�s?        C!���u@�o�CX�r?        G`C�u@�;Y� �q?        J�lo;�u@�R`J��p?        Mޕӏ�u@FFJ�x�o?        Q�7�u@h�]?�	n?        T\�8�u@�TP3_l?        X� ��u@tp����j?        [�:d�u@��Ҁ�=i?        ^d�5�u@�u�#-�g?        bX�,��u@���_f?        e���ޒu@��K�e?        i���2�u@ fHC]�c?        l	Y��u@��}T�b?        pT2�ۖu@
vqJx_a?        s�[!0�u@��l�E`?        v҄���u@�7ˡt^?        z��ؚu@�Y�{\?        }P�M-�u@�\>�Z?        �� ���u@ޫ����X?        ��)֞u@��v|{7W?        �Sz*�u@5-���U?        �L|�~�u@}a%15=T?        ���BӢu@��P{�R?        ��Φ'�u@�W�r`�Q?        �	�
|�u@����d�P?        �H!oЦu@U� l�N?        ��J�$�u@rO�M?        ��s7y�u@�i(�2bK?        ���ͪu@`s�o �I?        �D��!�u@�ӋZ�H?        ���cv�u@����RG?        ���ʮu@)�ݕ�OF?        �B,�u@��/��vE?        �@k�s�u@E%����D?        ���ǲu@�<�g>D?        ���X�u@ᄄ=��C?        ���p�u@�x_�C?        �<!Ŷu@jƛ��C?        �{9��u@n$D�T�C?        Ⱥb�m�u@l��]��C?        ���Mºu@}X.��D?        �8���u@H'qUP�D?        �w�k�u@��F�)E?        ֶz��u@�Z1�9�E?        ��0��u@�:��S�F?        �4ZBh�u@]�@}G?        �s����u@��c$�H?        㲬
�u@�́��I?        ���ne�u@�. �/�J?        �0�ҹ�u@��ZL?        �o(7�u@��܊xM?        �Q�b�u@��F7�N?        ��z���u@����7P?        �,�c�u@��H
FQ?        �k��_�u@���|��Q?        ���+��u@~���R?        ���u@F��G�S?        )I�\�u@5�t%kT?        	hrX��u@%��R�PU?        ����u@����X8V?        �� Z�u@���p�!W?        %�u@2	��nX?        d��u@�$�Ü�X?        �@MW�u@#,�Y?        �i���u@���Z?        !!� �u@���V�[?        $`�yT�u@S�IB�~\?        '��ݨ�u@�0�U]?        +�B��u@�c�]&^?        .8�Q�u@X[��`�^?        2\a
��u@�!�?#�_?        5��n��u@X�$^�3`?        8ڳ�N�u@��Q��`?        <�6��u@����`?        ?X���u@���` )a?        C�/�K�u@���q�oa?        F�Xc��u@j��埰a?        J����u@}t֜n�a?        MT�+I�u@�Ad'% b?        P�ԏ��u@����Nb?        T�����u@wB1wb?        W'XF�u@���b?        [PP���u@7#w��b?        ^�y ��u@�7-��b?        a΢�C�u@5�C��b?        e���u@b1�E��b?        hL�L��u@�����b?        l��@�u@{����b?        o�G��u@�̪���b?        r	qy��u@Q�S��b?        vH��=�u@�+ڻ�b?        y��A��u@�m�{�b?        }����u@��'`��b?        �
;v@�T�`�b?        �D?n�v@���ʣb?        ��h��v@#@��b?        �68v@����|b?        ����v@d?�\�hb?        �@���v@�P�Ub?        �c5	v@�A��Bb?        ��6ǉ
v@	Es|1b?        ��_+�v@Wm�ŧ!b?        �<��2v@�Wѹb?        �{��v@�Y*��b?        ���W�v@%/����a?        ���/v@����a?        �8. �v@�����a?        �wW��v@-�ߨ��a?        ����,v@hx|�L�a?        ���L�v@�ƠM��a?        �4Ӱ�v@�|`���a?        �s�*v@���	b?        ��%y~v@��t�b?        ��N��v@xA��#b?        �0xA'v@��0;�3b?        �o��{v@Y�ǋEb?        ή�	�v@L��NXb?        ���m$!v@�Z���kb?        �,�x"v@B,䞩b?        �kF6�#v@�`_�b?        ܪo�!%v@�7L�z�b?        ���u&v@�����b?        �(�b�'v@�:���b?        �g��)v@XNH�O�b?        �+s*v@���b?        ��=��+v@p���b?        �$g�-v@z���2�b?        �c�Wp.v@@բl��b?        �����/v@Ф|��b?        ���1v@W�n��b?        � �m2v@8q>/�b?        `5��3v@�pJ�b?        �^L5v@�gi)g�b?        އ�j6v@�W�b?        ��7v@[�K�`pb?        \�x9v@�_���Fb?        ��g:v@��F�b?        �,A�;v@�� ��a?        V�=v@Ue���a?        X	e>v@mo���ba?         ��m�?v@vM�!�a?        $���Av@����`?        '�5bBv@Ju�py`?        *T$��Cv@��� `?        .�M�
Ev@�ɫ�_�_?        1�vb_Fv@ȹB��^?        5�ƳGv@8� ���]?        8P�*Iv@J�� ]?        ;��\Jv@᤟aD\?        ?��Kv@9�㗘b[?        BEWMv@����{Z?        FLn�YNv@^s�H\�Y?        I���Ov@#H���X?        L���Qv@H�h���W?        P	��VRv@L�M:��V?        SHL�Sv@�&p��U?        W�<��Tv@��¦��T?        Z�eTVv@X�9�v�S?        ^�x�Wv@���=�R?        aD���Xv@�m��R?        d��@QZv@��`\Q?        h�
��[v@�O7P?        k4	�\v@F^|��N?        n@]mN^v@��o��L?        r�Ѣ_v@,Z�DK?        u��5�`v@+����I?        y�ؙKbv@�q�~H?        |<��cv@5�F�F?        �{+b�dv@���iE?        ��T�Hfv@L�%Z�C?        ��}*�gv@�-еnNB?        �8���hv@6���A?        �w��Ejv@�����??        ���V�kv@�ɄJ�:=?        ��"��lv@�E�Y�;?        �4LCnv@ݴ�8?        �su��ov@�ц���6?        �����pv@hU��5?        ���K@rv@�-�'R3?        �0�sv@�i~�®1?        �o�tv@VB�G�&0?        ��Cx=vv@v�x�Vs-?        ��lܑwv@��|��*?        �,�@�xv@\]�5�U(?        �k��:zv@��</�&?        ����{v@'t  �#?        ��m�|v@��n�"?        �(;�7~v@�?ɳ�; ?        �gd5�v@g�ф3?        Ǧ����v@{�W!@6?        ���4�v@.���{?        �$�a��v@���P�?        �c	�݄v@�8���?        բ2*2�v@ּAڢ�?        ��[���v@�8$a�?        � ��ڈv@Ca�S
?        �_�V/�v@Oe#�P?        �׺��v@��4��?        �� ،v@�7�ƒ,?        �*�,�v@�n����>        �[S瀏v@���~��>        �|KՐv@R��*��>        SZ��u@        SZ��u@��5r@!cF0\6v@��u�+N@`w0�eu@~SX��z!@w�"�u@��u�+N'@���pZu@�5�o�!-@�v��tu@�fd4@S�n��pt@B@��
Qo@&��N�t@T�2C�o@B�at@3���p@�@��:�t@��GZ4p@&�^<�xt@F��bp@Y��2�t@Ϲ����p@|�!���t@Y��L/�p@K�@��bt@����p@�0�{t@k|&�gq@d_+�xt@�g?RLq@���`|�t@~SX��zq@e��swt@?q =�q@Rj#﷜t@�*�W��q@�L*�St@��ur@�y�VZt@��5r@`w0�eu@~SX��z!@���pZu@�5�o�!-@�v��tu@�fd4@&��N�t@T�2C�o@!cF0\6v@��u�+N@w�"�u@��u�+N'@S�n��pt@B@��
Qo@B�at@3���p@�@��:�t@��GZ4p@&�^<�xt@F��bp@Y��2�t@Ϲ����p@|�!���t@Y��L/�p@K�@��bt@����p@�0�{t@k|&�gq@d_+�xt@�g?RLq@���`|�t@~SX��zq@e��swt@?q =�q@Rj#﷜t@�*�W��q@�L*�St@��ur@�y�VZt@��5r@C�\~�t@        C�\~�t@��5r@]�n�Ku@        ]�n�Ku@��5r@��vaʟt@        ��vaʟt@��5r@�T�yu@        �T�yu@��5r@