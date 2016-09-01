# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Task.destroy_all
Assignment.destroy_all
Project.destroy_all
User.destroy_all

############################ User seed ##################################################

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
    job_title: "Managing Director",
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

############################ Project seed ##################################################


projects = [
  {
    name: "IT strategy redefinition",
    man_days: 123,
    description: "",
    project_manager_id: User.all.map{|user| user.id}.sample
  },
  {
    name: "Market research of tiles in Gent",
    man_days: 120,
    description: "",
    project_manager_id: User.all.map{|user| user.id}.sample
  },
  {
    name: "New Product development",
    man_days: 60,
    description: "",
    project_manager_id: User.all.map{|user| user.id}.sample
  },
  {
    name: "Implentation strategy",
    man_days: 200,
    description: "",
    project_manager_id: User.all.map{|user| user.id}.sample
  }
]

projects.each do |project|
  Project.create(project)
end

############################ Assignment seed ##################################################

Project.all.each do |project|
  4.times do
    user_id = User.all.select{ |user| user.id != project.project_manager_id}.map{|user| user.id}.sample
    Assignment.create(project_id: project.id, user_id: user_id)
  end
end

#Tasks

#Project 1

project = Project.all[0]

tasks_list = [
      {
        name:"Kick-off Meeting",
        start_date: "2016-10-12",
        end_date: "2016-10-12",
        user_id: project.users.sample.id
      },
      {
        name:"Interview stakeholders",
        start_date: "2016-10-13",
        end_date: "2016-10-17",
        user_id: project.users.sample.id
      },
      {
        name:"Write business requirements",
        start_date: "2016-10-14",
        end_date: "2016-12-06",
        user_id: project.users.sample.id
      },
      {
        name:"Write final report",
        start_date: "2016-12-06",
        end_date: "2016-12-30",
        user_id: project.users.sample.id
      }
    ]

tasks_list.each do |task|
  project.tasks.build(task).save
end

#Project 2

project = Project.all[1]

tasks_list = [
      {
        name:"Kick-off Meeting",
        start_date: "2016-10-12",
        end_date: "2016-10-12",
        user_id: project.users.sample.id
      },
      {
        name:"Interview inhabitants of Gent",
        start_date: "2016-10-13",
        end_date: "2016-10-17",
        user_id: project.users.sample.id
      },
      {
        name:"Best practice analysts",
        start_date: "2016-10-14",
        end_date: "2016-12-06",
        user_id: project.users.sample.id
      },
      {
        name:"Write final report",
        start_date: "2016-12-06",
        end_date: "2016-12-30",
        user_id: project.users.sample.id
      }
    ]

tasks_list.each do |task|
  project.tasks.build(task).save
end

#Project 3

project = Project.all[2]

tasks_list = [
      {
        name:"Kick-off Meeting",
        start_date: "2016-10-12",
        end_date: "2016-10-12",
        user_id: project.users.sample.id
      },
      {
        name:"Interview users",
        start_date: "2016-10-13",
        end_date: "2016-10-17",
        user_id: project.users.sample.id
      },
      {
        name:"Develop issue tree",
        start_date: "2016-10-14",
        end_date: "2016-12-06",
        user_id: project.users.sample.id
      },
      {
        name:"Write final report",
        start_date: "2016-12-06",
        end_date: "2016-12-30",
        user_id: project.users.sample.id
      }
    ]

tasks_list.each do |task|
  project.tasks.build(task).save
end

#Project 4

project = Project.all[3]

tasks_list = [
      {
        name:"Kick-off Meeting",
        start_date: "2016-10-12",
        end_date: "2016-10-12",
        user_id: project.users.sample.id
      },
      {
        name:"Interview stakeholders",
        start_date: "2016-10-13",
        end_date: "2016-10-17",
        user_id: project.users.sample.id
      },
      {
        name:"Write business requirements",
        start_date: "2016-10-14",
        end_date: "2016-12-06",
        user_id: project.users.sample.id
      },
      {
        name:"Write final report",
        start_date: "2016-12-06",
        end_date: "2016-12-30",
        user_id: project.users.sample.id
      }
    ]

tasks_list.each do |task|
  project.tasks.build(task).save
end

############################ Client seed ##################################################

clients_list = [
  {
    name: "AXA",
    address: "#{Faker::Address.street_address}. #{Faker::Address.city}. #{Faker::Address.country}",
    phone: Faker::PhoneNumber.cell_phone,
    email: Faker::Internet.email,
    website: "http://www.axa.com"
    },
  {
    name: "Google",
    address: "#{Faker::Address.street_address}. #{Faker::Address.city}. #{Faker::Address.country}",
    phone: Faker::PhoneNumber.cell_phone,
    email: Faker::Internet.email,
    website: "http://www.google.com"
    },
  {
    name: "Twitter",
    address: "#{Faker::Address.street_address}. #{Faker::Address.city}. #{Faker::Address.country}",
    phone: Faker::PhoneNumber.cell_phone,
    email: Faker::Internet.email,
    website: "http://www.twitter.com"
    },
  {
    name: "adidas",
    address: "#{Faker::Address.street_address}. #{Faker::Address.city}. #{Faker::Address.country}",
    phone: Faker::PhoneNumber.cell_phone,
    email: Faker::Internet.email,
    website: "http://www.adidas.com"
    },
  {
    name: "Le Wagon",
    address: "#{Faker::Address.street_address}. #{Faker::Address.city}. #{Faker::Address.country}",
    phone: Faker::PhoneNumber.cell_phone,
    email: Faker::Internet.email,
    website: "http://www.lewagon.com"
    }
  ]

clients_list.each do |client|
  Client.create(client)
end





