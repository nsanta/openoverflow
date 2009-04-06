module CustomMatchers
  class HaveMany
    def initialize(association_name,options={})
      @options = options
      @association_name = association_name
      @association_class_name = @association_name.to_s.classify
    end

    def matches?(model_class)
      @model_class = model_class
      @expected_association_results = {
        :macro => :has_many,
        :options => @options,
        :class_name => @options[:class_name] || @association_class_name
      }
      response = @model_class.reflect_on_association(@association_name)
      return fail("#{@association_name} is not a valid association for #{@model_class.to_s}") if response.nil? or !response.respond_to?(:to_hash)
      @association_hash = response.to_hash
      if @association_hash[:options][:extend] and @association_hash[:options][:extend] == []
        @association_hash[:options].delete(:extend)
      end
      return fail("macro did not match. Expected #{@expected_association_results[:macro].inspect} but got #{@association_hash[:macro].inspect}.") unless @association_hash[:macro] == @expected_association_results[:macro]
      return fail("class name did not match. Expected #{@expected_association_results[:class_name].inspect} but got #{@association_hash[:class_name].inspect}") unless ((@association_hash[:options][:class_name] || @association_hash[:class_name]) == @expected_association_results[:class_name])
      unless @options.empty?
        return fail("options did not match. Expected #{@expected_association_results[:options].inspect} but got #{@association_hash[:options].inspect}") unless @association_hash[:options] == @expected_association_results[:options]
      end
      return true
    end
    
    def failure_message
      @failure_message
    end

    def negative_failure_message
      "has many #{@association_name.to_s}"
    end

    def description
      "validate that a model has a particular has many association"
    end
    
    private
    
    def fail(message)
      @failure_message = message
      return false
    end
    
  end
end

def have_many(association_name,options={})
  CustomMatchers::HaveMany.new(association_name,options)
end
