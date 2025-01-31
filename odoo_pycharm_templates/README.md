# ByteCode

# Odoo PyCharm Templates

#### Link to the original source
https://github.com/mohamedmagdy/odoo-pycharm-templates

## Installation
This version use manual and bash installation.

All templates start with `od_`

### Manual installation

1. For manual installation check the original source [Source](https://github.com/mohamedmagdy/odoo-pycharm-templates)

### Bash installation

1. Clone the repo and go to this directory

2. Open install.sh file and update value of TEMPLATE_FOLDER variable to the pycharm templates path:
    
    **Linux distribution**
    * Path: `~/.PyCharm*/config/templates`

    **Mac OS X**
    * Path: `~/'Application Support'/JetBrains/PyCharm*/templates`
   
    Save and close.

3. Execute install file with +x permission

    `chmod +x install.sh`

4. Restart `PyCharmIDE`: Go to `File | Invalidate Chaches / Restart...` menu, and click in `Just Restart` button. The PyCharm IDE will be restart.