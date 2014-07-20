require 'ankusa'
require 'ankusa/memory_storage'

class Cschat::MessageClassifier
  def initialize data
    @storage    = Ankusa::MemoryStorage.new
    @classifier = Ankusa::NaiveBayesClassifier.new @storage
    @listeners  = {}
    data.each { |action, text| @classifier.train action.to_sym, text } if data
  end

  def classify text
    if text
      category = @classifier.classify text
      notify_all :process_message, category, text
    end
  end

  def listener(listener, category = nil)
    if listener
      category_sym = category && category.to_sym
      @listeners[category_sym] ||= []
      @listeners[category_sym]  << listener
    end
    self
  end

  private
  def notify_all(method, category, text)
    listeners(category, include_defaults: true).each { |o| o.send method, category, text }
  end

  def listeners(category, include_defaults: false)
    category_listeners = @listeners[category] || []
    default_listeners  = (include_defaults && @listeners[nil]) || []
    (category_listeners + default_listeners).uniq
  end
end
