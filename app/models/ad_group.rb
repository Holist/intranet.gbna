class AdGroup < ActiveLdap::Base
  ldap_mapping :dn_attribute => 'sAMAccountName', :prefix => '', :classes => ['group']
  has_many :members, :wrap => 'member', :class_name => 'AdUser', :primary_key => 'distinguishedName'
end
