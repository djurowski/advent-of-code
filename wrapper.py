import subprocess
import sys

def run_powershell_script(script_path, *args):
    command = ["powershell", "-File", script_path] + list(args)
    try:
        result = subprocess.run(command, capture_output=True, text=True, check=True)
        print(result.stdout)
    except subprocess.CalledProcessError as e:
        print(f"Error running PowerShell script: {e}", file=sys.stderr)
        print(e.stderr, file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python script.py <path_to_powershell_script> [args...]", file=sys.stderr)
        sys.exit(1)
    
    powershell_script = sys.argv[1]
    script_args = sys.argv[2:]
    
    run_powershell_script(powershell_script, *script_args)