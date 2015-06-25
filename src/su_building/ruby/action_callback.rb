require 'json'

module ActionCallback
  def register_callbacks(dialog)
    dialog.add_action_callback('logger') do |action, params|
      $logger.debug params
    end

    dialog.add_action_callback('update_model_name') do |action, params|
      model = Sketchup.active_model
      $logger.debug params
      model.name = params
    end

    dialog.add_action_callback('list_local_skps') do |action, params|
      files = Dir.glob($SKP_PATH + "/*").map do |f|
        File.basename(f)
      end
      update_js_value(dialog, "skp_names", files.join(","))
    end

    dialog.add_action_callback('save_current_model') do |action, params|
      model = Sketchup.active_model
      model.save $SKP_PATH + model.name +  ".skp"
    end

    dialog.add_action_callback('current_model_change') do |action, params|
      model = Sketchup.active_model
      model_name = model.name

      thumbnail_path = File.join($ROOT_PATH, "images", "thumbnail.jpg")
      FileUtils.rm_f(thumbnail_path)
      $logger.debug thumbnail_path
      model.save_thumbnail(thumbnail_path)
      current_model = {:model_name => model_name, :thumbnail => "../images/" + File.basename(thumbnail_path) + "?#{Time.now.to_i}"}
      update_js_value(dialog, "current_model", current_model.to_json)
    end

  end

  def update_js_value(dialog, id, new_val)
    js_command = "var dom = document.getElementById('#{id}'); angular.element(dom).scope().#{id} = JSON.parse('#{new_val}');"
    $logger.debug js_command
    dialog.execute_script(js_command)
  end

  module_function :update_js_value, :register_callbacks
end


