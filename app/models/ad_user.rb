class AdUser < ActiveLdap::Base
  ldap_mapping :dn_attribute => 'sAMAccountName', :prefix => '', :classes => ['person', 'user']
  belongs_to :groups, :class_name => 'AdGroup', :many => 'member', :primary_key => 'distinguishedName'
end
