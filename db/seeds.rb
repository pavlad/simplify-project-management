# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
job_titles = ["Analyst","Senior Analyst","Consultant","Senior Consultant","Manager","Partner"]

20.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create(
    first_name: first_name,
    last_name: last_name,
    job_title: job_titles.sample,
    phone: Faker::PhoneNumber.phone_number,
    email: "#{first_name}.#{last_name}@lewagon-consulting.org",
    password: "lewagon"
    )
end

simplify_team = [
  {
    first_name: "Phan",
    last_name: "Pak",
    job_title: "Partner",
    phone: "0488/232323",
    email: "phan.pak@lewagon-consulting.org",
    password: "lewagon"
  },
  {
    first_name: "Lukas",
    last_name: "Gutwinski",
    job_title: "Manager",
    phone: "0488/234567",
    email: "lukas.gutwinski@lewagon-consulting.org",
    password: "lewagon"
  },
  {
    first_name: "Vladimir",
    last_name: "Pav",
    job_title: "Consultant",
    phone: "0488/654378",
    email: "vladimir.pav@lewagon-consulting.org",
    password: "lewagon"
  }
]

simplify_team.each do |user|
  User.create(user)
end
