module Actions
  module Index
    extend ActiveSupport::Concern
    include Actions::Base

    def index
      render json: index_query, meta: {total: index_query.offset(nil).limit(nil).count},
             serializer: ArraySerializer, each_serializer: serializer_class,
             scope: current_user
    end

    protected

    def index_query
      apply_scopes(model_class).all
    end
  end
end
