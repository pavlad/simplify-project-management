class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # belongs_to :company
  has_many :tasks
  has_many :assignments
  has_many :projects, through: :assignments
  has_many :projects
  has_many :lead_projects, class_name: "Project", foreign_key: :project_manager_id
end
