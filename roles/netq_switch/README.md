## netq_switch Role

Template for `/etc/netq/netq.yml`

This role updates/installes and configures the Cumulus NetQ agent packages on Cumulus Linux nodes. 

Variables for this role are stored in `[inventory-path]/group_vars/all/services.yml`

##### Example 

```python
netq:
  version: latest
  agent_server: 192.168.200.250
  cli_server: api.netq.cumulusnetworks.com
  cli_access_key: long-key-0987654321
  cli_secret_key: long-key-1234567890
  cli_premise: demo-site-1234 
  cli_port: 443
```

##### Descriptions

`version:` accepts version as MAJOR.MINOR format or `latest` string
`agent_server:` The IP/Hostname of the box that the netq agents should stream their data to. (Either the cloud aggregator or the full on-prem server)
`cli_server:` For NetQ Cloud, it is: `api.netq.cumulusnetworks.com` for NetQ On Premise deployments, it is just the NetQ server IP/Hostname
`cli_access_key:` Only needed for cloud deployments. An acceess-key string generated from the NetQ user administraton page.
`cli_secret_key:` Only needed for cloud deployments. The associated secret-key for the configured access-key. Generated from the netq user administation page
`cli_premise:` Only needed for cloud deployments. The name of the site/premise in NetQ cloud that the NetQ CLI should retieve data for.
`cli_port:` Port 443 for NetQ Cloud, 32708 for on-prem
