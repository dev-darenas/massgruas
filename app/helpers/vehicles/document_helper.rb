module Vehicles::DocumentHelper
  def expired_date(document)
    if document.due_date.to_s.blank?
      expired=6
    else
      expired = ((Date.parse document.due_date.to_s) - (Date.parse Time.now.to_s)).to_i
    end

    if expired <= 0 && !document.renewable
      @expired = "<div class='alert alert-danger' role='alert'>
                    Tiene Documentos vencidos!
                  </div>"
    else
      @expired= ''
    end
  end

  def expired
    @expired
  end

end
