class ExportFileService
  def initialize()
    puts "ExportFileService initialized"
  end
  def arr_to_csv(args)
    arr = args[:arr]
    headers = args[:headers]||[]
    separator = args[:separator] || ";"
    file_name = args[:file_name]||"#{Date.today}_#{SecureRandom.hex}.csv"
    save_path = Rails.root.join('tmp', "#{file_name }")
    encoding =  args[:encoding]||"ISO8859-1"
    author_id =  args[:author_id] || ""
    CSV.open(save_path,'wb+', col_sep: separator, encoding: encoding) do |writer|
      errors = []
      arr.each_with_index do |item, index|
        if index == 0 && headers.size == item.size
          writer << headers.to_a
        end
        begin
          writer << item.to_a
        rescue
          errors << item
        end
      end
      if errors.present?
        ItMailer.generic_alert("Algunos datos solicitados por user_id: #{author_id} no pudieron ser codificados #{errors}", emails: ['soporte@hogaru.com']).deliver_later
      end
    end
    return [save_path, file_name]
  end
end