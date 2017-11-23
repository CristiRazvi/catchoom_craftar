module Symbolizable
  def symbolize_keys
    case self
    when Array
      self.inject([]){|res, val|
        res << case val
        when Hash, Array
          val.symbolize_keys
        else
          val
        end
        res
      }
    when Hash
      self.inject({}){|res, (key, val)|
        nkey = case key
        when String
          key.to_sym
        else
          key
        end
        nval = case val
        when Hash, Array
          val.symbolize_keys
        else
          val
        end
        res[nkey] = nval
        res
      }
    else
      self
    end
  end
end

module Hash::Symbolizable
  include Symbolizable
end

module Array::Symbolizable
  include Symbolizable
end

Hash.send(:include, Hash::Symbolizable)
Array.send(:include, Array::Symbolizable)
