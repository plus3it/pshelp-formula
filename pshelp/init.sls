{%- from "pshelp/map.jinja" import pshelp with context %}

Copy pshelp files:
  file.recurse:
    - name: '{{ pshelp.cachedir }}'
    - source: salt://{{ tpldir }}/content
    - makedirs: True

UpdatePSHelp:
  cmd.run:
    - name: 'Update-Help -SourcePath {{ pshelp.cachedir }} -Module (Get-Module -ListAvailable | Where HelpInfoUri) -Force'
    - shell: powershell
    - require:
        - file: Copy pshelp files
    - onlyif: 'if ($($PSVersiontable.PSVersion.Major) -ge 3) { return 0 } else { throw }'
