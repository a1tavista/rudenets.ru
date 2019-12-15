module Posts
  class RemovePost
    include Dry::Transaction

    map :initialize_records
    step :remove_post

    def initialize_records(input)
      {
        post: input[:post] || Post.find_by(input[:post_find_by]),
        attributes: input[:attributes]
      }
    end

    def remove_post(input)
      input[:post].destroy!
      Success(input)
    end
  end
end
