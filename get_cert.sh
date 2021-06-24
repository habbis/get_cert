#!/bin/sh

date >> /var/log/get_cert.log

user="myuser"

port="22"
cert_server=""
cert_location="/conf/acme"


# ssl cert and privat-key
cert="yout.crt"
key="your.key"

local_cert="your-local.crt"
local_key="your-local.key"


local_cert_location="/etc/certificates/"

get_cert()
{
scp -P $port $user@$cert_server:$cert_location/$cert  $local_cert_location


scp -P $port $user@$cert_server:$cert_location/$key  $local_cert_location

}

get_cert >>/var/log/get_cert.log 2>&1


cert_handeling()
{
cd $local_cert_location || exit

cat $cert > $local_cert

cat $key > $local_key

service nginx stop && service nginx start

}
cert_handeling  >>/var/log/get_cert.log 2>&1
