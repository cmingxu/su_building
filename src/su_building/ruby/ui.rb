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
    ActionCallback.register_callbacks(@my_dialog)
  end


  def show
    @my_dialog.show
  end

end
