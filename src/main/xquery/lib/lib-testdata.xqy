xquery version "1.0-ml";

(:~
: User: ableasdale
: Date: 31/08/2016
: Time: 09:08
: To change this template use File | Settings | File Templates.
:)

module namespace lib-testdata = "http://help.marklogic.com/lib-testdata";

declare function lib-testdata:get-pingdom-ip-list() as xs:string+ {
    ("162.218.67.34","109.123.101.103","85.93.93.133","85.93.93.124","85.93.93.123","173.254.206.242","64.237.49.203",
    "209.126.120.29","209.126.117.87","82.103.139.165","23.111.152.74","89.163.242.206","89.163.146.247","185.39.146.214",
    "185.39.146.215","95.211.228.65","168.1.92.58","43.229.84.12","37.252.231.50","103.47.211.210","175.45.132.20","211.44.63.35",
    "43.225.198.122","27.122.14.7","95.141.32.46","95.211.217.68","83.170.113.210","188.138.118.144","174.34.224.167",
    "72.46.140.106", "76.72.172.208","184.75.210.226","188.138.118.184","188.138.124.110","85.17.156.99","85.17.156.11",
    "85.17.156.76","72.46.153.26", "208.64.28.194","76.164.194.74","184.75.210.90","184.75.208.210","184.75.209.18",
    "46.165.195.139","199.87.228.66","76.72.167.90", "94.247.174.83","69.64.56.47","184.75.214.66","108.62.115.226",
    "46.20.45.18","50.23.94.74","69.59.28.19","178.255.154.2", "178.255.153.2","178.255.155.2","64.237.55.3","178.255.152.2",
    "173.248.147.18","72.46.130.42","208.43.68.59","67.228.213.178", "96.31.66.245","82.103.128.63","174.34.156.130",
    "70.32.40.2","174.34.162.242","85.25.176.167","204.152.200.42","5.178.78.77", "207.244.80.239","159.8.146.132",
    "50.22.90.227","69.64.56.153","188.138.40.20","64.120.6.122","158.58.173.160","76.72.171.180", "72.46.140.186",
    "78.31.69.179","95.211.198.87")
};

declare function lib-testdata:get-sockslist-ip-list() as xs:string+ {
    ("202.117.54.117", "190.108.35.203", "221.132.35.4", "190.108.35.195", "212.47.229.71", "76.8.157.215", "5.39.94.60",
    "40.130.0.130", "109.236.91.36", "81.30.116.103", "109.236.91.36", "77.120.224.86", "5.39.85.100", "109.236.91.36",
    "109.236.91.36", "109.236.91.36", "109.236.91.36", "109.236.91.36", "109.236.91.36", "202.201.12.12", "109.236.91.36",
    "109.236.91.36", "109.236.91.36", "202.201.12.12", "24.96.119.72", "104.199.151.222", "106.37.181.74", "109.236.91.36",
    "109.236.91.36", "109.236.91.36", "109.236.91.36", "109.236.91.36", "109.236.91.36", "109.236.91.36", "173.255.117.227",
    "114.44.216.190", "45.64.166.189", "160.7.252.142", "5.39.85.100", "87.106.244.95", "221.214.110.130", "109.236.91.36",
    "118.165.114.64", "109.236.91.36", "14.36.1.142", "1.169.251.146", "92.222.80.23", "109.236.91.36", "67.149.70.35", "39.1.37.52")
};

declare function lib-testdata:get-gtm-ip-list() as xs:string+ {
    ("208.70.247.157", "204.187.14.70", "204.187.14.71", "204.187.14.72", "204.187.14.73", "204.187.14.74", "204.187.14.75",
    "204.187.14.76", "13.85.80.124", "13.84.146.132", "172.255.61.34", "172.255.61.35", "172.255.61.36", "52.62.235.19",
    "191.235.85.154", "191.235.86.0", "52.66.75.147", "52.175.28.116")
};

declare function lib-testdata:get-company-ip-list() as xs:string+ {
    ("74.125.224.72", "74.125.224.181", "131.253.13.32", "65.55.72.135", "98.139.183.24", "72.21.211.176", "69.171.234.21",
    "69.63.176.13", "69.63.181.15", "69.63.184.142", "69.63.187.17", "69.63.187.18", "69.63.187.19", "69.63.181.11",
    "69.63.181.12", "199.59.148.10", "199.59.149.230", "216.52.242.86", "76.74.254.126", "72.233.56.138",
    "174.121.194.34", "209.200.154.225", "64.208.126.67", "173.231.140.219", "23.21.142.179", "23.23.130.59", "67.201.54.151",
    "84.22.170.149", "199.9.249.21", "184.173.141.231", "216.52.208.187", "194.71.107.50", "109.163.226.240",
    "173.0.84.3", "174.132.77.244", "199.59.149.230","174.121.194.34","72.247.244.88","64.191.203.30","173.231.140.219",
    "65.55.72.135","97.107.137.164","65.39.178.43","216.239.113.172","69.10.25.46","98.124.248.77","144.198.29.112",
    "64.34.119.12")
};

declare function lib-testdata:get-cloudflare-ip-list() as xs:string+ {
    ("103.21.244.0","103.22.200.0","103.31.4.0","104.16.0.0","108.162.192.0","131.0.72.0","141.101.64.0","162.158.0.0",
    "172.64.0.0","173.245.48.0","188.114.96.0","190.93.240.0","197.234.240.0","198.41.128.0","199.27.128.0")
};

declare function lib-testdata:get-aws-ip-list() as xs:string+ {
    ("13.32.0.0", "23.20.0.0", "27.0.0.0", "35.160.0.0", "43.250.192.0", "43.250.193.0", "46.51.128.0", "46.51.192.0",
    "46.51.216.0", "46.51.224.0", "46.137.0.0", "46.137.128.0", "46.137.192.0", "46.137.224.0", "50.16.0.0", "50.18.0.0",
    "50.19.0.0", "50.112.0.0", "52.0.0.0", "52.2.0.0", "52.4.0.0", "52.8.0.0", "52.9.0.0", "52.10.0.0", "52.12.0.0",
    "52.15.0.0", "52.16.0.0", "52.18.0.0", "52.20.0.0", "52.24.0.0", "52.28.0.0", "52.29.0.0", "52.30.0.0", "52.32.0.0",
    "52.36.0.0", "52.40.0.0", "52.44.0.0", "52.46.0.0", "52.48.0.0", "52.52.0.0", "52.54.0.0", "52.57.0.0", "52.58.0.0",
    "52.62.0.0", "52.64.0.0", "52.64.128.0", "52.65.0.0", "52.66.0.0", "52.67.0.0", "52.68.0.0", "52.70.0.0", "52.72.0.0",
    "52.74.0.0", "52.76.0.0", "52.76.128.0", "52.77.0.0", "52.78.0.0", "52.79.0.0", "52.80.0.0", "52.84.0.0", "52.86.0.0",
    "52.88.0.0", "52.90.0.0", "52.92.0.0", "52.92.16.0", "52.92.32.0", "52.92.39.0", "52.92.40.0", "52.92.48.0", "52.92.52.0",
    "52.92.56.0", "52.92.60.0", "52.92.64.0", "52.92.68.0", "52.92.72.0", "52.92.76.0", "52.92.80.0", "52.92.92.0", "52.92.248.0",
    "52.92.252.0", "52.93.0.0", "52.93.1.0", "52.93.2.0", "52.93.3.0", "52.93.4.0", "52.93.8.0", "52.93.12.0", "52.93.16.0",
    "52.94.0.0", "52.94.4.0", "52.94.5.0", "52.94.6.0", "52.94.7.0", "52.94.8.0", "52.94.9.0", "52.94.10.0", "52.94.11.0",
    "52.94.12.0", "52.94.13.0", "52.94.192.0", "52.94.196.0", "52.94.197.0", "52.94.198.0", "52.94.198.16", "52.94.198.32",
    "52.94.198.48", "52.94.198.64", "52.94.198.80", "52.94.204.0", "52.94.206.0", "52.94.208.0", "52.94.216.0", "52.94.224.0",
    "52.94.252.0", "52.94.254.0", "52.95.0.0", "52.95.16.0", "52.95.24.0", "52.95.28.0", "52.95.30.0", "52.95.34.0",
    "52.95.35.0", "52.95.36.0", "52.95.40.0", "52.95.48.0", "52.95.52.0", "52.95.56.0", "52.95.60.0", "52.95.61.0",
    "52.95.62.0", "52.95.63.0", "52.95.64.0", "52.95.80.0", "52.95.96.0", "52.95.100.0", "52.95.104.0", "52.95.128.0",
    "52.95.132.0", "52.95.192.0", "52.95.212.0", "52.95.240.0", "52.95.241.0", "52.95.242.0", "52.95.243.0", "52.95.244.0",
    "52.95.245.0", "52.95.246.0", "52.95.247.0", "52.95.248.0", "52.95.249.0", "52.95.251.0", "52.95.252.0", "52.95.255.0",
    "52.95.255.16", "52.95.255.32", "52.95.255.48", "52.95.255.64", "52.95.255.80", "52.95.255.96", "52.95.255.112",
    "52.95.255.128", "52.95.255.144", "52.192.0.0", "52.196.0.0", "52.200.0.0", "52.208.0.0", "52.216.0.0", "52.218.0.0",
    "52.218.64.0", "52.218.128.0", "52.218.192.0", "52.219.0.0", "52.219.16.0", "52.219.20.0", "52.219.24.0", "52.219.32.0",
    "52.219.40.0", "52.220.0.0", "52.222.0.0", "52.222.128.0", "54.64.0.0", "54.66.0.0", "54.67.0.0", "54.68.0.0",
    "54.72.0.0", "54.74.0.0", "54.76.0.0", "54.78.0.0", "54.79.0.0", "54.80.0.0", "54.88.0.0", "54.92.0.0", "54.92.128.0",
    "54.93.0.0", "54.94.0.0", "54.95.0.0", "54.144.0.0", "54.148.0.0", "54.150.0.0", "54.151.0.0", "54.151.128.0",
    "54.152.0.0", "54.153.0.0", "54.153.128.0", "54.154.0.0", "54.155.0.0", "54.156.0.0", "54.160.0.0", "54.168.0.0",
    "54.169.0.0", "54.170.0.0", "54.172.0.0", "54.174.0.0", "54.176.0.0", "54.178.0.0", "54.179.0.0", "54.182.0.0",
    "54.183.0.0", "54.184.0.0", "54.192.0.0", "54.193.0.0", "54.194.0.0", "54.196.0.0", "54.198.0.0", "54.199.0.0",
    "54.200.0.0", "54.202.0.0", "54.204.0.0", "54.206.0.0", "54.207.0.0", "54.208.0.0", "54.210.0.0", "54.212.0.0",
    "54.214.0.0", "54.215.0.0", "54.216.0.0", "54.218.0.0", "54.219.0.0", "54.220.0.0", "54.221.0.0", "54.222.0.0",
    "54.222.58.0", "54.222.128.0", "54.223.0.0", "54.224.0.0", "54.226.0.0", "54.228.0.0", "54.229.0.0", "54.230.0.0",
    "54.231.0.0", "54.231.128.0", "54.231.160.0", "54.231.192.0", "54.231.224.0", "54.231.232.0", "54.231.240.0",
    "54.231.244.0", "54.231.248.0", "54.231.252.0", "54.231.253.0", "54.231.254.0", "54.232.0.0", "54.233.0.0", "54.233.64.0",
    "54.233.128.0", "54.234.0.0", "54.236.0.0", "54.238.0.0", "54.239.2.0", "54.239.4.0", "54.239.8.0", "54.239.16.0",
    "54.239.32.0", "54.239.48.0", "54.239.52.0", "54.239.54.0", "54.239.56.0", "54.239.64.0", "54.239.96.0", "54.239.98.0",
    "54.239.99.0", "54.239.100.0", "54.239.104.0", "54.239.108.0", "54.239.114.0", "54.239.116.0", "54.239.120.0",
    "54.239.128.0", "54.239.192.0", "54.240.128.0", "54.240.192.0", "54.240.196.0", "54.240.197.0", "54.240.198.0",
    "54.240.199.0", "54.240.200.0", "54.240.202.0", "54.240.203.0", "54.240.204.0", "54.240.208.0", "54.240.212.0",
    "54.240.216.0", "54.240.220.0", "54.240.225.0", "54.240.226.0", "54.240.227.0", "54.240.228.0", "54.240.230.0",
    "54.240.232.0", "54.240.236.0", "54.240.240.0", "54.240.244.0", "54.240.248.0", "54.241.0.0", "54.242.0.0", "54.244.0.0",
    "54.245.0.0", "54.246.0.0", "54.247.0.0", "54.248.0.0", "54.250.0.0", "54.251.0.0", "54.252.0.0", "54.253.0.0",
    "54.254.0.0", "54.255.0.0", "67.202.0.0", "72.21.192.0", "72.44.32.0", "75.101.128.0", "79.125.0.0", "87.238.80.0",
    "96.127.0.0", "103.4.8.0", "103.8.172.0", "103.246.148.0", "103.246.150.0", "107.20.0.0", "122.248.192.0", "172.96.97.0",
    "174.129.0.0", "175.41.128.0", "175.41.192.0", "176.32.64.0", "176.32.96.0", "176.32.104.0", "176.32.112.0",
    "176.32.120.0", "176.32.125.0", "176.34.0.0", "176.34.32.0", "176.34.64.0", "176.34.128.0", "177.71.128.0",
    "177.72.240.0", "178.236.0.0", "184.72.0.0", "184.72.64.0", "184.72.128.0", "184.73.0.0", "184.169.128.0",
    "185.48.120.0", "185.143.16.0", "203.83.220.0", "204.236.128.0", "204.236.192.0", "204.246.160.0", "204.246.164.0",
    "204.246.168.0", "204.246.174.0", "204.246.176.0", "205.251.192.0", "205.251.224.0", "205.251.228.0", "205.251.232.0",
    "205.251.236.0", "205.251.240.0", "205.251.244.0", "205.251.247.0", "205.251.248.0", "205.251.249.0", "205.251.250.0",
    "205.251.252.0", "205.251.254.0", "205.251.255.0", "207.171.160.0", "207.171.176.0", "216.137.32.0", "216.182.224.0",
    "23.20.0.0", "35.160.0.0", "46.51.128.0", "46.51.192.0", "46.51.216.0", "46.51.224.0", "46.137.0.0", "46.137.128.0",
    "46.137.192.0", "46.137.224.0", "50.16.0.0", "50.18.0.0", "50.19.0.0", "50.112.0.0", "52.0.0.0", "52.2.0.0", "52.4.0.0",
    "52.8.0.0", "52.9.0.0", "52.10.0.0", "52.12.0.0", "52.15.0.0", "52.16.0.0", "52.18.0.0", "52.20.0.0", "52.24.0.0",
    "52.28.0.0", "52.29.0.0", "52.30.0.0", "52.32.0.0", "52.36.0.0", "52.40.0.0", "52.44.0.0", "52.48.0.0", "52.52.0.0",
    "52.54.0.0", "52.57.0.0", "52.58.0.0", "52.62.0.0", "52.64.0.0", "52.64.128.0", "52.65.0.0", "52.66.0.0", "52.67.0.0",
    "52.68.0.0", "52.70.0.0", "52.72.0.0", "52.74.0.0", "52.76.0.0", "52.76.128.0", "52.77.0.0", "52.78.0.0", "52.79.0.0",
    "52.80.0.0", "52.86.0.0", "52.88.0.0", "52.90.0.0", "52.95.240.0", "52.95.241.0", "52.95.242.0", "52.95.243.0",
    "52.95.244.0", "52.95.245.0", "52.95.246.0", "52.95.247.0", "52.95.248.0", "52.95.249.0", "52.95.251.0", "52.95.252.0",
    "52.95.255.0", "52.95.255.16", "52.95.255.32", "52.95.255.48", "52.95.255.64", "52.95.255.80", "52.95.255.96",
    "52.95.255.112", "52.95.255.128", "52.95.255.144", "52.192.0.0", "52.196.0.0", "52.200.0.0", "52.208.0.0", "52.220.0.0",
    "52.222.0.0", "54.64.0.0", "54.66.0.0", "54.67.0.0", "54.68.0.0", "54.72.0.0", "54.74.0.0", "54.76.0.0", "54.78.0.0",
    "54.79.0.0", "54.80.0.0", "54.88.0.0", "54.92.0.0", "54.92.128.0", "54.93.0.0", "54.94.0.0", "54.95.0.0", "54.144.0.0",
    "54.148.0.0", "54.150.0.0", "54.151.0.0", "54.151.128.0", "54.152.0.0", "54.153.0.0", "54.153.128.0", "54.154.0.0",
    "54.155.0.0", "54.156.0.0", "54.160.0.0", "54.168.0.0", "54.169.0.0", "54.170.0.0", "54.172.0.0", "54.174.0.0",
    "54.176.0.0", "54.178.0.0", "54.179.0.0", "54.183.0.0", "54.184.0.0", "54.193.0.0", "54.194.0.0", "54.196.0.0",
    "54.198.0.0", "54.199.0.0", "54.200.0.0", "54.202.0.0", "54.204.0.0", "54.206.0.0", "54.207.0.0", "54.208.0.0",
    "54.210.0.0", "54.212.0.0", "54.214.0.0", "54.215.0.0", "54.216.0.0", "54.218.0.0", "54.219.0.0", "54.220.0.0",
    "54.221.0.0", "54.222.128.0", "54.223.0.0", "54.224.0.0", "54.226.0.0", "54.228.0.0", "54.229.0.0", "54.232.0.0",
    "54.233.0.0", "54.233.64.0", "54.233.128.0", "54.234.0.0", "54.236.0.0", "54.238.0.0", "54.241.0.0", "54.242.0.0",
    "54.244.0.0", "54.245.0.0", "54.246.0.0", "54.247.0.0", "54.248.0.0", "54.250.0.0", "54.251.0.0", "54.252.0.0",
    "54.253.0.0", "54.254.0.0", "54.255.0.0", "67.202.0.0", "72.44.32.0", "75.101.128.0", "79.125.0.0", "96.127.0.0",
    "103.4.8.0", "107.20.0.0", "122.248.192.0", "174.129.0.0", "175.41.128.0", "175.41.192.0", "176.32.64.0", "176.34.0.0",
    "176.34.32.0", "176.34.64.0", "176.34.128.0", "177.71.128.0", "184.72.0.0", "184.72.64.0", "184.72.128.0", "184.73.0.0",
    "184.169.128.0", "185.48.120.0", "204.236.128.0", "204.236.192.0", "216.182.224.0", "205.251.192.0", "54.183.255.128",
    "54.228.16.0", "54.232.40.64", "54.241.32.64", "54.243.31.192", "54.244.52.192", "54.245.168.0", "54.248.220.0",
    "54.250.253.192", "54.251.31.128", "54.252.79.128", "54.252.254.192", "54.255.254.192", "107.23.255.0", "176.34.159.192",
    "177.71.207.128", "13.32.0.0", "52.46.0.0", "52.84.0.0", "52.222.128.0", "54.182.0.0", "54.192.0.0", "54.230.0.0",
    "54.239.128.0", "54.239.192.0", "54.240.128.0", "204.246.164.0", "204.246.168.0", "204.246.174.0", "204.246.176.0",
    "205.251.192.0", "205.251.249.0", "205.251.250.0", "205.251.252.0", "205.251.254.0", "216.137.32.0")
};