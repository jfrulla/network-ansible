
## ebtables Role

Adds rule files to /etc/cumulus/acl/policy.d and loads with 'cl-acltool -i'

Iterates over the list ebtables_rules: 

ebtables_rules:
  - filename: filename in /etc/cumulus/acl/policy.d
    content: |
      String that contains
      contents of the rule 


