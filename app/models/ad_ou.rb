class AdOu < ActiveLdap::Base
  ldap_mapping  :dn_attribute => 'OU', :prefix => '', :classes => ['organizationalUnit']
end
