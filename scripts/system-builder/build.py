#! /usr/bin/env python3

from collections import namedtuple
from pathlib import Path
from subprocess import run
from sys import argv, exit, stdin, stderr


Config = namedtuple('Config', ['target', 'features'])


def parse_config(config_file):
    # First line names the target
    target = config_file.readline().rstrip()
    # which gets all following lines
    lines = config_file.read().splitlines()
    config_file.close()
    # except empty and comment lines
    features = [l for l in lines if not (l == '' or l.startswith('#'))]
    return Config(target, features)


def build(src_dir_path, out_dir_path, config):
    # Dispatch to named target.
    # Handle errors.

    ok_targets = {
        'Piccolo': build_bsc,
        'Flute': build_bsc,
        'Rocket': build_rocket,
    }

    builder = ok_targets.get(config.target)
    if builder is None:
        stderr.write("ERROR: Target '{}' not supported; use one of {}.\n".format(
            config.target, list(ok_targets.keys())))
        exit()

    # The output dir will be written to from within the source dir.
    src_dir_path = src_dir_path.expanduser().resolve().absolute()
    out_dir_path = out_dir_path.expanduser().resolve().absolute()
    if not src_dir_path.is_dir():
        stderr.write('ERROR: Directory {} not found.\n'.format(
                src_dir_path))
        exit()
    if out_dir_path.exists():
        stderr.write(('ERROR: Not overwriting existing {}\n'
            + 'Please name a new output directory.\n').format(
                out_dir_path))
        exit()

    try:
        builder(src_dir_path, out_dir_path, config.features)
    except AssertionError as err:
        # If a builder raises this, it should supply a message.
        stderr.write('ERROR: {}\n'.format(err.args[0]))
        exit()


def build_bsc(src_dir_path, out_dir_path, features):
    # Compile .bsv to .v sources.

    topline = features.pop(0).split('=')
    topline_ok = (len(topline) == 2
        and topline[0].strip().upper() == 'TOPFILE'
        and topline[1].strip() != '')
    assert topline_ok, "Missing or malformed 'TOPFILE=...' feature."
    topfile = topline[1].strip()

    p_dirs, d_flags = [], []
    for line in features:
        if line.startswith(':'):
            p_dirs.append(line.lstrip(':'))
        else:
            d_flags.append(line)

    bsc_path = '-p ' + ':'.join([
        'src_Core/CPU',
        'src_Core/ISA',
        'src_Core/RegFiles',
        'src_Core/Core',
        'src_Core/Near_Mem_VM',
        'src_Core/PLIC',
        'src_Core/Near_Mem_IO',
        'src_Core/Debug_Module',
        'src_Core/BSV_Additional_Libs',
        ] + p_dirs + [
        'src_Testbench/Fabrics/AXI4',
        '+',
        '%/Libraries/TLM3',
        '%/Libraries/Axi',
        '%/Libraries/Axi4',
    ])

    fixed_flags = ' '.join([
        '-keep-fires',
        '-aggressive-conditions',
        '-no-warn-action-shadowing',
        # '-no-show-timestamps',  # in Makefiles, but not in bsc 2017.07.A?
        '-check-assert',
        '-suppress-warnings G0020',
        '+RTS',
        '-K128M',
        '-RTS',
        '-show-range-conflict',
    ])

    build_dir = out_dir_path / 'build'
    build_dir.mkdir(parents=True)

    cmd = 'bsc -u -elab -verilog {rtl_gen_dirs}  {fixed_flags}  {d_flags}  {bsc_path}  {topfile}'.format(
        rtl_gen_dirs='-vdir {}  -bdir {}  -info-dir {}'.format(
            out_dir_path, build_dir, build_dir),
        fixed_flags=fixed_flags,
        # Every Piccolo or Flute feature is a -D flag passed to bsc.
        d_flags='-D ' + ' -D '.join(d_flags),
        bsc_path=bsc_path,
        topfile=topfile)
    print('In working directory {}:'.format(src_dir_path))
    print('Running build command:')
    print(cmd)
    result = run(cmd, cwd=src_dir_path, shell=True)
    if result.returncode != 0:
        stderr.write('ERROR: BSC build failed with return code {}.\n'.format(result.returncode))
        exit(1)
    else:
        # Remove build dir on success
        for p in build_dir.iterdir():
            p.unlink()
        build_dir.rmdir()


def build_rocket(src_dir_path, out_dir_path, features):
    # Compile Chisel for a Rocket variant into Verilog.
    # See ../rocket-chip-build and 
    pass

def build_boom(src_dir_path, out_dir_path, features):
    raise NotImplementedError

def build_verilator(src_dir_path, out_dir_path, features):
    # Build a simulator executable.
    # Options: JTAG, tracing, coverage, ... ?
    # Implemented in gfe/verilator_simulators/ for {bluespec,chisel}_{p1,p2}
    pass

def build_vivado(src_dir_path, out_dir_path, features):
    # Build a bitstream.
    # What is there to configure here? TV?
    # Implemented in gfe/setup_soc_project.sh,build.sh
    pass

def build_freertos(src_dir_path, out_dir_path, features):
    # Build a FreeRTOS image.
    # Configurable features? Feature model?
    raise NotImplementedError

def build_debian(src_dir_path, out_dir_path, features):
    # Build a Debian Linux image.
    # What do we want to configure? Packages? Devices? Unpackaged apps?
    # We would have to provide a feature model.
    raise NotImplementedError

def build_busybox(src_dir_path, out_dir_path, features):
    # Build a Busybox Linux image.
    raise NotImplementedError


if __name__ == '__main__':
    try:
        me, src_dir, out_dir, cfg = argv
        src_dir_path = Path(src_dir)
        out_dir_path = Path(out_dir)
        if cfg == '-':
            config_file = stdin
        else:
            config_path = Path(cfg)
            assert config_path.is_file()
            config_file = open(config_path)
    except (ValueError, AssertionError):
        print('Usage: {} <build source dir> <output dir> <config file or - for stdin>'.format(argv[0]))
        exit()

    config = parse_config(config_file)
    build(src_dir_path, out_dir_path, config)
