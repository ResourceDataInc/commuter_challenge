module DomHelper
  include ActionView::RecordIdentifier

  def selector_for(model)
    "##{dom_id(model)}"
  end
end
