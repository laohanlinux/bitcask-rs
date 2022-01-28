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
��P�B(@��K�,�?��P�B(@V-2 @�n�;2"@��P��@��P�B((@D0.�@{��S2.@t�%z�@�n�;22@��W:n@#��:#5@�.�e��@��P�B(8@�0~��1@	��YK-;@�J#f��0@{��S2>@����ҙ4@we��@@�����&@�n�;2B@��O+)@�wak��C@�C�l�[*@#��:#E@�ei��
.@]��ʾ�F@����q�/@��P�B(H@�0~��0@Ϝ�)ǪI@��O�0@	��YK-K@�|?5^�1@B�?�ϯL@�k]j��2@{��S2N@yq��3@����״O@˻���4@we��P@!����5@��#�\Q@���·�6@�n�;2R@mFA��7@M�St�R@	�f�ba9@�wak��S@o,(�T:@��3��aT@P��no:@#��:#U@#���ic;@�ٲ|�U@;�O��Z<@]��ʾ�V@��x�&�=@�~� gW@�~j�t>@��P�B(X@�����,@@3#��X@f�8�m@@Ϝ�)ǪY@�p!�@@l!�A	lZ@+���=A@	��YK-[@-���A@�*mq��[@�aK��B@B�?�ϯ\@?5^�I�B@�3�q]@� C@{��S2^@)\���$D@=�Е�^@��2�P<D@����״_@�a���D@)#. ;`@���QZE@we��`@�_ �)F@ŧ O�`@��C�l5F@��#�\a@j�t��F@b,�/��a@L�[�߀G@�n�;2b@��q��G@���G�~b@j�t�:H@M�St�b@��F��*I@�5x_@c@�4�($�H@�wak��c@��4��lI@8�JwWd@�|?5^�J@��3��ad@^�I�J@�>���d@��o�D�J@#��:#e@wKr���K@r��ۃe@�f���K@�ٲ|�e@%�S;�VL@H¾Ef@33333M@]��ʾ�f@��_=�N@�̔�_g@+�~N�M@�~� gg@���S��N@HQg��g@���N@��P�B(h@}Yک��O@��9�h@9��v��O@3#��h@D?�{!P@�Z&Ji@��ʡ_P@Ϝ�)Ǫi@�,^,�P@��5hj@333334Q@l!�A	lj@��-$LQ@�c�M��j@     YQ@	��YK-k@�,^,�Q@W�e�k@�Xl��R@�*mq��k@m�(*R@�lV}.Ol@ŭ��zR@B�?�ϯl@�{G�	,S@��(�pm@+����R@�3�qm@ۆQ<S@-v����m@�(���S@{��S2n@z�S�4�S@������n@��K7�S@=�Е�n@�[T@g��6To@o�UfJ�T@����״o@�ZH�T@�9z�
p@�-�|�U@)#. ;p@ףp=
hU@P�"�]kp@�2nj�OU@we��p@�n���U@����p@�z�<V@ŧ O�p@���$x)V@�H���,q@	���V@��#�\q@���(\�V@;�ީ@�q@��Co�V@b,�/��q@7�A`�W@��ǵ��q@�~j�t~W@�n�;2r@��"���W@����Nr@(5
I_X@���G�~r@��Q�X@&R��#�r@a���qX@M�St�r@�Q�U��X@                M�St�r@5/B�X@                        M�St�r@�/�!�X@��Z��X@