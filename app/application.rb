class Application
  @@items = []

  def call(env)
    req = Rack::Request.new(env)
    resp = Rack::Response.new

    if req.path.match(/items/)
      item_handler(req.path, resp)
    else
      resp.status = 404
      resp.write "Route not found"
    end

    resp.finish
  end

  def item_handler(path, resp)
    item = path.split("/items/").last
    found_item = @@items.detect{ |i| i.name == item }
    if found_item
      resp.write found_item.price
    else
      resp.write "Item not found"
      resp.status = 400
    end
  end

end
