import tkinter as tk
from tkinter import ttk
import os

class Application(ttk.Frame):
    def update_version(self, major, minor):
        with open("data.typ", "r") as file:
            data = file.readlines()

        for i in range(len(data)):
            if "version = \"" in data[i]:
                current_version = data[i].split("version = \"")[1].split("\"")[0]
                major_version = int(current_version.split(".")[0])
                minor_version = int(current_version.split(".")[1])
                patch_version = int(current_version.split(".")[2])

                if major:
                    major_version += 1
                    minor_version = 0
                    patch_version = 0
                elif minor:
                    minor_version += 1
                    patch_version = 0
                else:
                    patch_version += 1

                new_version = f"{major_version}.{minor_version}.{patch_version}"
                data[i] = data[i].replace(current_version, new_version)

        print(f"Updated version from {current_version} to {new_version}")

        with open("data.typ", "w") as file:
            file.write("".join(data))

        #commit the changes
        os.system("git add data.typ")

        #add temp file to .git/info to signal the version update
        with open(".updateVersion", "w") as file:
            file.write(new_version)
        

        # quit the application
        quit()

    def __init__(self, master):
        ttk.Frame.__init__(self, master)
        self.winfo_toplevel().title("Update Version")
        self.pack()

        self.text_message = ttk.Label(self, text="Update Version?")
        self.text_message.pack(fill=tk.X)

        ttk.Separator(self, orient=tk.HORIZONTAL).pack(fill=tk.X, ipady=10)

        buttons_frame = ttk.Frame(self)
        buttons_frame.pack(side=tk.BOTTOM, fill=tk.BOTH, expand=True)

        self.button_update_major = ttk.Button(self, text="Major", command=lambda: self.update_version(True, False))
        self.button_update_major.pack(in_=buttons_frame, side=tk.LEFT)
        self.button_update_minor = ttk.Button(self, text="Minor", command=lambda: self.update_version(False, True))
        self.button_update_minor.pack(in_=buttons_frame, side=tk.LEFT)
        self.button_update_patch = ttk.Button(self, text="Patch", command=lambda: self.update_version(False, False))
        self.button_update_patch.pack(in_=buttons_frame, side=tk.LEFT)
        self.button_no = ttk.Button(self, text="No", command=quit, default=tk.ACTIVE)
        self.button_no.pack(in_=buttons_frame, side=tk.LEFT)

root = tk.Tk()

def quit():
    root.quit()

app = Application(root)

# close on enter or escape
root.bind("<Return>", lambda e: quit())

root.mainloop()