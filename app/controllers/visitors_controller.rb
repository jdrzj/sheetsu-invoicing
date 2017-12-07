require 'sheetsu'

class VisitorsController < ApplicationController
	def index
		sheetsu = Sheetsu::Client.new("d67302530992")
		@client = sheetsu.read(limit: 10)
	end

	def show
		sheetsu = Sheetsu::Client.new("d67302530992")
		@invoice = sheetsu.read(search: { id: params['id'] })
	    respond_to do |format|
	      format.html
	      format.pdf do
	        pdf = InvoicePdf.new(@invoice[0])
	        send_data pdf.render, filename: "Invoice.pdf",
	                              type: "application/pdf",
	                              disposition: "inline"
	      end
	    end
	end

	def create
		@invoice = params['invoice']
	end

	def b2b
		@current_url = request.env['PATH_INFO']
		@sheetsu_slug = "439f368c9a0b"
		sheetsu = Sheetsu::Client.new("439f368c9a0b")
		@client = sheetsu.read
		data = @client
		@columns = data[0].keys
		@rows = data.map{ |row|
			@columns.map{ |col|
				row[col]
			}
		}
		@form_inputs = @columns.map{ |col_name|
			{
				input_name: col_name,
				input_type: 'text'
			}
		}
		@form_inputs += [
      {input_name: 'Timestamp', input_type: 'hidden'},
      {input_name: 'Delivery Date', input_type: 'datetime-local'},
      {input_name: 'Location', input_type: 'text'},
      {input_name: 'Additional Requests', input_type: 'text'}
    ]
	end

	def b2bform_submit
		sheetsu = Sheetsu::Client.new("439f368c9a0b")
		# CREATE NEW ROW FROM FORM SUBMIT on Order History Sheet
		# sheetsu.create({ "foo" => "bar", "baz" => "quux" }, "Order History")
	end

	def sendinvoice
		flash[:success] = 'Invoice was emailed.'
		@invoice = params['invoice']
		# InvoiceMailer.send_invoice(@invoice).deliver_now
		redirect_to root_path
	end
end
