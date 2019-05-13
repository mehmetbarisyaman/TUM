
import pytest
import os
import sys


def complementary(elements):
    numberofchars = len(elements)
    outs = ""
    for i in range(numberofchars):
        x = elements[i]
        if x == 'G':
            x = 'C'
        elif x == 'C':
            x = 'G'
        elif x == 'T':
            x = 'A'
        elif x == 'A':
            x = 'T'
        outs = outs + x
    print("OUTS " + outs)
    return outs




