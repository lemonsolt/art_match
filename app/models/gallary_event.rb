class GallaryEvent < ApplicationRecord
  belongs_to :gallary
  has_many :event_bookmarks, dependent: :destroy
  has_one_attached :image

  validates :title, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :introduction, presence: true
  validate :start_at_must_be_before_end_at

  enum recruit:{
    募集終了:0,募集中:1,開催中:2,展示終了:3
  }
  
  before_save :update_recruit_status_start_at
  before_save :update_recruit_status_end_at
  

  def image_or_empty
    if self.image.attached? == false
      return "noimage_camera.jpg"
    else
      return image
    end
  end
  
  def start_at_must_be_before_end_at
    if start_at > end_at
      errors.add(:start_at, "は終了日時よりも前でなければなりません")
    end
  end
  
  def update_recruit_status_start_at
    if start_at == Date.today
      self.recruit = :開催中
    end
  end
  
  def update_recruit_status_end_at
    if end_at < Date.today
      self.recruit = :展示終了
    end
  end

  
end
