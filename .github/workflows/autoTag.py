import os

#look for the temp file in .git/info (.updateVersion)
if os.path.exists(".updateVersion"):
    with open(".updateVersion", "r") as file:
        new_version = file.read().strip()

    #remove the temp file
    os.remove(".updateVersion")

    #tag the commit
    os.system(f"git tag -a v{new_version} -m 'Version {new_version}'")