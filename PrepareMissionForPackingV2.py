import os, shutil, glob
#$root = $PSScriptRoot;

#$folderForPreparedMissions = New-Item -Path $root -Name "PreparedMissions" -ItemType "directory" -Force;

prepared_missions_path = "PreparedMissions"
templates_path = "Map-Templates"
main_data_path = "A3-Antistasi"

def blind_leading(map_name):
    def the_blind(directory, files):
        if directory.endswith("NavGrids"):
            everything_else = [x for x in files if not x.lower().endswith("{0}.sqf".format(map_name.lower()))]
            # Make sure we return all navgrids except one
            assert len(everything_else) == (len(files) - 1)
            return everything_else
        elif directory.endswith("Scripts\\Infos"):
            return files
        elif directory.endswith("JeroenArsenal\\JNL"):
            if "readme.txt" in files:
                return ["readme.txt"]
        elif directory.endswith("Templates"):
            if "Template Manual.txt" in files:
                return ["Template Manual.txt"]
        elif directory.endswith("NavGridTools"):
            if "manual.txt" in files:
                return ["manual.txt"]
        return []
    return the_blind

if os.path.exists(prepared_missions_path):
    print("Removing {0}".format(prepared_missions_path))
    try:
        shutil.rmtree(prepared_missions_path)
    except FileNotFoundError:
        print("Spooky af, first it was here now it isn't")
    else:
        print("Removed {0} and contents".format(prepared_missions_path))
else:
    print("Creating map templates to PreparedMissions")
os.mkdir("PreparedMissions")
templates = os.listdir(templates_path)
for template_ind, template in enumerate(templates, 1):
    
    print("{0}/{1}: {2}".format(template_ind, len(templates), template))

    full_path = os.path.join(templates_path, template)

    # Replace Antistasi-Altis.Altis
    # with Antistasi-Altis-MEGATON.Altis
    new_template, map_name = template.rsplit(".",1)
    new_template = "{0}-MEGATON.{1}".format(new_template, map_name)
    new_path = os.path.join(prepared_missions_path, new_template)

    ignoramus = blind_leading(map_name)

    shutil.copytree(main_data_path, new_path, ignore=ignoramus)

    # Can't use copytree again because python <=3.7 doesn't allow ignoring the existing directory
    # shutil.copytree(full_path, new_path)
    # Instead we crawl the template folder
    for fn in glob.iglob(os.path.join(full_path,"*"),recursive=True):
        # Copy directories over (see winter_chernarus)
        if os.path.isdir(fn):
            shutil.copytree(fn, os.path.join(new_path, os.path.basename(fn)))
        # Copy files to the prepared mission folder
        else:
            shutil.copy(fn, new_path)
    print(" Created template to: {0}".format(new_path))
