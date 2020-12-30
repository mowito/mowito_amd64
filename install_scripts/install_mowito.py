#!/usr/bin/env python3
import json
import os
import sys
import subprocess
import argparse
import string
import time

def process_metadata(metadata):
    try:
        ros_version = metadata['ros-version']
        ubuntu_version = metadata['ubuntu-version']
        arch = metadata['arch']

        prefix = 'ros-' + ros_version + '-'
        suffix = '0' + ubuntu_version + '_' + arch + '.deb'

        return prefix,suffix

    except:
        raise ValueError('metadata info not found!')

def display_fail(error_string,package_name,num_installed,total):
    print('\033[1m'+'\033[91m'+'\n',package_name,' << Failed')
    error_msg = str(num_installed) + ' out of '+ str(total)+' packages installed\n'
    print(error_msg)
    print(error_string)
    print('Install unsuccessful')
    print('\033[0m')
    subprocess.call(['notify-send','Mowito Setup Failed',error_msg])
    subprocess.Popen(["tput","cnorm"])

def display_success(package_name):
    print('\033[1m'+'\033[92m'+'\n',package_name,' << Installed')
    print('\033[0m')

def display_fancy_msg(display_msg):
    print ("====================================")
    print (display_msg)
    print ("====================================")


def main():
    parser = argparse.ArgumentParser(prog='install_mowito.py',description='mowito setup')
    parser.add_argument('rosversion',choices=['kinetic','melodic','noetic'],help='Version of ROS installed')
    parser.add_argument('arch',choices=['amd64','arm64'],help='Architecture')
    parser.add_argument('skip_depend',nargs='?',type=str,help='Skip installing dependencies')
    parser.add_argument('path',  nargs='?',type=str,help='/path/to/package/list.json')


    args = parser.parse_args()
    list_path = args.path
    if(list_path):
        if os.path.exists(list_path):
            file_name = list_path
    else:
        file_name = '/setup-' + args.rosversion + '-' + args.arch + '.json'

    install_script_dir = os.path.dirname(os.path.abspath(__file__))

    subprocess.Popen(["tput","civis"])

    #if skip dependecies is not true, install dependencies
    if (args.skip_depend != 'True'):

        # install dependencies from dependencies.json
        with open(install_script_dir+"/dependencies.json", "r") as read_file:
            dep_list = json.load(read_file)

        installed = 0

        display_fancy_msg('Install Dependencies')

        for dep in dep_list:
            start = time.time()
            install_package = 'ros-'+args.rosversion+'-'+dep['package']
            # print("sudo "+dep['install']+" install "+install_package+" -y")
            proc = subprocess.Popen(["sudo","apt-get","install",install_package,"-y"],stdin=subprocess.PIPE,stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            while (proc.poll() == None):
                print('\r',dep['package'],' >> Installing  ' , '[', '{0:.2f}'.format(time.time()-start), 's ]', end='', flush=True)

            output, err = proc.communicate()

            if(err.decode()):
                    display_fail(err.decode(),dep['package'],installed,len(dep_list)-1)
                    sys.exit(1)
                    
            else:
                installed = installed + 1
                display_success(dep['package'])

        print('\033[92m'+'Dependencies installed successfully!')
        print('\033[0m')


    #Install mowito packages
    display_fancy_msg('Install Mowito Packages')

    with open(install_script_dir+file_name, "r") as read_file:
        pkg_list = json.load(read_file)

    deb_folder = os.path.dirname(install_script_dir) + '/debians'

    try:
        deb_prefix, deb_suffix = process_metadata(pkg_list[0]['metadata'])
    except:
        raise ValueError('metadata not found!')

    
    installed = 0
    for item in pkg_list[1:]:
        deb_path = deb_folder + '/' + deb_prefix + item['package'] + '_' + item['version'] + '-' + deb_suffix
        if not os.path.exists(deb_path):
            subprocess.Popen(["tput","cnorm"])
            err_msg = 'E: Cannot find path:'+ deb_path +'\n'
            display_fail(err_msg,item['package'],installed,len(pkg_list)-1)
            sys.exit(1)
        else:
            start = time.time()
            proc = subprocess.Popen(["sudo","dpkg","-i",deb_path],stdin=subprocess.PIPE,stdout=subprocess.PIPE, stderr=subprocess.PIPE)

            while (proc.poll() == None):
                print('\r',item['package'],' >> Installing  ' , '[', '{0:.2f}'.format(time.time()-start), 's ]', end='', flush=True)

            output, err = proc.communicate()

            if(err.decode()):
                display_fail(err.decode(),item['package'],installed,len(pkg_list)-1)
                sys.exit(1)
                
            else:
                installed = installed + 1
                display_success(item['package'])
                

    success_msg = str(installed) + ' out of '+ str(len(pkg_list)-1)+' packages installed'
    print('\033[92m'+success_msg)
    subprocess.call(['notify-send','Mowito setup successful',success_msg])
    print('\033[0m'+'Install successful')
    subprocess.Popen(["tput","cnorm"])



if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        subprocess.Popen(["tput","cnorm"])
        sys.exit(0)
