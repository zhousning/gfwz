class NewspapersController < ApplicationController
  layout "application_home"

  def list
    @secd = Secd.find(iddecode(params[:secd_id]))
    @frst = @secd.frst
    @secds = @frst.secds
    @articles = @secd.articles.order('pdt_date DESC').page( params[:page]).per( Setting.systems.per_page )
  end
   
  def info 
    @secd = Secd.find(iddecode(params[:secd_id]))
    @frst = @secd.frst
    @secds = @frst.secds
    @article = @secd.articles.find(iddecode(params[:id]))
  end

  def download_attachment 
    @article = Article.find(iddecode(params[:id]))
    @attachment_id = params[:number].to_i
    @attachment = @article.attachments[@attachment_id]

    if @attachment
      send_file File.join(Rails.root, "public", URI.decode(@attachment.file_url)), :type => "application/force-download", :x_sendfile=>true
    end
  end
  
  
end
