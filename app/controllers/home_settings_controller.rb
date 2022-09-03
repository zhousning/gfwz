class HomeSettingsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #authorize_resource

   
  def index
    #@home_setting = HomeSetting.new
   
    @home_settings = HomeSetting.all.page( params[:page]).per( Setting.systems.per_page )
   
  end
   

  def query_all 
    items = HomeSetting.all
   
    obj = []
    items.each do |item|
      obj << {
        #:factory => idencode(factory.id),
        :id => idencode(item.id),
       
        :diyi => item.diyi,
       
        :dangjian => item.dangjian,
       
        :dier => item.dier,
       
        :disan => item.disan
      
      }
    end
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end



   
  def show
   
    @home_setting = HomeSetting.find(iddecode(params[:id]))
   
  end
   

   
  def new
    @secds = Secd.all
    @home_setting = HomeSetting.new
    
  end
   

   
  def create
    @home_setting = HomeSetting.new(home_setting_params)
     
    if @home_setting.save
      redirect_to :action => :index
    else
      render :new
    end
  end
   

   
  def edit
   
    @secds = Secd.all
    @home_setting = HomeSetting.find(iddecode(params[:id]))
   
  end
   

   
  def update
   
    @home_setting = HomeSetting.find(iddecode(params[:id]))
   
    if @home_setting.update(home_setting_params)
      redirect_to home_setting_path(idencode(@home_setting.id)) 
    else
      render :edit
    end
  end
   

   
  def destroy
   
    @home_setting = HomeSetting.find(iddecode(params[:id]))
   
    @home_setting.destroy
    redirect_to :action => :index
  end
   

  

  

  
  
  

  private
    def home_setting_params
      params.require(:home_setting).permit( :diyi, :dangjian, :dier, :disan , :logo , :avatar , :photo , enclosures_attributes: enclosure_params)
    end
  
    def enclosure_params
      [:id, :file, :_destroy]
    end
  
  
  
end

