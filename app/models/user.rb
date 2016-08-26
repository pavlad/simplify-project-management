class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable
  # belongs_to :company
  has_many :tasks
  has_many :assignments
  has_many :projects, through: :assignments
  has_many :lead_projects, class_name: "Project", foreign_key: :project_manager_id
  validates :first_name, presence: true
  validates :last_name, presence: true

  include AlgoliaSearch

  algoliasearch do
    attribute :first_name, :last_name, :email, :job_title, :mobile_phone, :phone, :description
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def first_date
    self.tasks.order(:start_date).first.start_date
  end

  def last_date
    self.tasks.order(:end_date).last.end_date
  end

  def find_tasks_in_array(project)
    array = []
    normal_array = project.tasks.where(project.users == self)
    normal_array.each do |task|
      if task.has_date?
        array << [task.name, task.start_date, task.end_date]
      end
    end
    array << ["Total time", first_date, last_date]
    return array
  end

  def get_color_tasks(project)
    array = []
    normal_array = project.tasks.where(project.users == self)
    normal_array.each do |task|
      if task.has_date?
        array << task.color
      end
    end
    array << "#ffffff"
    return array
  end

end

