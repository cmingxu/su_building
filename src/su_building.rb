require 'sketchup'
require 'fileutils'
require 'logger'

VERSION = [1, 0, 0].join(".")

# global varible set app in debuging mode or not
$DEBUG = true

$PLATFORM = (RUBY_PLATFORM =~ /darwin/ ? "MACOS" : "WINDOWS")

# directory we working on 
$ROOT_PATH = File.expand_path(File.join(File.dirname(__FILE__), "su_building"))

# add ruby file path into loading pathes
$LOAD_PATH.push(File.join($ROOT_PATH,  "ruby"))

$SKP_PATH = File.expand_path(File.join($ROOT_PATH , "skps"))
FileUtils.mkdir_p($SKP_PATH)
FileUtils.chmod(0777, $SKP_PATH)

# load required rb files
require 'ui'



## Logger 
$TMP_FILE_PATH = $ROOT_PATH + "/tmp"
FileUtils.mkdir_p($TMP_FILE_PATH)
FileUtils.chmod(0777, $TMP_FILE_PATH)
# setup logger for logging purpose
$logger = Logger.new File.join($TMP_FILE_PATH,  "logger.log")
$logger.debug "Initializing APP"

# Add a menu item to launch our plugin.
UI.menu("Plugins").add_item("Buildings") do
  Sketchup.extensions.map do |e|
    $logger.debug e.name
    $logger.debug e.version
  end
end


UI.menu("Plugins").add_item("Active  Models") do
  model = Sketchup.active_model
  $logger.debug model
  $logger.debug model.materials
  $logger.debug model.materials.length
  entities = model.entities[0]
  entities.add_line([0,0,0], [500, 500, 0])
   UI.add_context_menu_handler do |context_menu|
   context_menu.add_item("Hello World") {
     UI.messagebox("Hello world")
   }
 end
end




UI.menu("Plugins").add_item("Faces ") do
  depth = 100
  width = 100
  model = Sketchup.active_model
  entities = model.active_entities
  pts = []
  pts[0] = [0, 0, 0]
  pts[1] = [width, 0, 0]
  pts[2] = [width, depth, 0]
  pts[3] = [0, depth, 0]

  # Add the face to the entities in the model
  face = entities.add_face(pts)
  connected = face.all_connected
  face.material = Sketchup::Color.new(255, 255, 0)
end


UI.menu("Plugins").add_item("Show ") do
  BuildingUI.new.show
end

#require "extensions.rb" # Load plugin as extension (so that user can disable it)
#my_plugin_loader = SketchupExtension.new "My_Plugin Loader", "my_plugin/my_plugin.rb"
#my_plugin_loader.copyright= "Copyright 2011 by Me"
#my_plugin_loader.creator= "Me, myself and I"
#my_plugin_loader.version = "1.0"
#my_plugin_loader.description = "Description of plugin."
#Sketchup.register_extension my_plugin_loader, true 
