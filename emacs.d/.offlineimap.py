import subprocess
import re
import os

def getgpgpassword(account):
    path = "/Users/jameskent/.mail-%s-passwd.gpg" % account
    return subprocess.check_output(["gpg", "--quiet", "--batch", "-d", path]).strip()

def get_password_emacs(machine, login, port):
    s = "machine %s login %s port %s password ([^ ]*)\n" % (machine, login, port)
    p = re.compile(s)
    authinfo = os.popen("gpg -q --no-tty -d ~/.authinfo.gpg").read()
    return p.search(authinfo).group(1)
