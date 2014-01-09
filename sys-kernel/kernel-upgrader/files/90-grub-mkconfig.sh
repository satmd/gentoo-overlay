#!/bin/bash
#exit 0
grub2-mkconfig -o /boot/grub2/grub.cfg
sed -e 's,^\(\s*\)echo,\1#echo,' -i /boot/grub2/grub.cfg
sed -e 's,^\(\s*menuentry.*\)\(\s\),\1 --unrestricted\2,' -i /boot/grub2/grub.cfg
