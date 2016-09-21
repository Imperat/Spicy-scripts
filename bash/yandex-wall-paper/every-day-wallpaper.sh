#!/bin/bash

mkdir kefal
wget -O kefal/kefal.jpg https://yandex.ru/images/today?size=1920x1080
current_dir=`pwd`
gsettings set org.gnome.desktop.background picture-uri "file:////$current_dir/kefal/kefal.jpg"

