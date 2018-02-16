class LabelController < ShopifyApp::AuthenticatedController
  def show
    order_id = params[:id]
    @order = ShopifyAPI::Order.find(order_id)
    @pdf_url = "/pdf.pdf?id=#{order_id}"
    @order_url = "#{params[:protocol]}#{params[:shop]}/admin/orders/#{order_id}"

#     html = <<-END
# <p>
# Gabriel Gagnon<br>
# 363 Rue des Prairies<br>
# Beloeil QC J3G 5N1<br>
# Canada<br>
# </p>
# END
#     kit = PDFKit.new(html, :page_height => '280mm', :page_width => '890mm', :print_media_type => true, :dpi => 1300, :'margin-bottom' => 0, :'margin-left' => 0, :'margin-top' => 20, :'margin-right' => 0)
#     temp = Tempfile.new(['test', '.pdf'])
#     file = kit.to_file(temp.path)
#     @pdf_path = temp.path


  # pdf_filename = File.join(Rails.root, "tmp/my_pdf_doc.pdf")
  # send_file(pdf_filename, :filename => "your_document.pdf", :disposition => 'inline', :type => "application/pdf")

  end

  def formatAddress(address)
    string = ''
    string << address.name + '<br>'
    string << address.address1 + '<br>'
    if !address.address2.blank?
      string << address.address2 + '<br>'
    end
    string << "#{address.city} #{address.province_code} #{address.zip}<br>"
    string << address.country + '<br>'
    string.html_safe
  end

  def pdf
    order_id = params[:id]
    @order = ShopifyAPI::Order.find(order_id)
    @address = formatAddress(@order.shipping_address)
    @size = @order.shipping_address.address2.blank? ? 'large' : 'small'

    margins = {
      top: 0,
      bottom: 0,
      left: 0,
      right: 0
    }

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "pdf_template", page_height: 28, page_width: 89, dpi: 400, print_media_type: true, margin: margins
      end
    end
  end
end
