module Actions
  module Index
    extend ActiveSupport::Concern
    include Actions::Base

    def index
      @total = index_query.offset(nil).limit(nil).count
      @models = index_query.to_a
    end

    protected

    def index_query
      apply_scopes(model_class).all
    end
  end
end
