set output 'output.plot'
set xtics nomirror 
set xlabel 'Average time (ps)'
set xrange [317.91093146084995:347.074536206461]
set ytics nomirror 
set ylabel 'Density (a.u.)'
set yrange [0:0.12103471363672957]
unset y2tics
set key off
set terminal svg dynamic dashed size 450, 300 font 'Helvetica'
unset bars
plot '-' binary endian=little record=500 format='%float64' using 1:2:3 axes x1y2 with filledcurves fillstyle solid 0.25 noborder lc rgb '#1f78b4' title 'PDF', '-' binary endian=little record=2 format='%float64' using 1:2 with lines lt 1 lw 2 lc rgb '#1f78b4' title 'Mean'
��,��s@�ee�-?        M��s@F��@��0?        ��q�s@��!�t2?        �Va�s@���Oi�4?        J!.�P�s@�zň��6?        �$B@�s@�޾	HU9?        �'V/�s@�2TW<?        H+j��s@�+��1 ??        �.~E�s@����H9A?        �1����s@,tuP�
C?        F5���s@i��E?        �8�n��s@���>�3G?        �;����s@ʿ�U��I?        D?�4��s@�7�ݽ'L?        �B����s@���~�N?        �E
���s@�`fyQ?        BI^��s@��}��R?        �L2�x�s@�
o�yT?        �OF$h�s@�����lV?        @SZ�W�s@��v���X?        �Vn�F�s@�~n)�Z?        �Y�M6�s@m Yd�I]?        =]��%�s@��5��_?        �`��s@焤 ha?        �c�v�s@����b?        ;g����s@8�[R�d?        �j�<��s@Nf��bf?        �m����s@#y�`�Kh?        9q��s@u��EWj?        �t"f��s@F���3�l?        �w6ɠ�s@������n?        7{J,��s@�q\`�p?        �~^��s@��r?        ��r�n�s@��N3�ms?        5��U^�s@q#���t?        ����M�s@[�eʉv?        ދ�= t@4���<x?        2��~,t@�mE
z?        ����t@�^�S��{?        ܕ�Dt@i �a;�}?        0����t@?�L>m�?        ���t@���B,�?        ڟ&n�t@�55�[�?        .�:��t@T~��ܚ�?        ��N4�t@0�iP��?        שb��t@�\;jK�?        ,�v��	t@�S2X���?        ���]�
t@
JE�@�?        ճ��ut@_g�AՊ?        *��#et@;��B�|�?        ~�ƆTt@�oY�6�?        ӽ��Ct@
���?        (��L3t@P�6���?        |��"t@�C���?        ��t@�*a���?        %�*vt@�/�T ��?        z�>��t@H�Z���?        ��R<�t@���U�3�?        #�f��t@q�TH�]�?        x�z�t@�4%��?        �ێe�t@Y/X��ϙ?        !ߢȝt@�S#nW�?        v�+�t@�L;s&h�?        ��ʎ|t@z�0�<?        ���kt@	�!k%�?        s��T[t@��w��H�?        ���Jt@��I��?        �:t@ޤZ|���?        q�.~)t@��r�7��?        ��B�t@��,��J�?        �VD t@cڼ��?        o k�� t@_�!�|�?        �
�!t@�QXs��?        �m�"t@��V���?        m
���#t@\�F�g^�?        ��3�$t@g�X9�7�?        ϖ�%t@w� ���?        k���&t@����?        ��\�'t@e
�ϛѪ?        �r(t@$�S����?        i#b)t@�����?        �!3�Q*t@1��(*y�?        %G�@+t@]�%g]�?        f([L0,t@�T�
�A�?        �+o�-t@�4��O�?        /�.t@u�}��?        d2�u�.t@�r�^��?        �5���/t@���w�h�?        9�;�0t@(���ٱ?        b<Ӟ�1t@m�vB�I�?        �?��2t@x~��Ÿ�?        C�d�3t@��&�?        `FȚ4t@Z�ę��?        �I#+�5t@{�M��?        	M7�y6t@�i���h�?        ^PK�h7t@�t��Ѵ?        �S_TX8t@J�Gt7�?        Ws�G9t@���j���?        \Z�7:t@�o�6��?        �]�}&;t@�ޛPW^�?        a��<t@��j#��?        Yd�C=t@��|�?        �gצ�=t@�I\�Hp�?        k�	�>t@�b9�lƷ?        Wn�l�?t@�����?        �q��@t@��[j�?         u'3�At@�!t����?        Ux;��Bt@�lU���?        �{O��Ct@7d�4#J�?        �~c\�Dt@+q_���?        S�w�oEt@�����Ϲ?        ���"_Ft@��ZV��?        ����NGt@h�gqH�?        Q���=Ht@aH�}��?        ���K-It@����׳�?        ��ۮJt@�ʽ^~�?        N��Kt@U�k��?        ��u�Kt@9�_�;�?        ����Lt@Ƙ�=b�?        L�+;�Mt@8e�$��?        ��?��Nt@`����?        ��S�Ot@�4Sv���?        J�gd�Pt@b����ٻ?        ��{ǗQt@�h]?�?        �*�Rt@iN~�a�?        H���vSt@+ r�3�?        ����eTt@�����?        ��SUUt@�	�$�?        F�߶DVt@d+k�)�?        ���4Wt@��6+�?        ��}#Xt@Y~N�)�?        D��Yt@�`��%�?        ��/CZt@}a*;=�?        ��C��Zt@��}���?        A�W	�[t@�.���?        ��kl�\t@�&�ҿ��?        ��Ͽ]t@��e���?        ?ܓ2�^t@A�[
]λ?        �ߧ��_t@��k|$��?        ����`t@�.WS��?        =��[}at@�_�}�?        ���lbt@uI��.^�?        ���!\ct@�=k <�?        ;��Kdt@�:O��?        ���:et@�'4��?        ��3K*ft@`]���Ǻ?        9�G�gt@������?        ��[	ht@!J��	p�?        � pt�ht@�^1A�?        6���it@m����?        ��:�jt@���޹?        �
���kt@����?        4� �lt@�u��kt�?        ��c�mt@-�ÑQ=�?        ��Ɣnt@��1`��?        2�)�ot@xP�˸?        ��spt@+�:���?        �$�bqt@+����S�?        0"8SRrt@F�z���?        �%L�Ast@8@��ط?        �(`1tt@u`�!홷?        .,t| ut@E��8PZ�?        �/��vt@��m�?        �2�B�vt@B�n>ٶ?        ,6���wt@�y�����?        �9��xt@!6;(UV�?        �<�k�yt@���7j�?        )@�μzt@��Oҵ?        ~C 2�{t@�J w��?        �F��|t@4���M�?        'J(��}t@��K��?        |M<[z~t@Fud�ɴ?        �PP�it@�s�L���?        %Td!Y�t@%���F�?        zWx�H�t@�?�܁�?        �Z��7�t@|�m��ĳ?        #^�J'�t@�l�(ᄳ?        wa���t@�T�oE�?        �d��t@$�b��?        !h�s��t@����Ȳ?        uk���t@���\��?        �n:ԇt@q����N�?        r�Èt@�7�l�?        su, ��t@R>	�ر?        �x@c��t@�<��?        |TƑ�t@y��	�f�?        qh)��t@b<�!/�?        Ƃ|�p�t@�x�����?        ���_�t@!��_ð?        o��RO�t@#�i�/��?        Ì��>�t@-��Q)\�?        ��.�t@D'O*�?        m��{�t@v8�H�?        �����t@�f��V��?        �B��t@�2�]�7�?        j���t@���"�ݮ?        ��0ەt@�.*�Ⅾ?        �Dkʖt@(iM߃0�?        h�Xι�t@|@�~�ݭ?        ��l1��t@�Lt�،�?        �����t@�ҿ=>�?        f�����t@�nm�?        ���Zw�t@�5-����?        ���f�t@,*$��`�?        d�� V�t@|0[�v�?        ���E�t@�S�sث?        ���4�t@�񔄳��?        b�J$�t@/���PW�?        �� ��t@��i}��?        �4�t@jh�7ު?        `�Hs�t@	�pv_��?        ��\��t@꥖Z=l�?        	�p9Ѥt@�[3�5�?        ]ل���t@[*w�� �?        �ܘ���t@'�T;cͩ?        �b��t@��`��?        [��Ŏ�t@�W�j�?        ���(~�t@��P;�?        ��m�t@ʳ�2�?        Y���\�t@�d�	�?        ��RL�t@{*���?        �$�;�t@d�^����?        W�8+�t@����^�?        ��L{�t@X��5�?         �`�	�t@I��H��?        UuA��t@bI��+�?        ����t@�P�����?        ��زt@i\%�_��?        R�jǳt@y��Gq�?        ��Ͷ�t@>���K�?        ��0��t@nK�_j&�?        P퓕�t@L+���?        ����t@�3
��ܦ?        �Zt�t@��̓���?        N)�c�t@1���}��?        �"= S�t@�p�?        �%Q�B�t@��/�L�?        L)e�1�t@G��'�(�?        �,yI!�t@���0�?        �/���t@~�ӱ{�?        J3� �t@wK����?        �6�r�t@_kb����?        �9����t@�C~h#v�?        H=�8��t@���2R�?        �@��t@IE�".�?        �C���t@-!���	�?        EGb��t@�ޮI��?        �J-ŋ�t@ۖ�T��?        �MA({�t@�'�qZ��?        CQU�j�t@��b�sw�?        �Ti�Y�t@�.��XR�?        �W}QI�t@�ޅ-�?        A[��8�t@��͋}�?        �^�(�t@T+����?        �a�z�t@7�Oq���?        ?e���t@Zk�\���?        �h�@��t@�>ao�?        �k����t@탪�cH�?        =o	��t@Ǭ�)z!�?        �rj��t@�=�9V��?        �u1ͳ�t@�*�~�Ң?        :yE0��t@4{��a��?        �|Y���t@�\p���?        �m���t@k *q�[�?        8��Yq�t@6E�HT3�?        ����`�t@�e���
�?        ≩P�t@�4�F�?        6���?�t@�~��v��?        ����.�t@���x��?        ߓ�H�t@Z�[ONg�?        4����t@�$���=�?        ����t@�{�*}�?        ݝ!r��t@�ti���?        2�5���t@�8�]��?        ��I8��t@�$�.��?        ۧ]���t@ ��C*m�?        0�q���t@���	C�?        ���a��t@
�
���?        ٱ�Ĉ�t@���ݟ?        -��'x�t@��C�=��?        ����g�t@O���X3�?        ׻��V�t@O"T�Yޞ?        +��PF�t@3�S�G��?        ����5�t@
.��(4�?        ��%�t@I�nYߝ?        )�%z�t@@��cቝ?        ~�9��t@��Ub�4�?        ��M@��t@N���ߜ?        '�a���t@\��͊�?        |�u��t@�|���5�?        �ىi��t@����T�?        %ݝ̰�t@��y[ތ�?        y�/��t@A�֧�8�?        ��Œ��t@�[�{��?        "���~�t@P)����?        w��Xn�t@O�H2�=�?        ���]�t@2EV���?         �M�t@\N�
��?        u�)�<�t@�e\^�E�?        ��=�+�t@�<�2��?        �QH�t@F��/��?        s�e�
�t@��_R�?        �z��t@&���K�?        �q��t@��}�Ҳ�?        q����t@�}��c�?        ��7��t@c2R��?        ʚ��t@H��?QȖ?        n����t@�`Q�{�?        ��`��t@Rp"��/�?        ą�t@��u�<�?        l'u u@֢]����?        �.�du@6_E�P�?        #B�Su@~d�/*�?        j&VPCu@�~u��?        �)j�2u@dֱ��w�?        -~"u@����z1�?        h0�yu@��9��?        �3�� u@�~FQ6��?        7�?�u@�NLUc�?        f:΢�u@��uH �?        �=��	u@��Oޒ?        A�h�
u@$����?        dD
̭u@-'J^�[�?        �G/�u@���!�?        K2��u@V}8�ݑ?        aNF�{u@5BC񣞑?        �QZXku@�9��`�?        Un�Zu@t��i�#�?        _X�Ju@:=S��?        �[��9u@0�\ث�?        _��(u@��_�p�?        ]b�Gu@�7Q6�?        �eҪu@�U����?        i��u@R
����?        [l�p�u@v���?�?        �o��u@GȽ���?        s"7�u@�V���/�?        Yv6��u@9�෿�?        �yJ��u@���0P�?        }^`�u@��A&5�?        V�rÂu@g�5�r�?        ���&ru@}t����?         ���au@ۓ�G ��?        T���Pu@{��)�?        ���O@ u@��l����?        ��ֲ/!u@de�J�O�?        R��"u@+��^�?        ���x#u@^)�w�?        ����#u@{���
�?        P�&?�$u@Rk���?        ��:��%u@>��'S3�?        ��N�&u@-�^Q�Ǉ?        N�bh�'u@b��z\�?        ��v˪(u@�
�;c�?        ���.�)u@�5�r���?        L����*u@���?        ����x+u@)[�ñ�?        ���Wh,u@�,p��G�?        I�ںW-u@j'��tބ?        ���G.u@���`{u�?        ���6/u@	
�n
�?        G��%0u@�^U�1��?        ��*G1u@P�5E>�?        ��>�2u@%K�ׂ?        E�R�2u@�4��q�?        ��fp�3u@�f��(�?        ��z��4u@�RDEZ��?        Cڎ6�5u@��{k�F�?        �ݢ��6u@�ǅ��?        ����7u@VR��o��?        A��_�8u@]4u�7%�?        ����9u@v~���?        ���%o:u@�W^,��~?        >��^;u@�k���~?        ���M<u@�L=�l}?        ��.O==u@a���|?        <�B�,>u@dIj�_|?        ��V?u@�|i�Bg{?        ��jx@u@���ǟ�z?        :��@u@V��b�z?        ��>�Au@�V)�y?        ����Bu@'���M�x?        8��Cu@fZ��<Ox?        ��g�Du@��U��w?        ��ʧEu@�=��Z,w?        6�-�Fu@W����v?        ���Gu@�b�v?        ��uHu@�mp2�u?        4 3WeIu@܃ۓu?        �#G�TJu@nd_��t?        �&[DKu@��w!:t?        1*o�3Lu@71�^�s?        �-��"Mu@}'`M�4s?        �0�FNu@�hJ���r?        /4��Ou@���OZr?        �7��Ou@�R�p�q?        �:�o�Pu@��{�ԋq?        ->���Qu@f_Ä$)q?        �A�5�Ru@�|��@�p?        �D��Su@El@	lp?        +H#��Tu@δ��[p?        �K7_�Uu@ڋZ�-ro?        �NK�|Vu@I6�.�n?        )R_%lWu@y��8vn?        }Us�[Xu@��P��zm?        �X��JYu@������l?        &\�N:Zu@ܿJD>l?        {_��)[u@hO�o��k?        �b�\u@�0 ٪k?        $f�w]u@���{j?        yi���]u@&]����i?        �l�=�^u@���m.[i?        "p��_u@<�q�h?        ws'�`u@�n�Ch?        �v;g�au@�Tsi�g?         zOʤbu@~���2g?        u}c-�cu@�pvH��f?        ɀw��du@�/��'f?        ���reu@��R䟣e?        r��Vbfu@�X�� e?        Ǌ��Qgu@���YԞd?        ��Ahu@N-D�d?        p��0iu@ .��}�c?        Ŕ��ju@JL��c?        �Fku@`��i5�b?        n���ku@���&!b?        Þ+�lu@��ϣa?        �?o�mu@����2'a?        l�S��nu@�xndV�`?        ��g5�ou@�n9�B0`?        �{��pu@n]��l_?        j����qu@F�'Ky^?        ���^�ru@��,�q�]?        ���ysu@�� ��\?        h��$itu@*�2��[?        ��߇Xuu@$�w��Z?        ���Gvu@C�p'��Y?        e�N7wu@���ŏ�X?        ���&xu@L��?4X?        �/yu@���3W?        c�Cwzu@	�=��WV?        ��W��zu@h�8�~U?        �k=�{u@��~��T?        a���|u@<M�W'�S?        �ړ�}u@���ۀ
S?        
ާf�~u@�Yq\�@R?        _�ɡu@�H�u{Q?        ���,��u@��Y�Y�P?        �㏀�u@��7Xf�O?        ]���o�u@1�Y�>�N?        ��V_�u@_��t$M?        ��N�u@��l7�K?        Z�3>�u@�K+�sJ?        ��G-�u@�'G*I?        �[��u@� ]�G?        X�oE�u@�5,ܾ�F?        �����u@]�q�@�E?        ��u@�}��gD?        V	�nڊu@JM��PC?        ���ɋu@�nv�CB?        ��4��u@�ç��@A?        T藨�u@n�__H@?        �����u@�n��O�>?        �^��u@O̎L�<?        R$�v�u@�m�0�1;?        � 8$f�u@�2ifa�9?        �#L�U�u@hȰ���7?        P'`�D�u@� ܍�6?        �*tM4�u@�8�|�5?        �-��#�u@Qy���3?        M1��u@�|��p2?        �4�v�u@Hc�e81?        �7���u@-�3.v0?        K;�<�u@�%�ߧ�-?        �>�Йu@_�����+?        �A ��u@��>��)?        IEf��u@8D/(?        �H(ɞ�u@�3r��V&?        �K<,��u@W����$?        GOP�}�u@�BQ�,#?        �Rd�l�u@��*>�!?        �UxU\�u@�� ��b ?        EY��K�u@����??        �\�;�u@*��]�?        �_�~*�u@��VwF�?        Bc���u@�l ?�?        �f�D	�u@�4SP�?        �i���u@+p����?        @m�u@	�\�H?        �pnקu@g�/1�?        �s,�ƨu@N{Nl�?        >w@4��u@_>��?        �zT���u@zi��l�	?        �}h���u@���T?        <�|]��u@8�Ŕ�A?        ����s�u@1��޿X?        凤#c�u@�hos��?        :���R�u@kc]��>        ����A�u@8��#/��>        ��L1�u@xZ�0C�>        ��o��t@        ��o��t@i��
��?