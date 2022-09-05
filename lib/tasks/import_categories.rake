require 'yaml'
require 'logger'

namespace 'db' do
  desc "import categorie"
  task(:import_categories => :environment) do
    categories = YAML.load_file("lib/tasks/data/categories.yaml")
    
    categories.each do |category|
      frst = category[0].to_s
      @frst = Frst.find_by_name(frst)
      if !@frst
        @frst = Frst.create(:name => frst)
      end
    
      if !category[1].nil?
        category[1].each do |c|
          secd = c[0].to_s
          index_page = c[1]
          @secd = Secd.find_by_name(secd)
          if !@secd
            @secd = Secd.create(:name => secd, :frst => @frst, :index_page => index_page)
          else
            @secd.update_attributes(:frst => @frst, :index_page => index_page)
          end
        end
      end
    end
  end
end
