Factory.define(:favorite) do |f|
  f.association :user
  f.association :question
end
