#!/usr/bin/env python3
import json, subprocess, os

out = subprocess.check_output(["kitty", "@", "ls"])
sessions = json.loads(out)

conf = []
for os_window in sessions:
    for tab in os_window["tabs"]:
        conf.append("new_tab title {}".format(tab["title"]))
        for window in tab["windows"]:
            cwd = window["cwd"]
            cmd = " ".join(window["argv"])
            conf.append(f"cd {cwd}")
            conf.append(f"launch {cmd}")

conf_path = os.path.expanduser("~/.config/kitty/mysession.conf")
with open(conf_path, "w") as f:
    f.write("\n".join(conf) + "\n")

print("Session saved to", conf_path)
