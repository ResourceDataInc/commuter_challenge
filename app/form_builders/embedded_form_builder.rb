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
    @template.content_tag :div, id: id, class: "btn-group", data: { toggle: "buttons-radio" } do
      yield
    end
  end

  def toggle_button(text, value, options = {})
    input_class = "btn"
    input_class << " active" if options[:active]
    @template.button_tag text, type: :button, class: input_class, value: value
  end
end
