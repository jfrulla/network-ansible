### Servers Role

Configure Ubuntu Servers for testing

##### Example 

```python
devices:
  server01:
    bond:
      vlan: 10
      ip: 10.1.10.101/24
      route:
        dest: 10.0.0.0/8
        nexthop: 10.1.10.1
ntp:
  timezone: America/Los_Angeles
  server_ips:
    - 0.cumulusnetworks.pool.ntp.org
    - 1.cumulusnetworks.pool.ntp.org
    - 2.cumulusnetworks.pool.ntp.org
    - 3.cumulusnetworks.pool.ntp.org

```

