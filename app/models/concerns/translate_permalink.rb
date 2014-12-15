module TranslatePermalink
  extend ActiveSupport::Concern

  included do
    class_attribute :permalink_attributes, :permalink_field, :before_methods, :after_methods
    after_save :create_permalink

    def create_permalink
      if self.permalink.nil?
        chinese_permalink = self.class.permalink_attributes.collect do |attr_name|
          self.send(attr_name)
        end * '-'
        self.class.before_methods.each do |method|
          chinese_permalink = self.send(method, chinese_permalink)
        end

        english_permalink = Translator.t(chinese_permalink)
        self.class.after_methods.each do |method|
          english_permalink = self.send(method, english_permalink)
        end

        self.update_attribute(self.class.permalink_field, english_permalink.parameterize)
      end
    end
  end

  module ClassMethods
    def translate_permalink(attr_names, options = {})
      options = { permalink_field: 'permalink' }.merge(options)
      self.permalink_attributes = Array(attr_names)
      self.permalink_field = options[:permalink_field]
      self.before_methods = Array(options[:before_methods])
      self.after_methods = Array(options[:after_methods])
    end
  end

  class Translator
    class <<self
      def t(text)
        self.translator.translate(text, to: 'en')
      end

      def translator
        @translator ||= BingTranslator.new(ENV['BING_APP_ID'], ENV['BING_APP_SECRET'], false, ENV['BING_ACCOUNT_KEY'])
      end
    end
  end
end
