
### DNS Role

Edit various DNS settings in resolv.conf

Variable | Choices/Defaults | Type
--- | --- | ---
dns.domain|__Default:__<br>"cumulusnetworks.com"|String
dns.search_domain|__Default:__<br>  - "cumulusnetworks.com"<br>  - "nvidia.com"|List of Strings
dns.servers.ipv4|__Default:__<br>      - "1.1.1.1"<br>      - "8.8.8.8"|List of Strings
dns.servers.vrf|__Default:__<br>"mgmt"|List of Strings

##### Example 

```python
dns:
  domain: "cumulusnetworks.com"
  search_domain:
    - "cumulusnetworks.com"
  servers:
    ipv4:
      - "1.1.1.1"
      - "8.8.8.8"
    vrf: "mgmt"

```
