if ! command -v apt &> /dev/null
then
    echo "apt not found"
    exit 1
fi
echo 'Acquire::http { Proxy "http://192.168.1.99:3142"; }' > /etc/apt/apt.conf.d/proxy
apt update
apt dist-upgrade -y
