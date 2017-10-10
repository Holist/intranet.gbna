class AdGroup < ActiveLdap::Base
  ldap_mapping dn_attribute: "cn",
               prefix: "ou=AdGroups",
               classes: ["PosixGroup"]
end
