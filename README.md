# network-ansible

Ansible infrastructure for configuring the [Cumulus Linux](https://www.nvidia.com/en-us/networking/ethernet-switching/cumulus-linux/) ethernet switch fabric of the University of Washington [Hyak](https://hyak.uw.edu/) **klone** HPC cluster — a leaf/spine fabric of ~30 switches carrying cluster management, Science DMZ, Open OnDemand, and Ceph storage traffic. It is derived from NVIDIA/Cumulus consulting's [goldenturtle](https://gitlab.com/cumulus-consulting/goldenturtle) demo automation, adapted to a production MLAG fabric.

> [!NOTE]
> **This is a sanitized public mirror**, published as a working example of real production infrastructure code. All secrets — switch user passwords, Cumulus license keys, and vault-encrypted values — have been replaced with the placeholder `secret_sanitized`, and device MAC addresses with `mac_sanitized`. Addressing is **obfuscated rather than removed**: subnet boundaries and prefix lengths are real, but every host address has been consistently remapped to a random address within its subnet — so the network topology reads true while no address identifies a real device. It is meant to be read, not run: use it as a reference for structuring profile-driven Ansible management of a switch fabric.

## What it does

The fabric is a set of **spine** (core) and **leaf** switches managed entirely from this repository: every switch's `/etc/network/interfaces`, FRR routing config, ebtables ACLs, and base system services are rendered from templates and variables, so the running network is reproducible from git.

- **Interface profiles, not per-port config.** `group_vars/all/interfaces.yml` defines reusable port profiles (`leaf_spine_interface`, `server_ports`, `ceph_oob_ports_mlag`, …); each switch's `host_vars` file is just a list of `{ port, profile }` mappings plus its management addressing. Changing a class of ports means editing one profile.
- **MLAG switch pairs.** Bond/bridge profiles in `mlagbonds.yml` and the `interfaces` role templates render MLAG peering, bonds, and bridge VLAN membership for redundant leaf pairs.
- **FRR/BGP routing** via the `frr` role, with support for BGP unnumbered peer-groups, VRFs, and EVPN/VXLAN (loopback VTEP addressing is wired through `vxlan_local_loopback_subnet`).
- **Data-plane ACLs.** The `ebtables` role deploys the Science DMZ filtering rules (`group_vars/all/100G-core-acls.yml`) on the 100G core switches — SSH/GridFTP/Globus ingress, LDAP/Kerberos/DNS pinholes, and management-VLAN isolation.
- **Base system services** — hostname, MOTD/login banner, DNS, SSH hardening, PTM, SNMP, syslog forwarding, NTP, and (optional, currently disabled) TACACS+ and NetQ roles.
- **Licensing and secrets.** Switches are grouped in the inventory by Cumulus license SKU; each group pulls its license key from an Ansible Vault variable in `group_vars/license_vault_access/vault`. The `cumulus` user password is likewise vaulted and enforced on every run.
- **Config backup.** The `backup` role snapshots each switch's rendered `/etc/network/interfaces` and FRR config back into the repository tree.

## Repository layout

```
hosts                        # inventory: leaf/spine groups + per-license-SKU groups
playbooks/deploy.yml         # main playbook; every role has a same-named tag
group_vars/all/              # fabric-wide profiles: interfaces, vlans, mlag bonds, ACLs, services
group_vars/*_vault_access/   # vaulted secrets (user password, license keys)
host_vars/<switch>           # per-switch: mgmt addressing + port -> profile map
roles/                       # one role per concern (interfaces, frr, ebtables, snmp, ...)
```

## Usage

Run everything from the repo root — `ansible.cfg` sets the inventory, roles path, and vault password file path.

```bash
# Full fabric deploy
ansible-playbook playbooks/deploy.yml

# Just interfaces and routing, on one leaf pair
ansible-playbook playbooks/deploy.yml -t interfaces,frr -l 'klone-eth-leaf-6h09-*'

# Back up running configs into the repo
ansible-playbook playbooks/backup_files.yml
```

## Author

University of Washington Research Computing Systems Engineering Team
