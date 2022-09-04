class ArticleWorker
  include Sidekiq::Worker

  def perform
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
        title_result = second_result[@second_selectors[0].name + '$' + @second_selectors[0].title][0]
        content_result = second_result[@second_selectors[1].name + '$' + @second_selectors[1].title][0]
        imgs_result = second_result[@second_selectors[2].name + '$' + @second_selectors[2].title]
        title, content = '', ''

        if title_result.nil? 
          next
        else
          title = title_result.strip
        end

        if content_result.nil?
          next
        else
          content = content_result.strip
        end

        content.gsub!("visibility: hidden;", '')
        if imgs_result.size > 0 
          arr = content.split(/<img[^>]+>/)
          str = ''
          arr.each_with_index do |item, index|
            img = ''
            img = "<img class='img-fluid' src='" + imgs_result[index] + "'>" unless imgs_result[index].nil?
            str += item + img 
          end
          content = str
        end

        @article = Article.find_by_title(title)
        Article.create!(:title => title, :pdt_date => Date.today, :content => content, :secd => @secd) unless @article
      end
    end
  end 

end
