class HomeController < ApplicationController
  #layout "application_home"
  #
  #layout :determine_layout
  #private
  #def determine_layout
  #( rand(100)%2 == 0 )? "event_open" : "event_closed"
  #end

  def index
    @question = Question.new

    @carousels = Carousel.all
    @showrooms = Showroom.all
    @shutters = Shutter.all
    @home_setting = HomeSetting.last
    @diyi, @dangjian, @dier, @disan = [], [], [], []
    @home_content = HomeContent.first

    if @home_setting
      @diyi = get_sections(@home_setting.diyi) 
      @dangjian = get_sections(@home_setting.dangjian) 
      @dier = get_sections(@home_setting.dier) 
      @disan = get_sections(@home_setting.disan) 
    end
    render :layout => "application_zchome"
  end
  

  private
    def get_sections(section) 
      obj = []
      unless section.blank?
        secd_ids = ''
        section.strip.split(';').each do |content|
          secd_ids += content.split(',')[0] + ','
        end
        ids = secd_ids.split(',')
        secds = Secd.find(ids)
        obj = ids.collect {|id| 
          record = secds.detect {|secd| secd.id.to_s == id}
          articles = []
          record.articles.limit(10).order('pdt_date DESC').each do |article|
            articles << {
              :id => article.id,
              :title => article.title,
              :content => article.content.gsub(/(<.+?>)|(<\/.+?>)/, ""),
              :pdt_date => article.pdt_date.strftime('%Y-%m-%d')
            }
          end
          {
            :id => record.id,
            :name => record.name,
            :articles => articles
          }
        }
      end
      obj
    end

end
