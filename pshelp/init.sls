{%- from "pshelp/map.jinja" import pshelp with context %}

Create pshelp cache directory:
  file.directory:
    - name: '{{ pshelp.cachedir }}'
    - makedirs: True

Copy pshelp files:
  file.recurse:
    - name: '{{ pshelp.cachedir }}'
    - source: salt://{{ tpldir }}/files/pshelp-content
    - require:
        - file: Create pshelp cache directory

UpdatePSHelp:
  cmd.run:
    - name: 'Update-Help -SourcePath {{ pshelp.cachedir }} -Module (Get-Module -ListAvailable | Where HelpInfoUri) -Force'
    - shell: powershell
    - require:
        - file: Copy pshelp files
    - onlyif: 'if ($($PSVersiontable.PSVersion.Major) -ge 3) { return 0 } else { throw }'
