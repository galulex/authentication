class CarmenCountryInput < SimpleForm::Inputs::Base
  def input
    @builder.send(:"country_select", attribute_name, input_options, input_html_options)
  end
end
