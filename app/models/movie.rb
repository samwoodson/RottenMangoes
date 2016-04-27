class Movie < ActiveRecord::Base
  has_many :reviews

 validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past

  validate :movie_image

  mount_uploader :image, ImageUploader

  def movie_image
    poster_image_url.present? || image.present?
  end

  def review_average
    if reviews.size > 0
      reviews.sum(:rating_out_of_ten)/reviews.size
    end
  end

  # def self.search(search)
  #   if search
  #     find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
  #   else
  #     find(:all)
  #   end
  # end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end


end
