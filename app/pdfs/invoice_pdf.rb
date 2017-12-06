class InvoicePdf < Prawn::Document

  TABLE_ROW_COLORS = ["FFFFFF","DDDDDD"]
  TABLE_FONT_SIZE = 9
  TABLE_WIDTHS = [20, 100, 30, 60]
  
  def initialize(invoice)
    super(top_margin: 70)
    @invoice = invoice
    font_update
    
    header
    # body 
    # footer
  end

#------------------------------------------------------

  def font_update
    font_families.update(
      "Unbatang" => { :normal => Rails.root.join('app/assets/fonts/unbatang.ttf').to_s,
                      :bold => Rails.root.join('app/assets/fonts/unbatangbold.ttf').to_s 
                    }
    )
    font "Unbatang"
  end

#------------------------------------------------------
  
  def header
    text "청구서", size: 18, align: :center, :style=>:bold
    # invoice_to
    # recipient
    # invoice_month
    # invoice_due_date
  end

  # def invoice_to
  #   move_down 20
  #   text "#{@invoice['Name']}"
  # end

  # def recipient 
  #   move_up 10
  #   text "#{@invoice.Name} 귀하", align: :right
  # end

  # def invoice_month
  #   move_down 10
  #   text "#{@invoice.invoice_month}"
  # end

  # def invoice_due_date
  #   move_up 10
  #   text "납부기한 : #{@invoice.invoice_due_date}", align: :right
  # end

#------------------------------------------------------

  def body
    move_down 30
    invoice_table
  end

  def invoice_table
    data = [[{:content => "항목", :colspan => 2, align: :center}, {:content => "금액", :colspan => 2, align: :center}],

            [{:content => "임대료 관리비\n #{@invoice.electric_month}", :rowspan => 4, valign: :center, align: :center}, {:content => "임대료", align: :center}, {:content => "#{@invoice.rent}", :colspan => 2, align: :right}],
            [{:content => "관리비", align: :center}, {:content => "#{@invoice.management_fee}", :colspan => 2, align: :right}],
            [{:content => "부가세", align: :center}, {:content => "#{@invoice.tax_1}", :colspan => 2, align: :right}],
            [{:content => "소계", align: :center}, {:content => "#{@invoice.subtotal_1}", :colspan => 2, align: :right}],

            [{:content => "전기료\n #{@invoice.rent_usage_date}", :rowspan => 3, valign: :center, align: :center}, {:content => "전기료", align: :center}, {:content => "#{@invoice.electric_fee}", :colspan => 2, align: :right}],
            [{:content => "부가세", align: :center}, {:content => "#{@invoice.tax_2}", :colspan => 2, align: :right}],
            [{:content => "소계", align: :center}, {:content => "#{@invoice.subtotal_2}", :colspan => 2, align: :right}],

            [{:content => "상하수도료", :colspan => 2, align: :center}, {:content => "#{@invoice.water_fee}", :colspan => 2, align: :right}],
            [{:content => "당월부과액", :colspan => 2, align: :center}, {:content => "#{@invoice.total}", :colspan => 2, align: :right}]]

    table data, :cell_style => { :width => 135 }, 
                :position => :center
  end

#------------------------------------------------------

  def footer
    move_down 20
    account_info
    late_fee_warning
    created_at
    stamp
  end

  def account_info
    move_down 20
    text "위 금액을 #{@invoice.account_location} #{@invoice.account_number} (#{@invoice.account_name}) 계좌로 입금시켜 주시기 바랍니다.", size: 12, align: :center, :style=>:bold
  end

  def late_fee_warning
    move_down 20
    text "납기일 경과시 3% 연체료가 부과됩니다.", size: 10, align: :center
  end

  def created_at
    move_down 20
    text "#{@invoice.invoice_creation_date}", align: :center
  end

  def stamp
    move_down 20
    y_position = cursor
    text " XX건물 대표  김 XX", align: :center
    image "#{Rails.root}/app/assets/images/stamp.png", width: 20, height: 20, :at => [340, y_position]
  end

end