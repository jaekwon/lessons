#!/usr/bin/python

import sys
print '\n'.join(['3:'+line[:-1] for line in sys.stdin.readlines()])
