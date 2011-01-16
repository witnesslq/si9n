module ApplicationHelper
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
    # #重复了？？？
    @current_user ||= User.find_by_id(cookies.signed[:user_id])
  end

  def current_user= (user)
    @current_user = user
  end

  def parent_layout(layout)
    @_content_for[:layout] = self.output_buffer
    self.output_buffer = render(:file => "layouts/#{layout}")
  end

  def link_to_with_class(*args)
    if current_page?(args[1])
      %Q!<li class='current ui-tabs-selected'><span>#{link_to(*args)}</span></li>!.html_safe
    else
      %Q!<li><span>#{link_to(*args)}</span></li>!.html_safe
    end
  end
  
end