class <%= class_name.pluralize %>Controller < ApplicationController
  respond_to :html

  <% views.each do |view| %>
  def <%= view %>

  end
  <% end %>

end
