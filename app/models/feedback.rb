class Feedback < ActiveRecord::Base

  # == Relations
  belongs_to :user

  # == Validations
  validates_presence_of :title, :body, :email

  # == Callbacks
  before_validation_on_create :set_user_email


  private

  def set_user_email
    self.email = self.user.email if self.user
  end

end
