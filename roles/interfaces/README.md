
### Interfaces Role

Ansible template module for `/etc/network/interfaces` on Cumulus Linux using ifupdown2.

### Tasks

* Set MTU to 9216 by default on all ports excluding eth0 which is set to 1500 MTU.
* Template `/etc/network/interfaces` (ifupdown2 config file)
* Reload networking (`ifreload -a`) after verifying with `ifup -a -s -i /etc/network/interfaces`

##### Example of a border leaf

Border01 interfaces variables
```python
loopback:
  ips:
    - "{{vxlan_local_loopback_subnet}}.63/32"
  vxlan_local_tunnel_ip: "{{vxlan_local_loopback_subnet}}.63"
  clag_vxlan_anycast_ip: "{{vxlan_anycast_loopback_subnet}}.254"
interfaces:
  - { name: swp51, profile: "{{ leaf_spine_interface }}" }
  - { name: swp52, profile: "{{ leaf_spine_interface }}" }
  - { name: swp53, profile: "{{ leaf_spine_interface }}" }
  - { name: swp54, profile: "{{ leaf_spine_interface }}" }
vnis:
  - "{{ vniRED_leaf }}"
  - "{{ vniBLUE_leaf }}"
bridge:
  vids:
    - 4001
    - 4002
mlag:
  sysmac: "{{mlag_sysmac_prefix}}:FF"
  priority: primary
  peerlinks: [ swp49, swp50 ]
  backup: "{{vxlan_local_loopback_subnet}}.64"
  bonds:
    - { profile: "{{ mlagBondProfileFW }}", name: bond3, ports: [swp3], id: 1 }
vlans:
  - "{{ leaf_vlan4001 }}"
  - "{{ leaf_vlan4002 }}"
vrf:
  - "{{ vrf_RED }}"
  - "{{ vrf_BLUE }}"
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
mlagBondProfileFW:
  bridge_vids: [10, 20, 30]
  extras:
    - "bond-lacp-bypass-allow yes"
    - "mstpctl-bpduguard yes"
    - "mstpctl-portadminedge yes"
leaf_vlan4001:
  name: vlan4001
  id: 4001
  vrf: RED
  hwaddress: "{{ mlag.sysmac }}"
leaf_vlan4002:
  name: vlan4002
  id: 4002
  vrf: BLUE
  hwaddress: "{{ mlag.sysmac }}"
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
