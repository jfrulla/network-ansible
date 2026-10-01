
### FRR Role

Ansible template module for `/etc/frr/frr.conf` and `/etc/frr/daemons` on Cumulus Linux using FRR.

### Tasks

* Copy module to set `/etc/frr/daemons` then restart frr daemon `systemctl restart frr` if  `/etc/frr/daemons` has changed.
* Template `/etc/frr/frr.conf` (FRR config file)
* Reload FRR using `systemctl reload frr` after verifying the newly pushed FRR config with `vtysh -f /etc/frr/frr.conf --dryrun`

##### Example of a border leaf

Border01 FRR variables
```python
vrf:
  - name: RED
    vxlan_id: 4001
  - name: BLUE
    vxlan_id: 4002
bgp:
  asn: "65132"
  router_id: "10.10.10.63"
  peergroups:
    - { name: underlay, remote_as: external }
  neighbors:
    - { interface: peerlink.4094, unnumbered: yes, remote_as: internal }
    - { interface: swp51, unnumbered: yes, peergroup: underlay }
    - { interface: swp52, unnumbered: yes, peergroup: underlay }
    - { interface: swp53, unnumbered: yes, peergroup: underlay }
    - { interface: swp54, unnumbered: yes, peergroup: underlay }
  extras:
    - "bgp bestpath as-path multipath-relax"
  address_family:
    - name: ipv4_unicast
      redistribute:
        - { type: connected }
    - name: l2vpn_evpn
      neighbors:
        - { interface: underlay, activate: yes }
      advertise_all_vni: yes
  vrfs:
    - name: RED
      router_id: "10.10.10.63"
      extras:
        - "bgp bestpath as-path multipath-relax"
      address_family:
        - name: ipv4_unicast
          redistribute:
            - { type: static }
        - name: l2vpn_evpn
          extras:
            - "advertise ipv4 unicast"
    - name: BLUE
      router_id: "10.10.10.63"
      extras:
        - "bgp bestpath as-path multipath-relax"
      address_family:
        - name: ipv4_unicast
          redistribute:
            - { type: static }
        - name: l2vpn_evpn
          extras:
            - "advertise ipv4 unicast"
```

Reused Variables
```python
vxlan_local_loopback_subnet: 10.10.10
vxlan_anycast_loopback_subnet: 10.0.1
mlag_sysmac_prefix: 44:38:39:BE:EF
leaf_spine_interface:
  name: leaf_spine
  extras:
    - "alias leaf to spine"
vniRED_leaf:
  name: vniRED
  vlan_id: 4001
  vxlan_id: 4001
  extras:
    - "mstpctl-portbpdufilter yes"
    - "mstpctl-bpduguard yes"
    - "bridge-learning off"
    - "bridge-arp-nd-suppress on"
vniBLUE_leaf:
  name: vniBLUE
  vlan_id: 4002
  vxlan_id: 4002
  extras:
    - "mstpctl-portbpdufilter yes"
    - "mstpctl-bpduguard yes"
    - "bridge-learning off"
    - "bridge-arp-nd-suppress on"
vrf_RED:
  name: RED
  vxlan_id: 4001
vrf_BLUE:
  name: BLUE
  vxlan_id: 4002
```
