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


def main():
    parser = argparse.ArgumentParser(prog='install_mowito.py',description='mowito setup')
    parser.add_argument('rosversion',choices=['kinetic','melodic','noetic'],help='Version of ROS installed')
    parser.add_argument('arch',choices=['amd64','arm64'],help='Architecture')
    parser.add_argument('path',  nargs='?',type=str,help='/path/to/package/list.json')


    args = parser.parse_args()
    list_path = args.path
    if(list_path):
        if os.path.exists(list_path):
            file_name = list_path
    else:
        file_name = '/setup-' + args.rosversion + '-' + args.arch + '.json'

    install_script_dir = os.path.dirname(os.path.abspath(__file__))
    with open(install_script_dir+file_name, "r") as read_file:
        pkg_list = json.load(read_file)

    deb_folder = os.path.dirname(install_script_dir) + '/debians'

    try:
        deb_prefix, deb_suffix = process_metadata(pkg_list[0]['metadata'])
    except:
        raise ValueError('metadata not found!')

    installed = 0
    subprocess.Popen(["tput","civis"])
    for item in pkg_list[1:]:
        deb_path = deb_folder + '/' + deb_prefix + item['package'] + '_' + item['version'] + '-' + deb_suffix
        if not os.path.exists(deb_path):
            print('\033[91m')
            subprocess.Popen(["tput","cnorm"])
            raise Exception('Cannot find path:', deb_path)
        else:
            start = time.time()
            proc = subprocess.Popen(["sudo","dpkg","-i",deb_path],stdin=subprocess.PIPE,stdout=subprocess.PIPE, stderr=subprocess.PIPE)

            while (proc.poll() == None):
                print('\r',item['package'],' >> Installing  ' , '[', '{0:.2f}'.format(time.time()-start), 's ]', end='', flush=True)

            output, err = proc.communicate()

            if(err.decode()):
                print('\033[91m'+'\n',item['package'],' << Failed')
                error_msg = str(installed) + ' out of '+ str(len(pkg_list)-1)+' packages installed'
                print(error_msg)
                print('[ERROR]: ', err.decode())
                print('Install unsuccessful')
                subprocess.call(['notify-send','Mowito Setup Failed',error_msg])
                subprocess.Popen(["tput","cnorm"])
                sys.exit(1)
            else:
                installed = installed + 1
                print('\033[1m'+'\033[92m'+'\n',item['package'],' << Installed')
                print('\033[0m')

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
        sys.exit(1)
