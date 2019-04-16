# Source information for inportlib.import_module:
#     https://docs.python.org/3/library/functions.html#__import__
#     https://docs.python.org/3/library/importlib.html
#     https://pymotw.com/3/importlib/
def import_and_reload_if_necessary(filename):
    import sys
    import importlib

    # https://stackoverflow.com/questions/30483246/how-to-check-if-a-python-module-has-been-imported
    if filename in sys.modules:
        m = importlib.import_module(filename)
        importlib.reload(m)
    else:
        importlib.import_module(filename)
