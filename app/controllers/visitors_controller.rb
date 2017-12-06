require 'sheetsu'

class VisitorsController < ApplicationController
	def index
		sheetsu = Sheetsu::Client.new("d67302530992")
		@client = sheetsu.read(limit: 10)
	end

	def show
		@invoice = params['invoice']
	    respond_to do |format|
	      format.html
	      format.pdf do
	        pdf = InvoicePdf.new(@invoice)
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
		sheetsu = Sheetsu::Client.new("439f368c9a0b")
		@client = sheetsu.read
	end

	def b2bform
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
