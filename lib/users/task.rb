def arraying_tasks(tasks)
  array = []
  tasks.each do |task|
    array << [task.name, "2016-04-03", "2016-05-03"]
  end
  return array
end
