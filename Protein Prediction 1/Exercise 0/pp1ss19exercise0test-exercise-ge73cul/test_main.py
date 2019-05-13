import main

import pytest
import os
import sys

@pytest.yield_fixture(scope="function")
def silence_printing(pytestconfig):
    # Disable capturing so printing can be disabled
    # See https://github.com/pytest-dev/pytest/issues/1599
    # Unfortunately that does not seem to work yet (promising fix in the dev-code) 
    # -> the -s option is really our only choice here
    # The way to really reduce the output would be to use --tb=line
    # Additionally, we should use pytest-timeout and set a timeout globally
    # Hence we should run:
    # pytest -q -s --disable-warning --show-capture=no --tb=line --timepit 60 --junitxml=<path>
    capmanager = pytestconfig.pluginmanager.getplugin('capturemanager')
    context = capmanager.suspend_global_capture()

    # Redirect stdout to /dev/null
    old_out = sys.stdout
    old_err = sys.stderr
    sys.stdout = open(os.devnull, 'w')
    sys.stderr = open(os.devnull, 'w')
    yield silence_printing

    # Restore standard functionality
    sys.stdout = old_out
    sys.stderr = old_err
    capmanager.resume_global_capture()


def test_a(silence_printing):
    func_res = str(main.complementary('A')).upper()
    test_res = func_res == 'T'
    assert test_res


def test_t(silence_printing):
    func_res = str(main.complementary('T')).upper()
    test_res = func_res == 'A'
    assert test_res


def test_g(silence_printing):
    func_res = str(main.complementary('G')).upper()
    test_res = func_res == 'C'
    assert test_res


def test_c(silence_printing):
    func_res = str(main.complementary('C')).upper()
    test_res = func_res == 'G'
    assert test_res


def test_complete(silence_printing):
    func_res = str(main.complementary('ATGC')).upper()
    test_res = func_res == 'TACG'
    assert test_res

def test_complete_2(silence_printing):
    func_res = str(main.complementary('CGTA')).upper()
    test_res = func_res == 'GCAT'
    assert test_res

def test_complete_long(silence_printing):
    func_res = str(main.complementary('AGTCATCGTTAGGCCAT')).upper()
    test_res = func_res == 'TCAGTAGCAATCCGGTA'
    assert test_res