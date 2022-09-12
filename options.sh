echo -e "\n\033[1:31mSetting DNS to Warp\033[0m"
networksetup -setdnsservers Wi-Fi 1.1.1.1 1.0.0.1 2606:4700:4700::1111 2606:4700:4700::1001
