class ArraySerializer < ActiveModel::ArraySerializer
  def initialize(models, options = {})
    super(models, options.merge(root: 'models', meta_key: :total))
  end
end
