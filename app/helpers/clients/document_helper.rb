module Clients::DocumentHelper
  def expired_date(document)
    expired = ((Date.parse document.due_date.to_s) - (Date.parse Time.now.to_s)).to_i

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
