module WelcomeHelper

  def coctaile_thumbnail(coctailes)
    out = ''
    coctailes.each do |coctaile|
     out += "<div class='col-sm-2'>
       <div class='thumbnail'>
        <div class='field form-group'>
         #{link_to image_tag(coctaile.image_url, class: 'img-thumbnail'),action: 'show_coctaile', controller: 'welcome', id: coctaile.id}
         #{link_to coctaile.price, welcome_path(coctaile), class: 'btn btn-success', role: 'button'}
        </div>
         <div class='caption'>
           <h3> #{coctaile.name} </h3>
           <p>"
            coctaile.products.each do |product|
              out += "#{link_to product.name, welcome_path(product), class: 'btn btn-info', role: 'button'}"
            end
            out += "</p>
         </div>
       </div>
     </div>"
    end
    out.html_safe
  end
end
