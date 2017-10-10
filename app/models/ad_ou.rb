class AdOu < ActiveLdap::Base
  ldap_mapping dn_attribute: "cn",
               prefix: "",
               classes: ["organizationalUnit"]
end
