module Posts
  class Remove
    include Dry::Transaction

    map :initialize_records
    step :remove_post

    def initialize_records(input)
      {
        publication: input[:publication] || Publication::Post.find_by(input[:post_find_by]),
        attributes: input[:attributes],
      }
    end

    def remove_post(input)
      input[:publication].destroy!
      Success(input)
    end
  end
end
