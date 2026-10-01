
### NTP Role

Configure Network Time Protocol

Variable | Choices/Defaults | Type
--- | --- | ---
ntp.timezone|__Default:__<br>"Etc/UTC"|String
ntp.server_ips|__Default:__<br>      - "0.cumulusnetworks.pool.ntp.org"<br>      - "1.cumulusnetworks.pool.ntp.org"<br>      - "2.cumulusnetworks.pool.ntp.org"<br>      - "3.cumulusnetworks.pool.ntp.org"|List of Strings

##### Example 

```python
ntp:
  timezone: America/Los_Angeles
  server_ips:
    - 0.cumulusnetworks.pool.ntp.org
    - 1.cumulusnetworks.pool.ntp.org
    - 2.cumulusnetworks.pool.ntp.org
    - 3.cumulusnetworks.pool.ntp.org
```
