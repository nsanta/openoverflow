Factory.define(:question) do |f|
 f.title "title"
 f.body "body"
 f.association :user
end
