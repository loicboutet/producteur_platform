module CartHelper
  def current_cart
    session_id = session.id.to_s
    @current_cart ||= Cart.for_session(session_id, current_user)
  end
end
