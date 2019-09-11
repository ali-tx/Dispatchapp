class RequestController < ApplicationController
  @request= Request.where(:user_id => current_user.id )
end
