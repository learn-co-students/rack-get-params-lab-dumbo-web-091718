require "pry"

class Application
  #   Create a new class array called @@cart to hold any items in your cart
  # Create a new route called /cart to show the items in your cart
  # Create a new route called /add that takes in a GET param with the key item. This should check to see if that item is in @@items and then add it to the cart if it is. Otherwise give an error

  @@cart = []

  @@items = %w[Apples Carrots Pears Figs]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path =~ /items/
      @@items.each do |item|
        resp.write "#{item}\n"
      end
      #------cart----------
    elsif req.path =~ /cart/
      if @@cart.length >= 1
        @@cart.each do |item|
          resp.write "#{item}\n"
        end

      else
        resp.write 'Your cart is empty'
    end
    #-----end cart------------

    #------add-----------------

  elsif req.path.match(/add/)
    search_term = req.params['q']
    if @@items.include?(search_term)
      @@cart << search_term
      resp.write "added #{search_term}\n"
    

    else
      resp.write "We don't have that item"
    end


    #-------end add--------------


    elsif req.path =~ /search/
      search_term = req.params['q']
      resp.write handle_search(search_term)
    else
      resp.write 'Path Not Found'
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      "#{search_term} is one of our items"
    else
      "Couldn't find #{search_term}"
    end
  end
end
