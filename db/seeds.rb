# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

role = Role.create(:name => Setting.roles.super_admin)

admin_permissions = Permission.create(:name => Setting.permissions.super_admin, :subject_class => Setting.admins.class_name, :action => "manage")

role.permissions << admin_permissions

user = User.new(:phone => Setting.admins.phone, :password => Setting.admins.password, :password_confirmation => Setting.admins.password)
user.save!

user.roles = []
user.roles << role

AdminUser.create!(:phone => Setting.admins.phone, :email => Setting.admins.email, :password => Setting.admins.password, :password_confirmation => Setting.admins.password)

#@user = User.create!(:phone => "15763703188", :password => "15763703188", :password_confirmation => "15763703188")

###区分厂区和集团用户是为了sidebar显示
@role_fct = Role.where(:name => Setting.roles.role_fct).first
@role_grp = Role.where(:name => Setting.roles.role_grp).first

@role_article    = Role.where(:name => Setting.roles.role_article).first
@role_carousel    = Role.where(:name => Setting.roles.role_carousel).first
@role_showroom    = Role.where(:name => Setting.roles.role_showroom).first
@role_homectn    = Role.where(:name => Setting.roles.role_homectn).first
@role_frst    = Role.where(:name => Setting.roles.role_frst).first
@role_homeset    = Role.where(:name => Setting.roles.role_homeset).first
@role_spider    = Role.where(:name => Setting.roles.role_spider).first
@role_wxtool    = Role.where(:name => Setting.roles.role_wxtool).first

##厂区管理者
@fctmgn = [@role_fct, @role_article, @role_carousel, @role_showroom, @role_homectn]
##集团管理者
@grp_mgn = [@role_grp, @role_article, @role_carousel, @role_showroom, @role_homectn, @role_frst, @role_homeset,  @role_spider,  @role_wxtool]

@gscmpy = Company.create!(:area => "嘉祥县", :name => "嘉祥水务")
@gcfct = Factory.create!(:area => "嘉祥县", :name => "嘉祥水务", :company => @gsfct, :lnt => 116.131779, :lat => 35.765957, :design => 20000)

User.create!(:phone => "053701016688", :password => "jxsw7799", :password_confirmation => "jxsw7799", :name => "嘉祥水务", :roles => @fctmgn,  :factories => [@gcfct])


all_factories = Factory.all
user.factories << all_factories

#集团管理
grp_mgn = User.create!(:phone => "9116688", :password => "swjt911", :password_confirmation => "swjt911", :name => "水务集团管理者", :roles => @grp_mgn, :factories => all_factories)


HomeContent.create
HomeSetting.create

@spider1 = Spider.create("doc_save"=>"false", "doc_parse"=>"true", "cookie"=>"", "agent"=>"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/63.0.3239.84 Chrome/63.0.3239.84 Safari/537.36", "content_type"=>"application/x-www-form-urlencoded")
Selector.create("name"=>".album__list-item.js_album_item.js_wx_tap_highlight.wx_tap_cell", "title"=>"data-link", "category"=>"1", "file"=>"false", :spider => @spider1)
@spider2 = Spider.create("doc_save"=>"false", "doc_parse"=>"true", "cookie"=>"", "agent"=>"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/63.0.3239.84 Chrome/63.0.3239.84 Safari/537.36", "content_type"=>"application/x-www-form-urlencoded")
Selector.create("name"=>"#activity-name", "title"=>"标题", "category"=>"0", "file"=>"false", :spider => @spider2)
Selector.create("name"=>"#js_content", "title"=>"内容", "category"=>"3", "file"=>"false", :spider => @spider2)
Selector.create("name"=>".rich_pages.wxw-img", "title"=>"data-src", "category"=>"2", "file"=>"true", :spider => @spider2)
@spiderdt = Spider.create("link"=>"https://www.dtdjzx.gov.cn/", "page"=>"", "doc_save"=>"false", "doc_parse"=>"true", "cookie"=>"", "agent"=>"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/63.0.3239.84 Chrome/63.0.3239.84 Safari/537.36", "content_type"=>"application/x-www-form-urlencoded")
Selector.create("name"=>".right.topline a", "title"=>"href", "category"=>"1", "file"=>"false", :spider => @spiderdt)
Selector.create("name"=>".right.topline a p.h1", "title"=>"内容", "category"=>"0", "file"=>"false", :spider => @spiderdt)

Matter.create(:title => "水费查询", :background => "ff571d", :icon => "search")
Matter.create(:title => "网上缴费", :background => "00aad9", :icon => "credit-card")
Matter.create(:title => "业务办理指南", :background => "3a86fa", :icon => "envelope-open-o")
Matter.create(:title => "网上报装申请", :background => "00a1b4", :icon => "desktop")


Engine.create(:template => Setting.engines.zctmpt, :consult => true, :des1 => '地址：邹城市太平西路1333号 邮编：273500', :des2 => '邹城市自来水有限公司丨鲁ICP备17022608号-1 鲁公网安备37088302000254号')
