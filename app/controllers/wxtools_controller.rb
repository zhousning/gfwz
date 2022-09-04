class WxtoolsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #authorize_resource

   
  def index
    @wxtool = Wxtool.new
   
    @wxtools = Wxtool.all.page( params[:page]).per( Setting.systems.per_page )
   
  end

  def start 
    Wxtool.all.each do |wxtool|
      @secd = Secd.find(wxtool.secd_id)
      link = wxtool.link

      @first_spider = Spider.first
      @second_spider = Spider.second
      @first_spider.link = link
      spider_tool = SpiderTool.new
      first_result = spider_tool.process(@first_spider) 

      @first_selector = @first_spider.selectors.first
      @second_selectors = @second_spider.selectors

      first_result[@first_selector.name + '$' + @first_selector.title].each do |link|
        @second_spider.link = link
        second_result = spider_tool.process(@second_spider) 
        title = second_result[@second_selectors[0].name + '$' + @second_selectors[0].title][0].strip
        content = second_result[@second_selectors[1].name + '$' + @second_selectors[1].title][0].strip
        puts title + '  ' + content
        content.gsub!("visibility: hidden;", '')
        Article.create!(:title => title, :pdt_date => Date.today, :content => content, :secd => @secd)
      end
    end
    redirect_to articles_path 
  end
   
   

  def query_all 
    items = Wxtool.all
   
    obj = []
    items.each do |item|
      obj << {
        #:factory => idencode(factory.id),
        :id => idencode(item.id),
       
        :name => item.name,
       
        :link => item.link,
       
        :secd_id => item.secd_id,
       
        :desc => item.desc
      
      }
    end
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end



   
  def show
   
    @wxtool = Wxtool.find(iddecode(params[:id]))
   
  end
   

   
  def new
    @wxtool = Wxtool.new
    
  end
   

   
  def create
    @wxtool = Wxtool.new(wxtool_params)
     
    if @wxtool.save
      redirect_to :action => :index
    else
      render :new
    end
  end
   

   
  def edit
   
    @wxtool = Wxtool.find(iddecode(params[:id]))
   
  end
   

   
  def update
   
    @wxtool = Wxtool.find(iddecode(params[:id]))
   
    if @wxtool.update(wxtool_params)
      redirect_to edit_wxtool_path(idencode(@wxtool.id)) 
    else
      render :edit
    end
  end
   

   
  def destroy
   
    @wxtool = Wxtool.find(iddecode(params[:id]))
   
    @wxtool.destroy
    redirect_to :action => :index
  end
   

  

  

  
  
  

  private
    def wxtool_params
      params.require(:wxtool).permit( :name, :link, :secd_id, :desc)
    end
  
  
  
end

