#!/bin/bash
# Indique au système que l'argument qui suit est le programme utilisé pour exécuter ce fichier
# Pour l'instant le dts est stocké dans  home/machinekit/boneDeviceTree/overlay/DM-GPIO-Test.dts
# Liens interessants :
# http://derekmolloy.ie/beaglebone/beaglebone-gpio-programming-on-arm-embedded-linux/

echo Initialisation des pins
echo Declaration des variables :
export SLOTS=/sys/devices/bone_capemgr.*/slots
export PINS=/sys/kernel/debug/pinctrl/44e10800.pinmux/pins
export GPIO=/sys/class/gpio
# CAPE :

echo Chargement de la cape
echo Tour_Daddy | sudo tee $SLOTS

export LCD_FILE=/usr/share/gmoccapy_lcd7
if [ ! -d "$LCD_FILE" ]; then
  echo "Installation de l ecran"
	git clone https://github.com/vichente1/gmoccapy_lcd7.git
	cd gmoccapy_lcd7/
	sudo cp bin/gmoccapy_lcd7 /usr/bin/
	sudo chmod a+x /usr/bin/gmoccapy_lcd7
	sudo cp -r share/gmoccapy_lcd7/ /usr/share/
	sudo apt-get update
	sudo apt-get install matchbox
	sudo cp keyboard-cnc.xml /usr/share/matchbox-keyboard
	sudo chmod a+x /usr/share/matchbox-keyboard/keyboard-cnc.xml
else
	echo "Ecran deja installe"
fi

echo Definition des GPIOs
# echo 23 | sudo tee $GPIO/export		# Mettre le numéro de la colonne GPIO associé 23 pour 8.13
echo 66 | sudo tee $GPIO/export		# P8.03	xlim in
echo 69 | sudo tee $GPIO/export		# P8.05 ylim in
echo 45 | sudo tee $GPIO/export         # P8.07 zlim in

echo 67 | sudo tee $GPIO/export         # P8.04	xok out
echo 68 | sudo tee $GPIO/export         # P8.06 yok out
echo 44 | sudo tee $GPIO/export         # P8.08 zok out

echo Definition de la direction
echo "in" | sudo tee $GPIO/gpio66/direction
echo "in" | sudo tee $GPIO/gpio69/direction
echo "in" | sudo tee $GPIO/gpio45/direction

echo "out" | sudo tee $GPIO/gpio67/direction
echo "out" | sudo tee $GPIO/gpio68/direction
echo "out" | sudo tee $GPIO/gpio44/direction

exit 0
