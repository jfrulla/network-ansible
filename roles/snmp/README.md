
### SNMP Role

Configure Simple Network Management Protocol

Variable | Choices/Defaults | Type
--- | --- | ---
snmp.addresses|__Default:__<br>      - "{{ hostvars[inventory_hostname]['ansible_eth0']['ipv4']['address'] }}@mgmt"<br>      - "udp6:[::1]:161"|List of Strings
snmp.rocommunity|__Default:__<br>"public"|String

##### Example 

```python
snmp:
  addresses:
    - "192.168.1.101@mgmt"
    - "udp6:[::1]:161"
  rocommunity: "readonly"
```
