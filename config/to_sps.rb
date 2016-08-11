require 'active_record'

module ToSps
  def to_sps
  end
end

ActiveRecord::Base.extend ToSps

class ActiveRecord::Relation
  def to_sps
    scoping do
      @klass
    end
  end
end



   