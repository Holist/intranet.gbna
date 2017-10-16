class LdapService

  def self.users_sync
    imported_users = []
    AdUser.all.each do |user|
      next if user.sAMAccountName.ends_with?('$')
      next if user.whenCreated < DateTime.now - 30.days
      imported_users << user
    end;nil

    users_to_be_created = []

    imported_users.each do |user|
      next unless User.find_by_username(user.sAMAccountName).nil?
      users_to_be_created << user
    end;nil

    users_to_be_created.each do |user|
      User.create(
        email: user.mail,
        first_name: user.givenName,
        last_name: user.sn,
        password: user.objectSid,
        username: user.sAMAccountName,
        ldap_imported: true,
      )
    end;nil
  end

end
