module InvoicesHelper
  def num_to_won(number)
    number_to_currency(number, unit: " 원", precision: 0, format: "%n %u")
  end
end