class Movie < ActiveRecord::Base

 validates :title,
        presence: true

      validates :director,
        presence: true

      validates :runtime_in_minutes,
        numericality: { only_integer: true }

      validates :description,
        presence: true

      validates :poster_image_url,
        presence: true

      validates :release_date,
        presence: true

      validate :release_date_is_in_the_past

      protected

      def release_date_is_in_the_past
        if release_date.present?
          errors.add(:release_date, "should be in the past") if release_date > Date.today
        end
      end


end
