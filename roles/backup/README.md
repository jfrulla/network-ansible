
### Backup Role
Backup config files to the [config dir](config) on the ansible "server"

Variable | Choices/Defaults | Type
--- | --- | ---
backup.path|__Default:__<br>"../inventories/{{ fabric_name }}/config/{{ inventory_hostname }}"|String
backup.files|__Default:__<br>backup.files:<br>  - "/etc/network/interfaces"<br>  - "/etc/frr/frr.conf"<br>- "/etc/frr/daemons"|List of Strings

##### Example 

```python
backup
  path: "../inventories/{{ fabric_name }}/config/{{ inventory_hostname }}"
  files:
    - "/etc/network/interfaces"
    - "/etc/frr/frr.conf"
    - "/etc/frr/daemons"
```
