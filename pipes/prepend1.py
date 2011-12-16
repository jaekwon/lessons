#!/usr/bin/python

import sys
print '\n'.join(['1:'+line[:-1] for line in sys.stdin.readlines()])
