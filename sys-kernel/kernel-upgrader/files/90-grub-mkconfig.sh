#!/bin/bash
GRUBDIR=""
for X in /boot/grub /boot/grub2 ; do
	test -d "$X" && GRUBDIR="$X"
done
if [ -z "$GRUBDIR" ] ; then
	echo "ERROR: Cannot detect grub boot directory. Skipping."
	exit 0
fi

GRUBMKCONFIG=""
for X in /sbin/grub-mkconfig /usr/sbin/grub-mkconfig /sbin/grub2-mkconfig /usr/sbin/grub2-mkconfig ; do
	test -x "$X" && GRUBMKCONFIG="$X"
done
if [ -z "$GRUBMKCONFIG" ] ; then
	echo "ERROR: Cannot find grub-mkconfig/grub2-mkconfig. Skipping."
	exit 0
fi

"${GRUBMKCONFIG}" -o "${GRUBDIR}"/grub.cfg
sed -e 's,^\(\s*\)echo,\1#echo,' -i "${GRUBDIR}"/grub.cfg
sed -e 's,^\(\s*menuentry.*\)\(\s\),\1 --unrestricted\2,' -i "${GRUBDIR}"/grub.cfg
