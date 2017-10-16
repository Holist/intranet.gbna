class LdapService

  def users_sync
    recents_users = get_last_users(300)
    users = clean(recents_users)
    return 'nothing to import' if users.empty?
    create_users(users)
  end

  private

  def get_last_users(date = 30)
    last_users = []
    AdUser.all.each do |user|
      next if user.sAMAccountName.ends_with?('$')
      next if user.whenCreated < DateTime.now - date.days
      last_users << user
    end
    last_users
  end

  def clean(users)
    cleaned_users = []
    users.each do |user|
      next unless User.find_by_username(user.sAMAccountName).nil?
      cleaned_users << user
    end
    cleaned_users
  end

  def create_users(users)
    errors = []
    users.each do |user|
      u = User.new(
            email: user.mail,
            first_name: user.givenName,
            last_name: user.sn,
            password: ENV['DEFAULT_PASSWORD'],
            username: user.sAMAccountName,
            ldap_imported: true,
          )
      if u.valid?
        u.save
      else errors << u
        next
      end
    end
    errors unless errors.empty?
  end
end
