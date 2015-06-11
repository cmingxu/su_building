class ActionCallback
  attr_accessor :name, :callback

  def set_name name
    @name = name
  end

  def set_callback &block
    @callback = block
  end

  def initialize name, &block
    @name = name
    @callback = block
  end
end
