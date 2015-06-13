class ActionCallback
  JS_DOM_CHANNELS  = %w(skp_names current_model)
  attr_accessor :name, :callback, :dialog
  @@callbacks = []

  def self.callbacks
    @@callbacks
  end

  def set_name name
    @name = name
  end

  def set_callback &block
    @callback = block
  end

  def initialize dialog, name, &block
    @dialog = dialog
    @name = name
    @callback = block
    @@callbacks << self
  end

  def update_js_value(id, new_val)
    js_command = "var dom = document.getElementById('#{id}'); angular.element(dom).scope().#{id} = '#{new_val}';"
    @dialog.execute_script(js_command)
  end

end



ActionCallback.new('update_model_name') do |action, params|
  model = Sketchup.active_model
  model.name = params
end
ActionCallback.new('list_local_skps') do |action, params|
  files = Dir.glob($SKP_PATH + "/*").map do |f|
    File.basename(f)
  end
  update_js_value("skp_names", files.join(","))
end


ActionCallback.new('save_current_model') do |action, params|
  model = Sketchup.active_model
  model.save $SKP_PATH + model.name +  ".skp"
end

