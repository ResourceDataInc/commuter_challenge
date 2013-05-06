module DomHelper
  include ActionController::RecordIdentifier

  def selector_for(model)
    "##{dom_id(model)}"
  end
end
