
### MOTD Role

Configure Message of the Day and Banner for SSH connections

Variable | Choices/Defaults | Type
--- | --- | ---
ssh.motd|__Default:__<br>"#########################################################<br>Successfully logged in to: {{ inventory_hostname }}<br>#########################################################"|String
ssh.banner|__Default:__<br>"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!<br>Authorized Users Only!<br>!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"|String

##### Example 

```python
ssh:
  motd: |
    #########################################################
<<<<<<< HEAD
    Successfully logged in to: {{ inventory_hostname }}
    #########################################################
  banner: |
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    Authorized Users Only!
=======
    Welcome to {{ inventory_hostname }}
    #########################################################
  banner: |
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    This system is monitored. Unauthorized access prohibited.
>>>>>>> nmitchell-readme
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
```
