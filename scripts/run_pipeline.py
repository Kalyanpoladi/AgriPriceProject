"""
AgriPrice Project - Pipeline Runner
Runs cleaning + loading, writes a timestamped log.
"""
import subprocess
import datetime
from pathlib import Path

BASE = Path(r"C:\Users\polad\Documents\MyProjects\AgriPriceProject")
LOGDIR = BASE / "logs"
LOGDIR.mkdir(exist_ok=True)

stamp = datetime.datetime.now().strftime("%Y_%m_%d_%H_%M")
log = LOGDIR / ("pipeline_" + stamp + ".log")

steps = [
    "scripts/clean_agri_data.py",
    "scripts/load_to_mysql.py",
]

with open(log, "w") as f:
    print("=== PIPELINE STARTED ===")
    f.write("=== PIPELINE STARTED ===\n")
    for step in steps:
        print(">>> Running:", step)
        result = subprocess.run(
            ["python", step],
            cwd=BASE,
            capture_output=True,
            text=True
        )
        print(result.stdout)
        if result.stderr:
            print(result.stderr)
        f.write("STEP: " + step + "\n")
        f.write(result.stdout)
        f.write(result.stderr)
        if result.returncode != 0:
            print("!!! FAILED at:", step)
            f.write("!!! FAILED\n")
            break
    else:
        print("=== PIPELINE FINISHED: ALL STEPS OK ===")
        f.write("=== PIPELINE FINISHED: ALL STEPS OK ===\n")

print("Log saved to:", log)
