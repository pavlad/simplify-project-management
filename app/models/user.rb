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

  def full_name
    "#{first_name} #{last_name}"
  end
end
