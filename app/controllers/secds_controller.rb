class SecdsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #authorize_resource

   
  def index
    @secd = Secd.new
   
    #@secds = Secd.all.page( params[:page]).per( Setting.systems.per_page )
   
  end
   

  def query_all 
    items = Secd.all
   
    obj = []
    items.each do |item|
      obj << {
        #:factory => idencode(factory.id),
        :id => idencode(item.id),
       
        :name => item.name,
       
        :sequence => item.sequence,
       
        :index_page => item.index_page,
       
        :show_page => item.show_page
      
      }
    end
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end



   
  def show
   
    @secd = Secd.find(iddecode(params[:id]))
   
  end
   

   
  def new
    @secd = Secd.new
    
  end
   

   
  def create
    @secd = Secd.new(secd_params)
     
    if @secd.save
      redirect_to :action => :index
    else
      render :new
    end
  end
   

   
  def edit
   
    @secd = Secd.find(iddecode(params[:id]))
   
  end
   

   
  def update
   
    @secd = Secd.find(iddecode(params[:id]))
   
    if @secd.update(secd_params)
      redirect_to secd_path(idencode(@secd.id)) 
    else
      render :edit
    end
  end
   

   
  def destroy
   
    @secd = Secd.find(iddecode(params[:id]))
   
    @secd.destroy
    redirect_to :action => :index
  end
   

  

  

  
  
  

  private
    def secd_params
      params.require(:secd).permit( :name, :sequence, :index_page, :show_page , :sidebar , :header)
    end
  
  
  
end

