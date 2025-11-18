# An example of a custom kitten
# Use as a starting point for your own kittens
from kittens.tui.handler import result_handler


def main(args):
    # Return immediately, no UI input needed.
    return None


@result_handler(no_ui=True)
def handle_result(args, result, target_window_id, boss):
    window = boss.window_id_map.get(target_window_id)
    if window is None:
        return

    window.write_to_child(b"#\n#--- Kitty Foreground Processes ---\n")

    for p in window.child.foreground_processes:
        cmd = p["cmdline"][0] if p["cmdline"] else "<no cmd>"
        window.write_to_child(f"#pid={p['pid']}  cmd={cmd}\n".encode())

    window.write_to_child(b"#----------------------------------\n\n")
    window.set_window_title("Foreground Processes Printed")
