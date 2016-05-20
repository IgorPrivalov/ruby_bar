module CoctailesHelper

  def form_ingredients(form_builder, field_name_num, field_name_col, method, collection, value_method, text_method, options = {}, html_options = {})
    form_builder.fields_for :ingredients do |form_builder|
      "<div class='field form-group'>
        <div class='field form-group'>
           #{form_field_row_collection_select(form_builder,field_name_col, method, collection, value_method, text_method, options, html_options)}
           #{form_field_row_numeric(form_builder, field_name_num)}
        </div>
     </div>".html_safe
    end
  end

end