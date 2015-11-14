'''
Two examples work with decaritors in Python
The code bellows provide non-parameters decorator functionality.
'''
def hashes(fn):
    def wrapped():
        return "#" + fn() + "#"
    return wrapped


@hashes
def Hi():
    return "Hello, Rasim"

print Hi()

'''
The next decorator force function return her result, or
<Rasim, Gum> depending on arguments.
'''
def hashes2(fn):
    def wrapped(kefal):
        if kefal == 0:
            return "Gum"
        elif kefal == 1:
            return "Rasim"
        else:
            return kefal
    return wrapped

@hashes2
def Ola_ola(kefal):
    return "Hi, my %s" % kefal

print Ola_ola(0)

''' Decorator with parameters below:'''
def tag(name):
    def decorator(fun_hello):
        def inner(who):
            return "<%s> %s </%s>" % (name, fun_hello(who), name)
        return inner
    return decorator

@tag("b")
def hello(who):
    return "Hello", who

print hello("rasim")
