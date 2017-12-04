require 'sheetsu'

class VisitorsController < ApplicationController
	def index
		sheetsu = Sheetsu::Client.new("d67302530992")
		@client = sheetsu.read(limit: 10)
	end

	def b2b
		sheetsu = Sheetsu::Client.new("439f368c9a0b")
		@client = sheetsu.read
	end

	def b2bform
		sheetsu = Sheetsu::Client.new("439f368c9a0b")
		sheetsu.create({ "foo" => "bar", "baz" => "quux" }, "Order History")

	end

	def sendinvoice
		@invoice = params['data']
		InvoiceMailer.send_invoice(@invoice).deliver_now
		flash[:success] = 'Invoice was emailed.'
		redirect_to root
	end
end
