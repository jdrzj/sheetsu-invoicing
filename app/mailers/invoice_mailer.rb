class InvoiceMailer < ActionMailer::Base
  default from: 'ckim0706@gmail.com'

  def send_invoice(invoice)
    @invoice = invoice
    pdf = InvoicePdf.new(invoice)   # I assume that you have already created the class to generate PDF
    attachments['invoice.pdf'] = {
         :content => pdf.render,
         :mime_type => 'application/pdf'
    }
    mail(to: "#{invoice.email}",
         subject: "Invoice ##{invoice.id} dated on #{invoice.invoice_month}")
  end

end