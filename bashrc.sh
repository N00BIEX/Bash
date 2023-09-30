#using termux 
#opening directory of project
# l {your_path}
l(){
    val=$1
    cd //storage/emulated/0/djangotut/$val
    ls
}

#starting live server as live server is being early installed
#tutorial for downloading live server
#https://github.com/brunodavi/termux-live-server
#execution : live-s {ip_address} {port}
live-s(){
    ip="${1:-127.0.0.1}"
    port="${2:-8080}"
    echo -e "server starting....\ndirectory : "
    pwd
    live-server --host=${ip} --port=${port}
}

#starting django server
#projects should be there and django should be properly installed 
#execution : s {your_path} {ip_address} {port}
s() {
    storage="$1"
    storage="${storage:-anubhav/MyBlog}"
    ip="$2"
    ip="${ip:-127.0.0.1}"
    port="$3"
    port="${port:-8000}"
    cd /storage/emulated/0/djangotut/"${storage}"
    echo -e "directory :"
    pwd
    echo -e "\ndone\n Starting Server...."
    python manage.py runserver "${ip}:${port}"
}
