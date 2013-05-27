class EmbeddedFormBuilder < SimpleForm::FormBuilder
  def label(*args)
    options = args.extract_options!
    options[:class].delete("control-label")
    args << options
    super
  end

  def input(*args)
    options = args.extract_options!
    options[:wrapper] = :simple
    args << options
    super
  end

  def button_group(id)
    @button_group_id = id
    content = hidden_field(id)
    content += @template.content_tag :div, id: id, class: "btn-group", data: { toggle: "buttons-radio" } do
      yield
    end
    @button_group_id = nil
    content
  end

  def toggle_button(text, value, options = {})
    input_class = "btn"
    input_class << " active" if @object.send(@button_group_id) == value
    @template.button_tag text, type: :button, class: input_class, value: value
  end
end
