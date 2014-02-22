module PathParamsHelper
  def params_for(path, real = false)
    params = []
    id = "xx"
    resourses = %w[department car driver user]
    path.split("_").each do |part|
      params << (real ? instance_variable_get("@#{part}").id : id) if resourses.include?(part)
    end
    params.compact
  end
end