class ArraySerializer < ActiveModel::ArraySerializer
  self.root = 'models'

  def initialize(models, options = {})
    super(models, options.merge(meta_key: :total))
  end
end
