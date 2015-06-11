require 'action_callback'

class BuildingUI
  WIDTH = 400
  HEIGHT = 600
  LEFT = 100
  TOP = 100

  attr_accessor :my_dialog
  attr_accessor :action_callbacks

  def initialize
    @my_dialog = UI::WebDialog.new("building", true, "", WIDTH, HEIGHT, LEFT, TOP, true)
    @action_callbacks = []
    html_path = Sketchup.find_support_file "index.html" ,"Plugins/su_building/html"
    @my_dialog.set_file(html_path)

    @my_dialog.min_height = @my_dialog.max_height = HEIGHT
    @my_dialog.min_width = @my_dialog.max_width = WIDTH

    add_callbacks
  end

  def add_callbacks
    logger_callback = ActionCallback.new('logger') do |action, params|
      model = Sketchup.active_model
      model.save $SKP_PATH + "/tmp.skp"#, options_hash
    end


    list_callback = ActionCallback.new('list') do |action, params|
      files = Dir.glob($SKP_PATH + "/*").join("\n")
      $logger.debug "files from ruby " + files

      js_command = "var dom = document.getElementById('skp_names'); angular.element(dom).scope().skp_names = '#{files}';"
      @my_dialog.execute_script(js_command)
    end

    @action_callbacks << logger_callback
    @action_callbacks << list_callback
    @action_callbacks.each do |c|
      @my_dialog.add_action_callback(c.name) do |action, params|
        $logger.debug "callback for #{c.name} called with params #{params}"
        c.callback.call c.name, params
      end
    end
  end


  def show
    @my_dialog.show()
  end

end
