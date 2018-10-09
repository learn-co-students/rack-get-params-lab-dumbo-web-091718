class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart= []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end

    elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end

    elsif req.path.match(/add/)
      item = req.params["item"]
      if @@items.include?(item)
        @@cart << item 
        resp.write "Successfully added #{item}"
      else
        resp.write "We don't have that item"
      end

    elsif req.path.match(/search/)

      search_term = req.params["q"]
      resp.write handle_search(search_term)

      ## WHAT KIND OF METHOD IS 'HANDLE_SEARCH'?
      ##                          = > class instance method
      ## but if it is a class instance method..
      ## only an instance of the class may use it
      ## here, what is using it?
      ## the method is called by ...?

    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

end
