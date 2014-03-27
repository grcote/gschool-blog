xml.instruct!
xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do
  xml.title "Gerard Cote's gSchool Blog"
  xml.subtitle "My journey to becoming a Rails developer"
  xml.id "http://gerards-gschool-blog.herokuapp.com/"
  xml.link "href" => "http://gerards-gschool-blog.herokuapp.com/"
  xml.link "href" => "http://gerards-gschool-blog.herokuapp.com/feed.xml", "rel" => "self"
  xml.updated blog.articles.first.date.to_time.iso8601
  xml.author { xml.name "Gerard Cote" }

  blog.articles[0..5].each do |article|
    xml.entry do
      xml.title article.title
      xml.link "rel" => "alternate", "href" => article.url
      xml.id article.url
      xml.published article.date.to_time.iso8601
      xml.updated article.date.to_time.iso8601
      xml.author { xml.name "Gerard Cote" }
      xml.summary article.summary, "type" => "html"
      xml.content article.body, "type" => "html"
    end
  end
end