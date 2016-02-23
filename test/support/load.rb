def load_first_group_business 
  business = Business.create!(name: "Load First Business")
  group = Group.create!(name: "Load First Business Admin", business_id: business.id)
  Membership.create!(group_id: group.id, user_id: User.find_by(email: "login@user.com").id)
end