module Representable
  # Created at class compile time. Keeps configuration options for one property.
  class Definition
    attr_reader :name, :options
    alias_method :getter, :name
    
    def initialize(sym, options={})
      @name     = sym.to_s
      @options  = options
    end

    def setter
      :"#{name}="
    end
    
    def typed?
      sought_type.is_a?(Class) or representer_module  # also true if only :extend is set, for people who want solely rendering.
    end
    
    def array?
      options[:collection]
    end
    
    def hash?
      options[:hash]
    end
    
    def sought_type
      options[:class]
    end
    
    def from
      (options[:from] || name).to_s
    end
    
    def default
      options[:default] ||= [] if array?  # FIXME: move to CollectionBinding!
      options[:default]
    end
    
    def representer_module
      options[:extend]
    end
    
    def attribute
      options[:attribute]
    end

    def include_nil
      options[:include_nil]
    end
  end
end
