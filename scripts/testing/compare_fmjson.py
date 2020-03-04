import json
import sys


ERROR_COUNT = 0
def err(msg):
    global ERROR_COUNT
    print('error: ' + msg)
    ERROR_COUNT += 1

def compare_sets(x1, x2):
    x1 = set(x1)
    x2 = set(x2)
    x1_only = x1 - x2
    x2_only = x2 - x1
    if x1_only:
        err('%d entries exist only in file 1: %s' % (len(x1_only), x1_only))
    if x2_only:
        err('%d entries exist only in file 2: %s' % (len(x2_only), x2_only))

def matching_entries(dct1, dct2):
    compare_sets(dct1.keys(), dct2.keys())

    for k, v1 in dct1.items():
        if k in dct2:
            v2 = dct2[k]
            yield k, v1, v2

def deep_freeze(x):
    if isinstance(x, (list, tuple)):
        return tuple(deep_freeze(y) for y in x)
    elif isinstance(x, set):
        return frozenset(deep_freeze(y) for y in x)
    elif isinstance(x, dict):
        return tuple(sorted((deep_freeze(k), deep_freeze(v)) for k,v in x.items()))
    else:
        return x

def compare_features(fs1, fs2):
    for name, f1, f2 in matching_entries(fs1, fs2):
        for k, v1, v2 in matching_entries(f1, f2):
            if k in ('card', 'gcard', 'name', 'parent'):
                if v1 != v2:
                    err('feature %s: %s mismatch: %s != %s' % (name, k, v1, v2))
            elif k == 'children':
                compare_sets(v1, v2)
            else:
                err('feature %s: unknown key %s' % (name, k))

def main(path1, path2):
    with open(path1) as f:
        j1 = json.load(f)
    with open(path2) as f:
        j2 = json.load(f)

    for k, v1, v2 in matching_entries(j1, j2):
        if k == 'version':
            if v1 != v2:
                err('version mismatch: %s != %s' % (v1, v2))
        elif k == 'roots':
            compare_sets(v1, v2)
        elif k == 'constraints':
            compare_sets(deep_freeze(v1), deep_freeze(v2))
        elif k == 'features':
            compare_features(v1, v2)
        else:
            err('unknown key %s' % k)

    if ERROR_COUNT == 0:
        sys.exit(0)
    else:
        sys.exit(1)

if __name__ == '__main__':
    path1, path2 = sys.argv[1:]
    main(path1, path2)


