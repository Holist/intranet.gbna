class AdGroup < ActiveLdap::Base
  ldap_mapping :dn_attribute => 'sAMAccountName', :prefix => '', :classes => ['group']
end
