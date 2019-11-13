unless Rails.env.development?
  class ForbiddenDBSeedError < StandardError; end
  raise ForbiddenDBSeedError,
        "You should not seed the #{Rails.env} environment database."
end


# the production environment as this file (wich contains clear text passwords)
# is available at the Git repository.
User.create!([
               {
                 # Admin
                 # E-mail doesn't have to be valid as no e-mails are sent
                 # in the development environment (we're using Letter Opener)

                 # Ordinary user (non-admin)
                 email: 'user4@test.com',
                 password: "testpass",
                 password_confirmation: "testpass",
                 role: :user,
                 first_name: 'Katie',
                 last_name: 'User',
                 confirmed_at: Time.zone.today,
               }, {
                   # Ordinary user (non-admin)
                   email: 'user5@test.com',
                   password: "testpass",
                   password_confirmation: "testpass",
                   role: :user,
                   first_name: 'Bob',
                   last_name: 'User',
                   confirmed_at: Time.zone.today,
               }, {
                   # Ordinary user (non-admin)
                   email: 'user6@test.com',
                   password: "testpass",
                   password_confirmation: "testpass",
                   role: :user,
                   first_name: 'Larry',
                   last_name: 'User',
                   confirmed_at: Time.zone.today,
               }
               ])
