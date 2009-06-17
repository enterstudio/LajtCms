module Radius
  #
  # The Radius parser. Initialize a parser with a Context object that
  # defines how tags should be expanded. See the QUICKSTART[link:files/QUICKSTART.html]
  # for a detailed explaination of its usage.
  #
  class Parser
    # The Context object used to expand template tags.
    attr_accessor :context
  
    # The string that prefixes all tags that are expanded by a parser
    # (the part in the tag name before the first colon).
    attr_accessor :tag_prefix
  
    # Creates a new parser object initialized with a Context.
    def initialize(context = Context.new, options = {})
      if context.kind_of?(Hash) and options.empty?
        options = context
        context = options[:context] || options['context'] || Context.new
      end
      options = Util.symbolize_keys(options)
      @context = context
      @tag_prefix = options[:tag_prefix]
    end

    # Parses string for tags, expands them, and returns the result.
    def parse(string)
      tokens = Scanner::operate(tag_prefix, string)
      stack_up(tokens).to_s
    end

    protected
    
    def stack_up(tokens)
      stack = [ParseContainerTag.new { |t| t.contents.to_s }]
      tokens.each do |t|
        if t.is_a? String
          stack.last.contents << t
          next
        end
        case t[:flavor]
        when :open
          stack.push(ParseContainerTag.new(t[:name], parse_attrs(t[:attrs])))
        when :self
          stack.last.contents << ParseTag.new { @context.render_tag(t[:name], parse_attrs(t[:attrs])) }
        when :close
          popped = stack.pop
          raise WrongEndTagError.new(popped.name, t[:name], stack) if popped.name != t[:name]
          popped.on_parse { |b| @context.render_tag(popped.name, popped.attributes) { b.contents.to_s } }
          stack.last.contents << popped
        when :tasteless
          raise TastelessTagError.new(t, stack)
        else
          raise UndefinedFlavorError.new(t, stack)
        end
      end
      raise MissingEndTagError.new(stack.last.name, stack) unless stack.length == 1
      stack.first
    end
    
    def parse_attrs(attrs)
      parsed_attrs = {}
      attrs.each { |k, v| parsed_attrs[k] = parse(v) }
      parsed_attrs
    end
  end
end