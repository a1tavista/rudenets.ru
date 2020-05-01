class Publication
  class Post < Publication
    def reading_time
      meta_data["reading_time"]
    end
  end
end
