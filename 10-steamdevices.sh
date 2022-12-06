# Copy steam udev rules
echo "Copying Steam device udev rules"
cd bits/steam-devices/
sudo cp * /etc/udev/rules.d/

echo "Done"
