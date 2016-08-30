class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :invitable
  # belongs_to :company
  has_many :tasks
  has_many :timelines
  has_many :assignments
  has_many :projects, through: :assignments
  has_many :lead_projects, class_name: "Project", foreign_key: :project_manager_id
  validates :first_name, presence: true
  validates :last_name, presence: true
  has_attachment :avatar, dependent: :destroy


  include AlgoliaSearch

  algoliasearch do
    attribute :first_name, :last_name, :email, :job_title, :mobile_phone, :phone, :description
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def first_date
    self.tasks.order(:start_date).select{|task| task.has_date?}.first.start_date
  end

  def last_date
    self.tasks.order(:end_date).select{|task| task.has_date?}.last.end_date
  end

  def find_tasks_in_array(project)
    array = []
    normal_array = project.tasks.select{ |task| task.user = self}
    normal_array.each do |task|
      if task.has_date?
        array << [task.name, task.start_date, task.end_date]
      end
    end
    array << ["Total time", self.first_date, self.last_date]
    return array
  end

  def get_color_tasks(project)
    array = []
    normal_array = project.tasks.select{ |task| task.user = self}
    normal_array.each do |task|
      if task.has_date?
        array << task.color
      end
    end
    array << "#ffffff"
    return array
  end

  def has_tasks?
    return self.tasks.select{|task| task.is_done == false}.count > 0
  end

  def status
    self.has_tasks? ? "Busy" : "On the bench"
  end

  def status_class
    self.has_tasks? ? "ui green label" : "ui yellow label"
  end

  def tasks_count
    return self.tasks.count
  end

  def tasks_done_count
    return self.tasks.select{|task| task.is_done}.count
  end


end

