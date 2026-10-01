
### Syslog Role

Configure Syslog

Variable | Choices/Defaults | Type
--- | --- | ---
syslog.servers|__Default:__<br>No remote servers are defined by default.|List of Strings

##### Example 

```python
syslog:
  servers:
    - "192.168.200.1"
```
