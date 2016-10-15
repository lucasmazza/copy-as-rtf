#!/usr/bin/python
# -*- coding: utf-8 -*-
#
# Light Clipboard management with RTF format only
#
# Based off of http://stackoverflow.com/a/3429034/334717
# and http://pywin32.hg.sourceforge.net/hgweb/pywin32/pywin32/file/4c7503da2658/win32/src/win32clipboardmodule.cpp

import sys, ctypes, getopt
from ctypes import c_int, c_char, c_char_p, c_wchar, c_wchar_p, sizeof

# Get required functions, strcpy..
strcpy = ctypes.cdll.msvcrt.strcpy
wcscpy = ctypes.cdll.msvcrt.wcscpy
ocb = ctypes.windll.user32.OpenClipboard  # Basic Clipboard functions
ecb = ctypes.windll.user32.EmptyClipboard
gcd = ctypes.windll.user32.GetClipboardData
scd = ctypes.windll.user32.SetClipboardData
if sys.version_info.major == 3:
    rcf = ctypes.windll.user32.RegisterClipboardFormatW #Unicode
else:
    rcf = ctypes.windll.user32.RegisterClipboardFormatA #ANSI
ccb = ctypes.windll.user32.CloseClipboard
ga = ctypes.windll.kernel32.GlobalAlloc    # Global Memory allocation
gl = ctypes.windll.kernel32.GlobalLock     # Global Memory Locking
gul = ctypes.windll.kernel32.GlobalUnlock
GHND = 0x0042

CF_HTML = rcf("HTML Format")
CF_RTF = rcf("Rich Text Format")
CF_RTFWO = rcf("Rich Text Format Without Objects")
CF_TEXT = 1
CF_UNICODETEXT = 13

def fillClipboard(data, plaintext=None):
    if plaintext is None:
        plaintext = data

    unicodetext = plaintext.encode('utf_16')
    data = data.encode('cp1252', 'replace')
    plaintext = plaintext.encode('cp1252', 'replace')
    ocb(None)  # Open Clip, Default task
    ecb()

    Put(data, CF_RTF)
    Put(data, CF_RTFWO)
    Put(plaintext, CF_TEXT)
    Put(unicodetext, CF_UNICODETEXT)
    ccb()

def Put(data, format):
    if format == CF_UNICODETEXT:
        hCd = ga(GHND, len(bytes(data)) + sizeof(c_char()))
    else:
        hCd = ga(GHND, len(bytes(data)) + sizeof(c_wchar()))

    pchData = gl(hCd)

    if format == CF_UNICODETEXT:
        wcscpy(c_wchar_p(pchData), bytes(data))
    else:
        strcpy(c_char_p(pchData), bytes(data))
    gul(hCd)
    scd(c_int(format), hCd)

def main():
    try:
        opts, args = getopt.getopt(sys.argv[1:], "s:")
        code = sys.stdin.read()
        source = opts[0][1]
        sys.exit(fillClipboard(code,source))
    except KeyboardInterrupt:
        sys.exit(1)
    except getopt.GetoptError as err:
        # print help information and exit:
        print(err)
        sys.exit(2)
    return 0

main()
