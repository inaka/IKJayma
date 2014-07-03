require "singleton"

module IKJayma
  class Contact

    def initialize(args)
      @id = args[:id]
      @name = args[:name]
      @email = args[:email]
      @phone = args[:phone]
    end
    
    def to_hash
      hash = Hash.new(0)
      hash[:id] = @id if @id
      hash[:name] = @name if @name
      hash[:email] = @email if @email
      hash[:phone] = @phone if @phone
      hash
    end

    def id=(new_id)
      @id = new_id
    end

    def id
      @id
    end

    def name
      @name
    end

    def matches?(params)
      if params[:id]
        return false unless @id == params[:id]
      end
      if params[:name]
        return false unless @name.start_with?(params[:name])
      end
      if params[:email]
        return false unless @email
        return false unless @email.start_with?(params[:email])
      end
      if params[:phone]
        return false unless @phone
        return false unless @phone.start_with?(params[:phone])
      end
      true
    end

    def update!(args)
      @name = args[:name]
      @email = args[:email]
      @phone = args[:phone]
    end

  end
end
