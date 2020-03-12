import re
import subprocess
import sys

OUTPUT_RE = re.compile(r'([0-9.]*) \(([0-9.]*)\)')

def main(path1, path2, threshold):
    p = subprocess.run(('compare', '-metric', 'RMSE', path1, path2, 'null:'),
            stderr=subprocess.PIPE)
    out = p.stderr.decode('utf-8')
    m = OUTPUT_RE.match(out)
    if not m:
        print('failed to parse `compare` output: %r' % out)
        sys.exit(1)
    err_amount = float(m.group(1))

    if err_amount <= threshold:
        sys.exit(0)
    else:
        sys.exit(1)

if __name__ == '__main__':
    path1, path2, threshold_str = sys.argv[1:]
    main(path1, path2, float(threshold_str))


