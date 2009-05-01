Factory.define(:user) do |f|
  f.sequence(:login) {|n| "test#{n}"}
  f.password 'abc123'
  f.sequence(:email) { |n| "test#{n}@test.com"}
  f.password_confirmation {|p| p.password}
end
