import argparse, os, time, subprocess

def get_args():
    parser = argparse.ArgumentParser(prog='generate-diagram')
    parser.add_argument(
        'diagram', 
        metavar='DIAGRAM', 
        type=os.path.abspath,
        help='Path to diagram code'
    )
    opts = parser.parse_args()
    return opts

args = get_args()

diagram_path = args.diagram
_cached_stamp = 0

while True:
    time.sleep(3)
    stamp = os.stat(diagram_path).st_mtime
    
    if stamp != _cached_stamp:
        print("File changed. Re-loading diagram.")
        _cached_stamp = stamp
        subprocess.run(["python", f"{diagram_path}"])
        print("... Done.")
