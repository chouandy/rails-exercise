module VisibleAttributes
  extend ActiveSupport::Concern

  included do
    def visible_attributes
      visible_attributes = attributes.delete_if do |key, _value|
        key.in? self.invisible_attributes
      end
      visible_attributes
    end

    # override by model
    def invisible_attributes
      []
    end
  end
end
