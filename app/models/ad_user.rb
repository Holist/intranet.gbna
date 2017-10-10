class AdUser < ActiveLdap::Base
  ldap_mapping dn_attribute: "uid",
               prefix: "ou=AdUsers",
               classes: ["person", "PosixAccount"]
end
